if ActiveRecord::VERSION::MAJOR >= 6

  module ActiveRecord
    class AssociationRelation
      undef :new
      undef :create
      undef :create!

      def build(attributes = nil, options = {}, &block)
        block = _deprecated_scope_block("new", &block)
        scoping { @association.build(attributes, options, &block) }
      end
      alias new build

      def create(attributes = nil, options = {}, &block)
        block = _deprecated_scope_block("create", &block)
        scoping { @association.create(attributes, options, &block) }
      end

      def create!(attributes = nil, options = {}, &block)
        block = _deprecated_scope_block("create!", &block)
        scoping { @association.create!(attributes, options, &block) }
      end
    end
  end

end
