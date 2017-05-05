# Protected Attributes Continued

[![Build Status](https://api.travis-ci.org/westonganger/protected_attributes_continued.svg?branch=master)](https://travis-ci.org/westonganger/protected_attributes_continued)

This is the community continued version of `protected_attributes`. It works with Rails 5 only and I recommend you only use it to support legacy portions of your application that you do not want to upgrade. Note that this feature was dropped by the Rails team and switched to strong_parameters because of security issues, just so you understand your risks. This is in use successfully in some of my Rails 5 apps in which security like this is a non-issue. For people who would like to continue using this feature in their Rails 5 apps lets continue the work here. 

Protect attributes from mass-assignment in Active Record models.

This plugin adds the class methods `attr_accessible` and `attr_protected` to your models to be able to declare white or black lists of attributes.


## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'protected_attributes_continued'
```

And then execute:

```ruby
bundle install
```

## Usage

Mass assignment security provides an interface for protecting attributes from end-user injection. This plugin provides two class methods in Active Record classes to control access to their attributes. The `attr_protected` method takes a list of attributes that will be ignored in mass-assignment. 

For example:
```ruby
attr_protected :admin
```
`attr_protected` also optionally takes a role option using `:as` which allows you to define multiple mass-assignment groupings. If no role is defined then attributes will be added to the `:default` role.

```ruby
attr_protected :last_login, as: :admin
```
A much better way, because it follows the whitelist-principle, is the `attr_accessible` method. It is the exact opposite of `attr_protected`, because it takes a list of attributes that will be mass-assigned if present. Any other attributes will be ignored. This way you won’t forget to protect attributes when adding new ones in the course of development. Here is an example:

```ruby
attr_accessible :name
attr_accessible :name, :is_admin, as: :admin
```

If you want to set a protected attribute, you will have to assign it individually:

```ruby
params[:user] # => {name: "owned", is_admin: true}
@user = User.new(params[:user])
@user.is_admin # => false, not mass-assigned
@user.is_admin = true
@user.is_admin # => true
```

When assigning attributes in Active Record using `attributes=` the `:default` role will be used. To assign attributes using different roles you should use `assign_attributes` which accepts an optional `:as` options parameter. If no `:as` option is provided then the `:default` role will be used. 

You can also bypass mass-assignment security by using the `:without_protection` option. Here is an example:

```ruby
@user = User.new

@user.assign_attributes(name: 'Josh', is_admin: true)
@user.name # => Josh
@user.is_admin # => false

@user.assign_attributes({ name: 'Josh', is_admin: true }, as: :admin)
@user.name # => Josh
@user.is_admin # => true

@user.assign_attributes({ name: 'Josh', is_admin: true }, without_protection: true)
@user.name # => Josh
@user.is_admin # => true
```

In a similar way, `new`, `create`, `create!`, `update_attributes` and `update_attributes!` methods all respect mass-assignment security and accept either `:as` or `:without_protection` options. For example:

```ruby
@user = User.new({ name: 'Sebastian', is_admin: true }, as: :admin)
@user.name # => Sebastian
@user.is_admin # => true

@user = User.create({ name: 'Sebastian', is_admin: true }, without_protection: true)
@user.name # => Sebastian
@user.is_admin # => true
```

By default the gem will use the strong parameters protection when assigning attribute, unless your model has `attr_accessible` or `attr_protected` calls.

## Errors

By default, attributes in the params hash which are not allowed to be updated are just ignored. If you prefer an exception to be raised configure:

```ruby
config.active_record.mass_assignment_sanitizer = :strict
```

Any protected attributes violation raises `ActiveModel::MassAssignmentSecurity::Error` then.


# Credits

Created and Maintained by [Weston Ganger - @westonganger](https://github.com/westonganger)

Originally forked from the dead/unmaintained `protected_attributes` gem by the Rails team.

<a href='https://ko-fi.com/A5071NK' target='_blank'><img height='32' style='border:0px;height:32px;' src='https://az743702.vo.msecnd.net/cdn/kofi1.png?v=a' border='0' alt='Buy Me a Coffee' /></a> 
