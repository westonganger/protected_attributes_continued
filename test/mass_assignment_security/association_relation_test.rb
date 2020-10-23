require "test_helper"
require "ar_helper"

class AssociationRelationTest < ActiveSupport::TestCase
  test "first_or_initialize does not raise ArgumentError" do
    assert_nothing_raised { Group.new.memberships.where("1=1").first_or_initialize }
  end

  test "first_or_create does not raise ArgumentError" do
    group = Group.create
    assert_nothing_raised { group.memberships.where("1=1").first_or_create }
  end
end
