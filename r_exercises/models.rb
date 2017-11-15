require 'rubygems'
require 'active_record'
require 'json'
require './mongo_class'

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

module MetaMethods
    def find_item_by_id(id)
        self.where(["id = #{id}"])
    end

    def find_fk

        column_datas = self.column_names 
        foreign_key_columns = column_datas.select{|c_data| c_data.match(/_id$/)}
        foreign_key_columns
    end

    def fks_table
        fks = self.find_fk
        
        table_names = fks.map!{|fk| fk.split('_').first }
        return table_names 
       
    end

    def fks_cols
        fks = self.find_fk
        
        col_in_table = fks.map!{|fk| fk.split('_').last }
        return col_in_table 
       
    end


end


class User < ActiveRecord::Base
    extend MetaMethods
end

class Course < ActiveRecord::Base
    extend MetaMethods
end

p User.fks_table
p User.fks_cols














