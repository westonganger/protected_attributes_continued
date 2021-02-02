module ActiveRecord
  class AssociationRelation
    undef :new
    undef :create
    undef :create!

    def build(attributes = nil, options = {}, &block)
      if ActiveRecord::VERSION::STRING.to_f < 5.2
        scoping { @association.build(attributes, options, &block) }
      else
        @association.build(attributes, options, &block)
      end
    end
    alias new build

    def create(attributes = nil, options = {}, &block)
      if ActiveRecord::VERSION::STRING.to_f < 5.2
        scoping { @association.create(attributes, options, &block) }
      else
        @association.create(attributes, options, &block)
      end
    end

    def create!(attributes = nil, options = {}, &block)
      if ActiveRecord::VERSION::STRING.to_f < 5.2
        scoping { @association.create!(attributes, options, &block) }
      else
        @association.create!(attributes, options, &block)
      end
    end

  end
end
