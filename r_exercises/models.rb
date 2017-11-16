require 'rubygems'
require 'active_record'
require 'json'
require './mongo_class'
require './meta_datas'

mongo_cli = MongoClient.new("kurs_data")

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




x = User.push_mongo
p x