module ActiveRecord
  module MassAssignmentSecurity
    module Inheritance
      extend ActiveSupport::Concern

      module ClassMethods

        private

        # Detect the subclass from the inheritance column of attrs. If the inheritance column value
        # is not self or a valid subclass, raises ActiveRecord::SubclassNotFound
        def subclass_from_attributes(attrs)
          active_authorizer[:default].deny?(inheritance_column) ? nil : super
        end
      end
    end
  end
end
