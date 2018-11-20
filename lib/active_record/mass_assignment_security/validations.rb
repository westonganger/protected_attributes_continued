require 'active_support/concern'

module ActiveRecord
  module MassAssignmentSecurity
    module Validations
      extend ActiveSupport::Concern

      module ClassMethods
        # Creates an object just like Base.create but calls <tt>save!</tt> instead of +save+
        # so an exception is raised if the record is invalid.
        def create!(attributes = nil, options = {}, &block)
          if attributes.is_a?(Array)
            attributes.collect { |attr| create!(attr,&block) }
          else
            object = new(attributes)
            yield(object) if block_given?
            object.save!
            object
          end
        end
      end
    end
  end
end
