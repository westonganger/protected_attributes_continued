#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = ["test"]
  t.pattern = "test/**/*_test.rb"
  t.ruby_opts = ['-w']
end

task default: [:test, :warn]

task :warn do
  puts
  puts "Warning:"
  puts "We support testing of multiple Rails versions with the appraisal gem"
  puts "Before creating a PR please ensure the following command succeeeds:"
  puts
  puts "bundle exec appraisal install && bundle exec appraisal rake test"
  puts
end

task :console do
  require 'sqlite3'
  require 'active_record'

  ### Must define model names outside method definition
  class Post < ActiveRecord::Base; end

  def reload!
    setup_db_and_data
  end

  def setup_db_and_data
    import 'protected_attributes_continued' ### import method will re-require the file regardless if its loaded or not

    ActiveRecord::Base.establish_connection(
      adapter: 'sqlite3',
      database: ':memory:',
    )

    conn = ActiveRecord::Base.connection

    ### Delete all tables
    conn.execute("SELECT * FROM sqlite_master WHERE type='table';").collect(&:first).each do |table| 
      if ["schema_migrations"].exclude?(table)
        conn.execute("DROP TABLE #{table}")
      end
    end

    columns = [
      "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL", 
      "name VARCHAR(255)",
      "post_id INT", 
    ].join(", ")

    conn.execute("CREATE TABLE posts(#{columns});")

    Post.class_eval do
      belongs_to :post
      has_many :posts
      has_one :has_one_post, class_name: 'Post', foreign_key: :post_id
    end

    seed_data = [
      {id: 1, name: "1", post_id: 2},
      {id: 2, name: "2", post_id: 3},
      {id: 3, name: "3", post_id: 1},
    ]

    seed_data.each do |h|
      Post.create!(h)
    end

    return true
  end

  setup_db_and_data

  require 'irb'
  binding.irb
end
