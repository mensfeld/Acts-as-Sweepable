require 'spec_helper'

ROOT = File.expand_path(File.dirname(__FILE__))

class CoolElement < ActiveRecord::Base
end

describe CoolElement do
  subject { CoolElement }

  before(:each){ CoolElement.destroy_all}

  context "when object is old enough" do
    it "should be sweeped" do
      el = subject.create(:created_at => 10.days.ago)
      subject.sweep('9d')
      subject.all.count.should eql(0)
      el = subject.create(:created_at => 10.hours.ago)
      subject.sweep('9h')
      subject.all.count.should eql(0)
      el = subject.create(:created_at => 10.minutes.ago)
      subject.sweep('9m')
      subject.all.count.should eql(0)
      el = subject.create(:created_at => 10.minutes.ago, :updated_at => 1.minutes.ago)
      subject.sweep('9m')
      subject.all.count.should eql(0)
      el = subject.create(:created_at => 1.minutes.ago, :updated_at => 10.minutes.ago)
      subject.sweep('9m')
      subject.all.count.should eql(0)
    end 
  end

  context "when object is not old enough" do
    it "should not be sweeped" do
      el = subject.create(:created_at => 10.days.ago)
      subject.sweep('11d')
      subject.all.count.should eql(1)
      el = subject.create(:created_at => 10.minutes.ago)
      subject.sweep('11m')
      subject.all.count.should eql(1)
      el = subject.create(:created_at => 10.hours.ago)
      subject.sweep('11h')
      subject.all.count.should eql(2)
    end
  end
  
  context "when we add additional parameter" do
    it "should be used" do
      el1 = subject.create(:created_at => 10.days.ago, :name => 'First')
      el2 = subject.create(:created_at => 10.days.ago, :name => 'Second')
      subject.sweep('9d', 'name LIKE "Second"')
      subject.all.count.should eql(1)
      subject.all.first.name.should eql "First"
    end
  end

  context "when we use only updated_at" do
    it "should sweep old objects" do
      el = subject.create(:updated_at => 10.days.ago)
      subject.sweep('9d', nil, false)
      subject.all.count.should eql(0)
    end

    it "should not sweep recently updated objects" do
      el = subject.create(:updated_at => 1.days.ago, :created_at => 10.days.ago)
      subject.sweep('9d', nil, false)
      subject.all.count.should eql(1)  
    end
  end

  context "When we sweep smthg" do
    it "should be able to perform on each" do
      2.times { |i| subject.create(:created_at => 10.days.ago, :name => i.to_s) }
      saved = []
      subject.sweep('1d') do |el|
        saved << el.name      
      end
      saved.first.to_i.should eql(0)
      saved.last.to_i.should eql(1)
    end
  end

end
