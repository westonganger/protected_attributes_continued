module ActiveRecord
  class AssociationRelation
    undef :new
    undef :create
    undef :create!

    def build(attributes = nil, options = {}, &block)
      return scoping { @association.build(attributes, options, &block) } if less_than_v52

      @association.build(attributes, options, &block)
    end
    alias new build

    def create(attributes = nil, options = {}, &block)
      return scoping { @association.create(attributes, options, &block) } if less_than_v52

      @association.create(attributes, options, &block)
    end

    def create!(attributes = nil, options = {}, &block)
      return scoping { @association.create!(attributes, options, &block) } if less_than_v52

      @association.create!(attributes, options, &block)
    end

    private

    def less_than_v52
      ActiveRecord::VERSION::MAJOR <= 4 || (ActiveRecord::VERSION::MAJOR == 5 && ActiveRecord::VERSION::MINOR <= 1)
    end
  end
end
