require 'rubygems'
require 'active_record'
require 'json'
require './mongo_class'

arguments = ARGV

@connection = ActiveRecord::Base.establish_connection(
    :adapter => "mysql2",
    :host => "localhost",
    :database => "DATABASENAME",
    :user => "root",
    :password => "PASSWD"
)
ActiveRecord::Base.pluralize_table_names = false


main_json = {}

module MetaMethods
    def find_item_by_id(id)
        self.where(["id = #{id}"])
    end

    def find_fk

        column_datas = self.column_names 
        foreign_key_columns = column_datas.select{|c_data| c_data.match(/_id$/)}
        
        foreign_key_columns


    end


end


class User < ActiveRecord::Base
    extend MetaMethods
end

class Course < ActiveRecord::Base
    extend MetaMethods
end




p User.find_fk




#my_col = "name"

#x = MongoClient.new("test")
#user_datas = User.all

#user_datas.each do |u_data|
 #   data = Course.find_item_by_id(u_data.course)
  #  @doc = { :name => u_data.name, :course_name =>data[0]["#{my_col}"] } 
   # x.insert_doc @doc
#end







