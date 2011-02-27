module Mongoid
  module Roles
    class Role
      include Mongoid::Document

      embedded_in   :auth_subject

      field :role,              :type => Symbol
      field :auth_object_type,  :type => String
      field :auth_object_id,    :type => String

      scope :find_role_with_object, lambda{|role, object| where(:role => role, :auth_object_type => object.class.name, :auth_object_id => object.id)}
      scope :find_object,           lambda{|object|       where(:auth_object_type => object.class.name, :auth_object_id => object.id)}
      # validates_uniqueness_of :name
  
      class << self
      
        # subject.has_role?(role, object = nil). Returns true of false (has or has not).
        def has_role? (role, object)
          find_role_with_object(role,object).count == 1
        end
       
        # subject.has_role!(role, object = nil). Assigns a role for the object to the subject. 
        # Does nothing is subject already has such a role.
        # IMPELEMENTED IN MongoidRoles::Subject
      
        # subject.has_no_role!(role, object = nil). Unassigns a role from the subject.
        def has_no_role! (role, object)
          find_role_with_object(role,object).destroy_all
        end
      
        # subject.has_roles_for?(object). Does the subject has any roles for object? (true of false)
        def has_roles_for? (object)
          find_object(object).count > 0
        end
      
        # subject.has_role_for?(object). Same as has_roles_for?.
        def has_role_for? (object)
          has_roles_for?(object)
        end
       
        # subject.roles_for(object). Returns an array of Role instances, corresponding to subject ’s roles on
        # object. E.g. subject.roles_for(object).map(&:name).sort will give you role names in alphabetical order.
        def roles_for (object)
          find_object(object)
        end

        # subject.has_no_roles_for!(object). Unassign any subject ’s roles for a given object.
        def has_no_roles_for! (object)
          find_object(object).destroy_all
        end
      
        # subject.has_no_roles!. Unassign all roles from subject.
        def has_no_roles!
          criteria.destroy_all
        end

      end
  
      def auth_object
        @auth_object ||= if auth_object_type && auth_object_id
          auth_object_type.constantize.find(auth_object_id)
        end
      end

      def auth_object=(auth_object)
        self.auth_object_type = auth_object.class.name
        self.auth_object_id   = auth_object.id
      end
    end
  end
end