require 'rubygems'
require 'active_record'
require 'json'
require './mongo_class'
require './meta_datas'
arguments = ARGV

@connection = ActiveRecord::Base.establish_connection(
    :adapter => "mysql2",
    :host => "localhost",
    :database => "tool_test2",
    :user => "root",
    :password => "abcde"
)
ActiveRecord::Base.pluralize_table_names = false


main_json = {}


class User < ActiveRecord::Base
    extend MetaMethods
end

class Course < ActiveRecord::Base
    extend MetaMethods

end

Course.generate_meta_json