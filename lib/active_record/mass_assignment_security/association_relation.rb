module ActiveRecord
  class AssociationRelation
    undef :new
    undef :create
    undef :create!

    def build(attributes = nil, options = {}, &block)
      block = protected_attributes_scope_block('new', block)
      scoping { @association.build(attributes, options, &block) }
    end
    alias new build

    def create(attributes = nil, options = {}, &block)
      block = protected_attributes_scope_block('create', block)
      scoping { @association.create(attributes, options, &block) }
    end

    def create!(attributes = nil, options = {}, &block)
      block = protected_attributes_scope_block('create!', block)
      scoping { @association.create!(attributes, options, &block) }
    end

    private

    if ActiveRecord.gem_version < Gem::Version.new('6.0')

      def protected_attributes_scope_block(_label, block)
        block
      end

    elsif ActiveRecord.gem_version < Gem::Version.new('6.1')

      def protected_attributes_scope_block(label, block)
        _deprecated_scope_block(label, &block)
      end

    else

      def protected_attributes_scope_block(_label, block)
        current_scope_restoring_block(&block)
      end

    end
  end
end
