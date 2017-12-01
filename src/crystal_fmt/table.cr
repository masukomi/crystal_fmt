require "./missing_table_data.cr"
class Table
  getter :columns
  getter :data
  @columns : Array(Column)
  def initialize(@data : Array(Array(String | Nil)))
    column_count = @data[0].size
    if ! @data.all?{|x|x.size == column_count}
      raise MissingTableData.new(
        "all rows must have an equal number of columns")
    end
    @columns = extract_columns(@data)
  end

  # TODO:  support options for: divider, left border, right border
  def formatted(columns : Array(Column) = @columns, options : Hash(Symbol, String)  = Hash(Symbol,String).new) : String
    divider = options.has_key?(:divider) ? options[:divider] : " | "
    left_border = options.has_key?(:left_border) ? options[:left_border] : "| "
    right_border = options.has_key?(:right_border) ? options[:right_border] : " |"
    
    column_max_idx = columns.size() -1
    row_max_idx = columns.first.strings.size() -1
    formatted_column_data = columns.map{|c| c.formatted } # Array(Array(String)
    result = String.build do | str | 
      (0..column_max_idx).each do |row_idx|
        (0..row_max_idx).each do | col_idx |
          if col_idx == 0
            str << left_border
          end
          str << formatted_column_data[col_idx][row_idx]
          if col_idx < column_max_idx 
            str << divider
          else
            str << right_border
            if row_idx < row_max_idx
              str << "\n"
            end
          end
         end
      end
    end
    result
  end
  
  private def extract_columns(data : Array(Array(String | Nil))) : Array(Column)
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
