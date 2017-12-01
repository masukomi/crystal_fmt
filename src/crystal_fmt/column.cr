class Column
  getter :strings
  def initialize(@strings : Array(String | Nil) = Array(String|Nil).new)
    @max = -1
  end

  def size() : Int32
    @strings.size
  end
  
  def <<(string)
    @strings << string
  end

  def max_length
    return @max if @max > -1
    compacted = @strings.compact
    @max = ((compacted.size > 0) ? compacted.map { |x| x.size }.max : 0)
  end

  def formatted(padding : Symbol = :right) : Array(String)
    if ![:left, :right].includes? padding
      raise "unsupported padding: #{padding}"
    end
    @strings.map { |s|
      "%#{padding == :right ? "-" : ""}#{max_length}s" % s.to_s
    }
  end
end
