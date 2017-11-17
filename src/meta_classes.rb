require 'json'
require_relative 'mongo_class'
module MetaMethods
    
    def find_item_by_id(id)
        self.where(["id = #{id}"])
    end

    def find_fk

        column_datas = self.column_names 
        foreign_key_columns = column_datas.select{|c_data| c_data.match(/_id$/)}
        foreign_key_columns
    end ##course_id ##class_id


    def generate_table_json
        table_hash = {}
        find_fk.each do |fk|
            col_split = fk.split("_")
            
            table_hash[fk] = {}

            table_hash[fk]["table"] = col_split[0]
            table_hash[fk]["col_name"] = col_split[1]

        end
        table_hash
    end
    
    def push_mongo  
        
        mongo_obj = MongoClient.new(self.connection.current_database) 

        
        test_bson = {}

        datas = self.all
        tmp_data = self.generate_table_json
        cols = self.column_names
        
        datas.each do |data|        
            cols.each do |col|
                if find_fk.include?(col) ###eger fkların içerisinde ise  ?
                    ###col ' nın  ismi splitle söyle
                    tmp_col = col.split("_")
                    tmp_col[0] ##table_name olucak e.g COURSE
                    tmp_col[1] ##table_daki adı olucak e.g i

                    begin
                        x = tmp_col[0].capitalize.constantize.column_names
                        x.delete("id")

                        tmp_datas = tmp_col[0].capitalize.constantize.find(data[col]).to_json

                        
                        test_bson["#{col}".delete("_id")] = tmp_datas

                    rescue

                    end
                else  
                    
                    test_bson["#{col}"] = data["#{col}"]
                    
                end
            end

            mongo_obj.insert_doc(self.table_name,test_bson)
            
        end

        
       

    end



end
