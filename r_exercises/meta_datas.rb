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
