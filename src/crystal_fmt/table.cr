require "./missing_table_data.cr"
class Table
  @data : Array(Array(String | Nil))
  getter :data
  setter :data
  def initialize(@data : Array(Array(String | Nil)) = Array(Array(String | Nil)).new)
    if (@data.size > 0)
      column_count = @data[0].size
      if ! @data.all?{|x|x.size == column_count}
        raise MissingTableData.new(
          "all rows must have an equal number of columns")
      end
    end
  end

  def add_row(row : Array(String | Nil))
    if data.size > 0 && data[0].size != row.size
      raise MissingTableData.new(
        "all rows must have an equal number of columns")
    end
    @data << row
  end

  def format(options : Hash(Symbol, String) = Hash(Symbol,String).new) : String

    options[:divider] = " | " unless options.has_key?(:divider)
    options[:left_border] = "| " unless options.has_key?(:left_border)
    options[:right_border]  = " |" unless options.has_key?(:right_border)
    formatted(extract_columns(@data), options)
  end
  
  private def formatted(columns : Array(Column), options : Hash(Symbol, String)) : String
    column_max_idx = columns.size() -1
    row_max_idx = columns.first.strings.size() -1
    formatted_column_data = columns.map{|c| c.formatted } # Array(Array(String)
    
    result = String.build do | str | 
      (0..row_max_idx).each do |row_idx|
        (0..column_max_idx).each do | col_idx |
          if col_idx == 0
            str << options[:left_border]
          end
          str << formatted_column_data[col_idx][row_idx]
          if col_idx < column_max_idx 
            str << options[:divider]
          else
            str << options[:right_border]
            if row_idx < row_max_idx
              str << "\n"
            end
          end
         end
      end
    end
    result
  end
  
  def extract_columns(data : Array(Array(String | Nil))) : Array(Column)
    column_count = data[0].size
    row_count = data.size
    result = Array(Column).new(column_count)
    column_count.times do
      result << Column.new()
    end
    (0...row_count).each do |row_idx|
      (0...column_count).each do | col_idx |
        result[col_idx] << data[row_idx][col_idx]
      end
    end
    result
  end
end
