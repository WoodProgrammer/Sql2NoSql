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

User.generate_meta_json


datas = User.all
cols = User.column_names
control_json = User.generate_meta_json

doc = {}




col_name = "my_datas"
datas.each do |data|

    cols.each do |col|
        if control_json[:fks].include?(col)
            ask_col = col.split("_")
            tmp_data = Course.find_by(id: data[col])
            doc["#{ask_col[0]}"] = tmp_data["name"] 
        else 
            doc["#{col}"] = data["#{col}"] 
        end  
    end
    mongo_cli.insert_doc(doc)
    
end