require 'spec_helper'

ROOT = File.expand_path(File.dirname(__FILE__))

describe CoolElement do
  subject { CoolElement }

  before(:each){ CoolElement.destroy_all}

  context "when object is old enough" do
    it "should be sweeped" do
      el = subject.create(
        :created_at => 10.days.ago,
        :updated_at => 10.days.ago
      )
      subject.sweep(:time => '9d')
      subject.all.count.should eql(0)
      el = subject.create(
        :created_at => 10.hours.ago,
        :updated_at => 10.hours.ago
      )
      subject.sweep(:time => '9h')
      subject.all.count.should eql(0)
      el = subject.create(
        :created_at => 10.minutes.ago,
        :updated_at => 10.minutes.ago
      )
      subject.sweep(:time => '9m')
      subject.all.count.should eql(0)
      el = subject.create(
        :created_at => 10.minutes.ago,
        :updated_at => 1.minutes.ago
      )
      subject.sweep(:time => '9m', :columns => [:created_at])
      subject.all.count.should eql(0)
      el = subject.create(
        :created_at => 1.minutes.ago,
        :updated_at => 10.minutes.ago
      )
      subject.sweep(:time => '9m')
      subject.all.count.should eql(0)
    end 
  end

  context "when object is not old enough" do
    it "should not be sweeped" do
      el = subject.create(:created_at => 10.days.ago)
      subject.sweep(:time => '11d')
      subject.all.count.should eql(1)
      el = subject.create(:created_at => 10.minutes.ago)
      subject.sweep(:time => '11m', :columns => :created_at)
      subject.all.count.should eql(1)
      el = subject.create(:created_at => 10.hours.ago)
      subject.sweep(:time => '11h')
      subject.all.count.should eql(2)
    end
  end
  
  context "when we add additional parameter" do
    it "should be used" do
      el1 = subject.create(
        :created_at => 10.days.ago, :name => 'First')
      el2 = subject.create(
        :created_at => 10.days.ago,
        :updated_at => 10.days.ago,
        :name => 'Second'
      )
      subject.sweep(:time => '9d', :conditions => 'name LIKE "Second"')
      subject.all.count.should eql(1)
      subject.all.first.name.should eql "First"
    end
  end

  context "when we use only updated_at" do
    it "should sweep old objects" do
      el = subject.create(:updated_at => 10.days.ago)
      subject.sweep(:time => '9d', :active => false)
      subject.all.count.should eql(0)
    end

    it "should not sweep recently updated objects" do
      el = subject.create(:updated_at => 1.days.ago, :created_at => 11.days.ago)
      subject.all.count.should eql(1)  
      subject.sweep(:time => '9d')
      subject.all.count.should eql(1) 
    end
  end

  context "When we sweep smthg" do
    it "should be able to perform on each" do
      subject.expects(:destroy_all)
      2.times do |i|
        subject.create(
          :created_at => 10.days.ago,
          :updated_at => 10.days.ago,
          :name => i.to_s
        )
      end
      saved = []
      subject.sweep(:time => '1d') do |el|
        saved << el.name      
      end
      saved.first.to_i.should eql(0)
      saved.last.to_i.should eql(1)
    end
  end

  context 'when we want to delete instead of destroying' do
    it 'should use it instead of destroy' do
      2.times { |i| subject.create(:created_at => 10.days.ago, :name => i.to_s) }
      subject.expects(:delete_all)
      subject.sweep(:time => '1d', :method => :delete_all)
    end
  end

end

describe IntElement do
  subject { IntElement }

  before(:each){ IntElement.destroy_all}

  context 'when we have a integer timestamp' do
    it 'should work in a normal way' do
      el = subject.create(
        :timestamp => 10.days.ago.to_i
      )
      subject.sweep(:time => '9d', :format => :integer, :columns => :timestamp)
      subject.all.count.should eql(0)

      el = subject.create(:timestamp => 10.days.ago.to_i)
      subject.sweep(:time => '11d', :format => :integer, :columns => :timestamp)
      subject.all.count.should eql(1)
    end
  end
end
