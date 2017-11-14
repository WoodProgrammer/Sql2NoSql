require 'rubygems'
require 'active_record'
require 'json'
require './mongo_class'

arguments = ARGV

@connection = ActiveRecord::Base.establish_connection(
    :adapter => "mysql2",
    :host => "localhost",
    :database => "tool_test",
    :user => "root",
    :password => "abcde"
)
@connection.get_tables