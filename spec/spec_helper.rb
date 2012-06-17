$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'acts_as_sweepable'
require 'mocha'

RSpec.configure do |config|
  config.mock_with :mocha
end

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database  => ":memory:"
)

ActiveRecord::Schema.define do
    create_table :cool_elements do |table|
      table.text :name
      table.timestamps
    end
end

ActiveRecord::Schema.define do
    create_table :int_elements do |table|
      table.text :name
      table.integer :timestamp
    end
end

class CoolElement < ActiveRecord::Base; end
class IntElement  < ActiveRecord::Base; end