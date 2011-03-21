require 'rubygems'
require 'rails/all'
require 'mongoid'
require 'bundler/setup'

require 'mongoid_roles'
require 'models/user'
require 'models/project'

Mongoid.configure do |config|
  host = "localhost"
  config.master = Mongo::Connection.new.db('mongoid_roles_test')
  config.persist_in_safe_mode = false
end

RSpec.configure do |config|
end