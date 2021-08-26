# Protected Attributes Continued
<a href="https://badge.fury.io/rb/protected_attributes_continued" target="_blank"><img height="21" style='border:0px;height:21px;' border='0' src="https://badge.fury.io/rb/protected_attributes_continued.svg" alt="Gem Version"></a>
<a href='https://github.com/westonganger/protected_attributes_continued/actions' target='_blank'><img src="https://github.com/westonganger/protected_attributes_continued/workflows/Tests/badge.svg" style="max-width:100%;" height='21' style='border:0px;height:21px;' border='0' alt="CI Status"></a>
<a href='https://rubygems.org/gems/protected_attributes_continued' target='_blank'><img height='21' style='border:0px;height:21px;' src='https://ruby-gem-downloads-badge.herokuapp.com/protected_attributes_continued?label=rubygems&type=total&total_label=downloads&color=brightgreen' border='0' alt='RubyGems Downloads' /></a>

> This is the community continued version of [`protected_attributes`](https://github.com/rails/protected_attributes) for Rails 5+. The Rails team dropped this feature and switched to `strong_parameters`. However some applications simply cannot be upgraded or the reduced granularity in params management is a non-issue. To continue supporting this feature going forward we continue the work here.

Protect attributes from mass-assignment in Active Record models. This gem adds the class methods `attr_accessible` and `attr_protected` to declare white or black lists of attributes.


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

## Contributing

For quicker feedback during gem development or debugging feel free to use the provided `rake console` task. It is defined within the [`Rakefile`](./Rakefile).

We test multiple versions of `Rails` using the `appraisal` gem. Please use the following steps to test using `appraisal`.

1. `bundle exec appraisal install`
2. `bundle exec appraisal rake test`

## Credits

Created & Maintained by [Weston Ganger](https://westonganger.com) - [@westonganger](https://github.com/westonganger)

Originally forked from the dead/unmaintained [`protected_attributes`](https://github.com/rails/protected_attributes) gem by the Rails team.

## A Simple and Similar strong_params Alternative

While I do utilize this gem in some legacy projects. The latest approach I have adopted is similar to this gem but only utilizes Rails built-in `strong_params` which is a much more future proof way of doing things. The following is an example implementation.

```ruby
### Model
class Post < ActiveRecord::Base
  has_many :comments

  accepts_nested_attributes_for :comments, allow_destroy: true
  
  def self.strong_params(params)
    params.permit(:post).permit(*PERMITTED_ATTRIBUTES)
  end
  
  PERMITTED_ATTRIBUTES = [
    :id,
    :name,
    :content,
    :published_at,
    {
      comments_attributes: Comment::PERMITTED_ATTRIBUTES,
    }
  ].freeze
  
end

### Controller
class PostsController < ApplicationController
  def create
    @post = Post.new(Post.strong_params(params))
    
    @post.save

    respond_with @post
  end

  def update
    @post = Post.find(params[:id])

    @post.update(Post.strong_params(params))

    respond_with @post
  end
end
```
