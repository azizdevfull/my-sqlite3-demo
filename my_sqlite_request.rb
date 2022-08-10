require 'csv'
require 'json'
=begin
Part 1 Describing scope of project

# SELECT QUERY
# INSERT QUERY
# UPDATE
# DELETE

# 1.Type of request
# 2. Set settings
# 3. Run


=end
class MySqliteRequest

    def initialize
        @type_of_request = :none
        @select_columns  = []
        @where_params    = []
        @insert_attributes = {}
        @update_attributes = {}
        @table_name      = nil
        #@order           = :asc

    end

    def from(table_name)
        @table_name = table_name
        self
    end

    def select(columns)
        if(columns.is_a?(Array))
            @select_columns += columns.collect{ |elem| elem.to_s}
        else
            @select_columns << columns.to_s 
        end

        self._SetTypeOfRequest(:select)
        self
    end

    def where(column_name, criteria)
        @where_params << [column_name, criteria]
        self
    end

    #def join(column_on_db_a, filename_db_b, column_on_db_b)
    #   self
    #end

    #def order(order, column_name)
    #   self
    #end

    def insert(table_name)
        self._SetTypeOfRequest(:insert)
        @table_name = table_name
        self
    end

    def values(data)
        if (@type_of_request == :insert)
            @insert_attributes = data
        else
            raise "Wrong type of request to call values ()"
        end
        self
    end

    def update(table_name)
        self._SetTypeOfRequest(:update)
        @table_name = table_name
        self
    end

    #def set(data)
    #    self
    #end

    def delete
        self._SetTypeOfRequest(:delete)
        self
    end

    def print_select_type
        puts "Select Attributes #{@select_columns}"
        puts "Where Attributes #{@where_params}"
    end

    def print_insert_type
        puts "Insert Attributes #{@insert_attributes}"
    end

    def print
        puts "Type Of Request #{@type_of_request.upcase}"
        puts "Table Name #{@table_name}"
        if (@type_of_request == :select)
            print_select_type
        elsif 
            (@type_of_request == :insert)
            print_insert_type
        end
    end

    def run
        print
        if (@type_of_request == :select)
            _run_select
        elsif 
            (@type_of_request == :insert)
            _run_insert
        elsif 
            (@type_of_request == :update)
            _run_update
        elsif 
            (@type_of_request == :delete)
            _run_delete        
        end
    end

    def _SetTypeOfRequest(new_type)
        if (@type_of_request == :none or @type_of_request == new_type)
            @type_of_request = new_type
        else
            raise "Invalid: type of request already set to #{@type_of_request} (new type => #{new_type}) "
        end
    end

    

    def _run_select
        result = []
        CSV.parse(File.read(@table_name), headers: true).each do |row|
            if @select_columns == ["*"]
                @select_columns=CSV.open(*@table_name,&:readline)
            end

            if @where_params==[]
                result << row.to_hash.slice(*@select_columns).values
            else   
            @where_params.each do |where_attribute|
                if row [where_attribute[0]] == where_attribute[1]
                    result << row.to_hash.slice(*@select_columns).values
                end
            end
        end
    end
        puts @select_columns.to_csv
        result.each {|el|
        puts el.to_csv
        }
                
    end

    def _run_insert
        if @where_params ==[]

        File.open(@table_name, 'a') do|f|
           f.puts @insert_attributes.values.join(',')
        end

        else
            column_name = @where_params[0][0]
            criteria = @where_params[0][1]
            table = CSV.table(@table_name)
            table.each do |row|
                if row[:"#{column_name}"]== criteria
                    @insert_attributes.each_pair {|key, value|
                    row[:"#{key}"] = value
                }
            end
        end
        File.open(@table_name, 'w') do |f|
            f.write(table.to_csv)
            end
        end
    
    end

    def _run_update
        column_name = @where_params[0][0]
        criteria = @where_params[0][1]
        table = CSV.table(@table_name)
        table.each do |row|
            if row[:"#{column_name}"]==criteria
                @update_attributes.each_pair {|key,value|
                row[:"#{key}"]=value
            }
            end
        end
        File.open(@table_name, 'w') do |f|
            f.write(table.to_csv)
        end
    end

    def _run_delete
        column_name = @where_params[0][0]
        criteria = @where_params[0][1]
        table = CSV.table(@table_name)
        table.delete_if do|row|
            row[:"#{column_name}"] == criteria
        end
        File.open(@table_name,'w') do |f|
            f.write(table.to_csv)
        end
    end


end

 def _main()
=begin
Questiom 0 of 10

request = MySqliteRequest.new
request = request.from('nba_player_data.csv')
request = request.select('name')
request.run

Questions 1 of 10

request = MySqliteRequest.new
request = request.from('nba_player_data.csv')
request = request.select('name')
request = request.where('college', 'University of California')
request.run


Question 2 of 10

request = MySqliteRequest.new
request = request.from('nba_player_data.csv')
request = request.select('name')
request = request.where('college', 'University of California')
request = request.where('year_start', '1997')
request.run

Question 3 of 10

    request = MySqliteRequest.new
    request = request.insert('nba_player_data_light.csv')
    request = request.values({"name"=>"Don Adams","year_start"=>"1971","year_end"=>"1977",
    "position"=>"F","height"=>"6-6","weight"=>"210","birth_date"=>"November 27, 1947",
    "college"=>"Northwestern University"})
    request.run

Question 4 of 10

request = MySqliteRequest.new
request = request.insert('nba_player_data.csv')
request = request.values('name' => 'Alaa Renamed')
request = request.where('name', 'Alaa Abdenlaby')
request.run

Question 5 of 10

request = MySqliteRequest.new
request = request.delete()
request = request.from('nba_player_data_light.csv')
request = request.where('name', 'Don Adams')
request.run

=end    


    
 end
 _main


 

 