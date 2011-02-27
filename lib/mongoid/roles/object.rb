module Mongoid
  module Roles
    module Object
      extend ActiveSupport::Concern

      #  object.accepts_role?(role_name, subject). An alias for subject.has_role?(role_name, object).
      def accepts_role?(role_name, subject)
        subject.has_role?(role_name, self)
      end

      #  object.accepts_role!(role_name, subject). An alias for subject.has_role!(role_name, object).
      def accepts_role!(role_name, subject)
        subject.has_role!(role_name, self)
      end

      #  object.accepts_no_role!(role_name, subject). An alias for subject.has_no_role!(role_name, object).
      def accepts_no_role!(role_name, subject)
        subject.has_no_role!(role_name, self)
      end

      #  object.accepts_roles_by?(subject). An alias for subject.has_roles_for?(object).
      def accepts_roles_by?(subject)
        subject.has_roles_for?(self)
      end

      #  object.accepts_role_by?(subject). Same as accepts_roles_by?.
      def accepts_role_by?(subject)
        accepts_roles_by?(subject)
      end

      #  object.accepts_roles_by(subject). An alias for subject.roles_for(object).
      def accepts_roles_by(subject)
        subject.roles_for(self)
      end
    end
  end
end