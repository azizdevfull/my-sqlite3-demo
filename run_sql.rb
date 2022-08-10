def run!

    while buf = Readline.readline("my_sqlite_cli>>",true)
        request    = MySqliteRequest.new
        key_word   = ""
        select_columns       = []
        where_params_ar      = []
        update_attributes_ar = []
        values_ar  = []
        my_parser(buf).each {|word|
        if word[0]=="'" && word[word.length-1]=="'"
            word.delete_prefix!("'").delete_suffix!("'")
        end

        case word.upcase
        when "SELECT"
            key_word = word
            request.instance_variable_set(:@type_of_request, :select)
            next
        when "INSERT"
            key_word = word
            request.instance_variable_set(:@type_of_request, :insert)
            next
        when "INTO"
            key_word = word
            next
        when "UPDATE"
            key_word = word
            request.instance_variable_set(:@type_of_request, :update)
            next
        when "DELETE"
            key_word = word
            request.instance_variable_set(:@type_of_request, :delete)
            next
        when "FROM"
            key_word = word
            next        
        when "WHERE"
            key_word = word
            next  
        when "SET"
            key_word = word
            next        
        when "VALUES"
            key_word = word
            next  
        end

        if key_word == ""
            p "Input can't be blank! Use 'SELECT', 'INSERT', 'UPDATE', 'DELETE' for query"
            exit
        end

        case key_word.upcase
        when "SELECT"
            select_columns<<word
            request.instance_variable_set(:@select_columns, select_columns)
            next
        when "INTO"
            request.instance_variable_set(:@table_name, word)
            next
        when "UPDATE"
            request.instance_variable_set(:@table_name, word)
            next
        when "FROM"
            request.instance_variable_set(:@table_name, word)
            headers = CSV.open(word,&:readline)
            next
        when "WHERE"
            where_params_ar<<word
            next
        when "SET"
            update_attributes_ar<<word
            next
        when "VALUES"
            values_ar<<word
            next
        end           
    }
    headers = CSV.open(request.instance_variable_get(:@table_name), &:readline)
    insert_attributes_hash = Hash[headers.zip(values_ar)].delete_if{|key,value| value ==nil}
    request.instance_variable_set(:@insert_attributes, insert_attributes_hash)
    request.instance_variable_set(:@where_params, where_params_ar.each_slice(2).to_a)

    request.instance_variable_set(:@update_attributes, update_attributes_ar.each_slice(2).to_h)

    request.run   

    end
end