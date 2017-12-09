require "./missing_table_data.cr"

class Table
  @data : Array(Array(String | Nil))
  @columns : Array(Column)
  getter :data
  setter :data

  # Can be initialized with an of cells: Array(Array(String | Nil))
  # or nothing and you can add rows of data later with add_rows
  # Note: all rows of data must be the same length.
  def initialize(@data : Array(Array(String | Nil)) = Array(Array(String | Nil)).new)
    if (@data.size > 0)
      column_count = @data[0].size
      if !@data.all? { |x| x.size == column_count }
        raise MissingTableData.new(
          "all rows must have an equal number of columns")
      end
    end
    @columns = Array(Column).new(0)
  end

  # Allows you to initialize this with an array of columns.
  # Note: when this initializer is used you will not be able 
  # to use the add_rows method
  def initialize(@columns : Array(Column))
    @data = Array(Array(String | Nil)).new
  end

  # Adds a row of data.
  # Note: this must have the same number of items as all the other
  # rows that have been added.
  def add_row(row : Array(String | Nil))
    if @columns.size > 0
      raise "Can't add rows to tables initialized with Array(Column)"
    end
    if data.size > 0 && data[0].size != row.size
      raise MissingTableData.new(
        "all rows must have an equal number of columns")
    end
    @data << row
  end

  # Formats the data into a textual table.
  # By default it will:
  # * start each row with "| "
  # * end each row with " |"
  # * separate each item with " | "
  # These defaults can be overridden by specifying :left_border, :right_border,
  # or :divider (respectively) in the options.
  #
  # By default it assumes the first row is a header.
  # To disable the divider under the first row set options[:show_header] = false
  # To change the character used for the divider set
  # options[:header_divider] = <any single character>
  #
  # Example:
  # [["things", "stuff"],["a", "b"], ["c", nil]]
  # Would become
  # | things | stuff |
  # | ------ | ----- |
  # | a      | b     |
  # | c      |       |
  def format(options : Hash(Symbol, String | Bool) = Hash(Symbol, String | Bool).new) : String
    options[:divider] = " | " unless options.has_key?(:divider)
    options[:left_border] = "| " unless options.has_key?(:left_border)
    options[:right_border] = " |" unless options.has_key?(:right_border)
    options[:header_divider] = "-" unless options.has_key?(:header_divider)
    if options[:header_divider].to_s.size > 1
      raise "header must be a string with only one character"
    end
    options[:show_header] = true unless options.has_key?(:show_header)
    formatted(extract_columns(@data), options)
  end

  # Extracts Column objects from the provided data
  # primarily for use use by this class, but you may find it
  # useful too.
  def extract_columns(data : Array(Array(String | Nil))) : Array(Column)
    if @columns.size > 0
      return @columns
    end
    column_count = data[0].size
    row_count = data.size
    result = Array(Column).new(column_count)
    column_count.times do
      result << Column.new
    end
    (0...row_count).each do |row_idx|
      (0...column_count).each do |col_idx|
        result[col_idx] << data[row_idx][col_idx]
      end
    end
    result
  end

  # Private ---------------------------
  private def insert_header_into_columns(header_string : String, columns : Array(Column)) : Array(Column)
    columns.each do |col|
      col.insert((header_string * col.width), 1)
    end
    columns
  end

  private def formatted(columns : Array(Column), options : Hash(Symbol, String | Bool)) : String
    if options[:show_header]
      insert_header_into_columns(options[:header_divider].to_s, columns)
    end

    column_max_idx = columns.size - 1
    row_max_idx = columns.first.strings.size - 1

    formatted_column_data = columns.map { |c| c.formatted } # Array(Array(String)

    result = String.build do |str|
      (0..row_max_idx).each do |row_idx|
        (0..column_max_idx).each do |col_idx|
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
end
