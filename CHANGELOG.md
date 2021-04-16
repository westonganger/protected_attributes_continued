# CHANGELOG

## Unreleased

* Nothing yet
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.8.1...master)

## 1.8.1 - 2021-03-24

* [#24](https://github.com/westonganger/protected_attributes_continued/pull/24) - Fix bug introdcued in [#21](https://github.com/westonganger/protected_attributes_continued/pull/21) & `v1.8.0` where the scope chain on associations wasnt preserving the values
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.8.0...v1.8.1)

## 1.8.0 - 2021-03-06

* [#22](https://github.com/westonganger/protected_attributes_continued/issues/22) - Do not raise connection error on `attr_accessible` and `attr_protected` if database does not yet exist
* [#21](https://github.com/westonganger/protected_attributes_continued/pull/21) - Fix leaky scope with `first_or_create` on Rails 5.2+
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.7.0...v1.8.0)

## 1.7.0 - 2020-10-24

* [#20](https://github.com/westonganger/protected_attributes_continued/pull/20) - Fix bug when calling `first_or_initialize` on an association relation
* [60da8e1](https://github.com/westonganger/protected_attributes_continued/commit/60da8e1deee54da97546c5ad3fe38c3385a8e5e8) - Add warning at end of default rake task to highlight the requirement to run the tests with `appraisal`
* [c38a230](https://github.com/westonganger/protected_attributes_continued/commit/c38a230b310fdb42662dad6bdd46e15ab3d3489d) - Added db setup and reloading to `rake console` task for easier debugging
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.6.0...v1.7.0)

## 1.6.0 - 2020-10-01

* [#18](https://github.com/westonganger/protected_attributes_continued/pull/18) - Fix for Rails 6+ for new records that were supposed to be created issuing UPDATE sql calls instead of INSERT. They would come back thinking they were persisted, but they didn't have an id attribute because of the invalid sql call made.
* Fix method redefined warning for ThroughAssociation#build_record
* Fix method redefined warning for HasManyThroughAssociation#options_for_through_association for Rails <= 5.2
* Add Rails 6.0 to test matrix
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.5.0...v1.6.0)

## 1.5.0 - 2019-08-16

* [#13](https://github.com/westonganger/protected_attributes_continued/pull/13) - Fixed with_indifferent_access call in nested attributes
* [#14](https://github.com/westonganger/protected_attributes_continued/pull/14) - For ActiveRecord versions >= 5.2.3 Rails does not call `options_for_through_record` anymore. This method was previously used by `protected_attributes` to pass in the `without_protection: true` option. We now override the `build_through_record` method instead and pass the option in there.
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.4.0...v1.5.0)

## 1.4.0 - 2018-12-28

* Add Rails 5.2 support
* Fix bug related to incorrect usage of options on the `AR#new` method
* Use `scope_for_create` instead of `create_scope` in Rails 5.2+
* Fix bug related to protection of `inheritance_column` attribute
* Use Appraisal for testing against multple Rails versions
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.3.0...v1.4.0)

## 1.3.0 - 2017-05-05

* Add Rails 5.1 support
* Dont require activerecord in non-activerecord environments
* Drop support for Rails 4, it now only support Rails 5
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.2.4...v1.3.0)

## 1.2.4 - 2017-05-05

* Fixed params type checking with nested attributes
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.2.3...v1.2.4)

## 1.2.3 - 2016-09-20

* Fixed ArgumentError with nested attributes
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.2.2...v1.2.3)

## 1.2.2 - 2016-09-20

* Fix for Rails 5
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.2.1...v1.2.2)

## 1.2.1 - 2016-09-20

* Fix for Rails 5
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.2.0...v1.2.1)

## 1.2.0 - 2016-09-20

* Added Rails 5 support, already works just needed the gemspec updated to allow it
* New repo `protected_attributes_continued` because Rails refuses to support Rails 5
* [View Full Diff](https://github.com/westonganger/protected_attributes_continued/compare/v1.1.4...v1.2.0)

## OLD protected_attributes CHANGELOG
## 1.1.4

* Avoid double callbacks in Rails >= 4.1.

* Fixes UnitializedConstant in TooManyRecords.

## 1.1.3

* Fix deprecation code.

## 1.1.2

* Deprecate `config.active_record.whitelist_attributes`.

* Fix integration with associations.

## 1.1.1

* Fix strong parameters integration.

* Remove warnings

* Fix `find_or_*` and `first_or_*` methods integration.

## 1.1.0

* Integrate with strong parameters. This allows to migrate a codebase partially
  from `protected_attributes` to `strong_parameters`. Every model that does not
  use a protection macro (`attr_accessible` or `attr_protected`), will be
  protected by strong parameters. The behavior stays the same for models, which
  use a protection macro.

  To fully restore the old behavior set:

      config.action_controller.permit_all_parameters = true

  Or add a callback to your controllers like this:

      before_action { params.permit! }

  Fixes #41.

## 1.0.9

* Fixes ThroughAssociation#build_record method on rails 4.1.10+

  Fixes #60, #63

* Fixes build_association method on rails 4.2.0+

  Fixes https://github.com/rails/rails/issues/18121

## 1.0.8 (June 16, 2014)

* Support Rails 4.0.6+ and 4.1.2+.

  Fixes #35


## 1.0.7 (March 12, 2014)

* Fix STI support on Active Record <= 4.0.3.


## 1.0.6 (March 10, 2014)

* Support to Rails 4.1

* Fix `CollectionProxy#new` method.

  Fixes #21


## 1.0.5 (November 1, 2013)

* Fix install error with Rails 4.0.1.
  Related with https://github.com/bundler/bundler/issues/2583


## 1.0.4 (October 18, 2013)

* Avoid override the entire Active Record initialization.

  Fixes rails/rails#12243


## 1.0.3 (June 29, 2013)

* Fix "uninitialized constant ActiveRecord::MassAssignmentSecurity::NestedAttributes::ClassMethods::REJECT_ALL_BLANK_PROC"
  error when using `:all_blank` option.

  Fixes #8

* Fix `NoMethodError` exception when calling `raise_nested_attributes_record_not_found`.


## 1.0.2 (June 25, 2013)

* Sync #initialize override to latest rails implementation

  Fixes #14


## 1.0.1 (April 6, 2013)

* Fix "uninitialized constant `ActiveRecord::SchemaMigration`" error
  when checking pending migrations.

  Fixes rails/rails#10109


## 1.0.0 (January 22, 2013)

* First public version
