class Column
  getter :strings
  getter :padding
  setter :padding

  def initialize(@strings : Array(String | Nil) = Array(String | Nil).new,
                 @padding : Symbol = :right)
    @max = -1
  end

  def size : Int32
    @strings.size
  end

  def width : Int32
    size > 0 ? max_width : 0
  end

  def <<(string)
    @strings << string
    @max_width = -1
  end

  def insert(str : String, row_idx : Int32)
    @strings[row_idx, 0] = str
    @max_width = -1
  end

  def max_width
    return @max if @max > -1
    compacted = @strings.compact
    @max = ((compacted.size > 0) ? compacted.map { |x| x.size }.max : 0)
  end

  def formatted(padding : Symbol = @padding) : Array(String)
    if ![:left, :right].includes? padding
      raise "unsupported padding: #{padding}"
    end
    @strings.map { |s|
      "%#{padding == :right ? "-" : ""}#{max_width}s" % s.to_s
    }
  end
end
