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

module ActiveRecord
  module Inheritance
    module ClassMethods
      undef :new

      def new(attributes = nil, options = {}, &block)
        if abstract_class? || self == Base
          raise NotImplementedError, "#{self} is an abstract class and cannot be instantiated."
        end

        if has_attribute?(inheritance_column)
          subclass = subclass_from_attributes(attributes)

          if respond_to?(:column_defaults) && subclass.nil? && base_class == self
            subclass = subclass_from_attributes(column_defaults)
          end
        end

        if subclass && subclass != self
          subclass.new(attributes, options, &block)
        else
          super
        end
      end
    end
  end
end
