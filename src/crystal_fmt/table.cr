require "./missing_table_data.cr"
class Table
  getter :columns
  @columns : Array(Column)
  def initialize(@data : Array(Array(String | Nil)))
    column_count = @data[0].size
    if ! @data.all?{|x|x.size == column_count}
      raise MissingTableData.new(
        "all rows must have an equal number of columns")
    end
    @columns = extract_columns(@data)
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
