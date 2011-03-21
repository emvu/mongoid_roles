class User
  include Mongoid::Document
  include Mongoid::Roles::Subject
  
  field :name
end