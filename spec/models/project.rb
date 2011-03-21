class Project
  include Mongoid::Document
  include Mongoid::Roles::Object
  
  field :name
end