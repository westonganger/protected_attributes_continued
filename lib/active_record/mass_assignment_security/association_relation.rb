if ActiveRecord::VERSION::MAJOR >= 6

  module ActiveRecord
    class AssociationRelation
      undef :new
      undef :create
      undef :create!

      def build(attributes = nil, options = {}, &block)
        scoping { @association.build(attributes, options, &block) }
      end
      alias new build

      def create(attributes = nil, options = {}, &block)
        scoping { @association.create(attributes, options, &block) }
      end

      def create!(attributes = nil, options = {}, &block)
        scoping { @association.create!(attributes, options, &block) }
      end
    end
  end

end
