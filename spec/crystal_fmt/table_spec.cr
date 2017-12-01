require "../spec_helper"

def default_data() : Array(Array(String | Nil))
  Array(Array(String | Nil)).new << ["a", "b"] << ["c", nil]
end
describe Table do
  # data = reset_data()
  it "should be initializable with a full matrix" do
    t = Table.new(default_data())
    t.should(be_a(Table))
  end
  it "should raise MissingTableData when given uneven matrix" do
    data = default_data()
    data << Array(String | Nil).new+[nil]
    expect_raises (MissingTableData) do
      t = Table.new(data)
    end
  end

  it "should extract columns from data" do
    t = Table.new(default_data())
    t.columns.size.should(eq(2))
    t.columns.first.size.should(eq(2))
    t.columns.last.size.should(eq(2))
    t.columns.first.strings[0].should(eq("a"))
  end

  it "should create one line of text per row" do 
    t = Table.new(default_data())
    # [["a", "b"], ["c", nil]]
    t.formatted.split("\n").size.should(eq(2))
  end
  it "should format with | between each item" do
    t = Table.new(default_data())
    # [["a", "b"], ["c", nil]]
    formatted = t.formatted
    formatted.includes?("a | b").should(be_true())
    formatted.includes?("c |  ").should(be_true())
  end

  it "should start rows with \"| \"" do
    t = Table.new(default_data())
    # [["a", "b"], ["c", nil]]
    formatted = t.formatted
    formatted.includes?("| a").should(be_true())
    formatted.includes?("| c").should(be_true())
  end
  it "should end rows with \" |\"" do
    t = Table.new(default_data())
    # [["a", "b"], ["c", nil]]
    formatted = t.formatted
    formatted.includes?("b |").should(be_true())
    formatted.includes?("  |").should(be_true())
  end

  it "should have a configurable left border" do
    t = Table.new(default_data())
    # [["a", "b"], ["c", nil]]
    options = Hash(Symbol,String).new
    options[:left_border] = "X "
    formatted = t.formatted(t.columns,options) 
    formatted.includes?("X a").should(be_true())
    formatted.includes?("X c").should(be_true())
  end
  it "should have a configurable right border" do
    t = Table.new(default_data())
    # [["a", "b"], ["c", nil]]
    options = Hash(Symbol,String).new
    options[:right_border] = " X"
    formatted = t.formatted(t.columns,options) 
    formatted.includes?("b X").should(be_true())
    formatted.includes?("  X").should(be_true())
  end
  it "should have a configurable divider" do
    t = Table.new(default_data())
    # [["a", "b"], ["c", nil]]
    options = Hash(Symbol,String).new
    options[:divider] = " X "
    formatted = t.formatted(t.columns, options)
    formatted.includes?("a X b").should(be_true())
    formatted.includes?("c X  ").should(be_true())
  end
end


