require 'json'
module MetaMethods
    @db_has = {}
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
        col_in_table        
    end


    def generate_meta_json
        db_hash = {:main_table_name =>self.name , :fks=> self.find_fk , :fk_table => self.fks_table}
        return db_hash
    end
    
 
end
