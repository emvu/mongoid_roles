module Mongoid
  module Roles
    module Subject
      extend ActiveSupport::Concern

      included do
        embeds_many :roles, :class_name => 'Mongoid::Roles::Role'
    
        # subject.has_role?(role, object = nil). Returns true of false (has or has not).
        delegate :has_role?,          :to => :roles
    
        # Unassigns a role from the subject.
        delegate :has_no_role!,       :to => :roles
    
        # Does the subject has any roles for object? (true of false)
        delegate :has_roles_for?,     :to => :roles
    
        # Same as has_roles_for?.
        delegate :has_role_for?,      :to => :roles
    
        # Returns an array of Role instances, corresponding to subject ’s roles on
        # object. E.g. subject.roles_for(object).map(&:name).sort will give you role names in alphabetical order.
        delegate :roles_for,          :to => :roles
    
        # Unassign any subject ’s roles for a given object.
        delegate :has_no_roles_for!,  :to => :roles
    
        # Unassign all roles from subject.
        delegate :has_no_roles!,      :to => :roles
      end
  
      module ClassMethods

        # find all subjects which has given role for given object
        def with_role role, object
          c = where('roles.auth_object_type' => object.class.name, 'roles.role' => role)
          c.selector['roles.auth_object_id'] = object.id.to_s # FIX, we want string instead of object_id...
          return c
        end

      end
  
      # Assigns a role for the object to the subject. 
      # Does nothing is subject already has such a role.
      def has_role! (role, auth_object = nil)
        # p roles.find(:role => role, :auth_object => auth_object).first
        auth_object ?
          roles.find_or_create_by(:role => role, :auth_object_id => auth_object.id.to_s, :auth_object_type => auth_object.class.name) :
          roles.find_or_create_by(:role => role, :auth_object_id => nil, :auth_object_type => nil)
          
      end
    end
  end
end