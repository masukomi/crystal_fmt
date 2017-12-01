require "../spec_helper"

describe Column do
  it "should be able to calculate the max length" do
    c = Column.new(Array(String | Nil).new + ["1", "22", nil, "333", "4444"])
    c.max_width.should(eq(4))
  end
  it "should be able to calculate the max of an empty column" do
    c = Column.new(Array(String | Nil).new + [nil])
    c.max_width.should(eq(0))
  end
  it "should padd all items to the width of longest" do
    c = Column.new(Array(String | Nil).new + ["1", "22", "333", "4444"])
    formatted = c.formatted
    formatted.all? { |x| x.size == 4 }.should(be_true())
  end

  it "should convert nil to padded strings" do
    c = Column.new(Array(String | Nil).new + ["1", "22", "333", "4444"])
    formatted = c.formatted
    formatted.all? { |x| x.size == 4 }.should(be_true())
  end

  it "should be able to format a nil item" do
    c = Column.new(Array(String | Nil).new + ["1", "22", "333", nil, "4444"])
    formatted = c.formatted
    formatted.all? { |x| x.size == 4 }.should(be_true())
  end

  it "should be pad right by default" do
    c = Column.new(Array(String | Nil).new + ["1", "4444"])
    formatted = c.formatted
    formatted[0].should(eq("1   "))
  end
  it "should used padding of instance by default" do
    c = Column.new(Array(String | Nil).new + ["1", "4444"], :left)
    formatted = c.formatted
    formatted[0].should(eq("   1"))
  end
  it "should be pad left when specifed" do
    c = Column.new(Array(String | Nil).new + ["1", "4444"])
    formatted = c.formatted(:left)
    formatted[0].should(eq("   1"))
  end
  it "should be pad right when specifed" do
    c = Column.new(Array(String | Nil).new + ["1", "4444"])
    formatted = c.formatted(:right)
    formatted[0].should(eq("1   "))
  end

  it "should be able to add strings" do 
    c = Column.new()
    c << "foo"
    c.strings.size.should(eq(1))
    c.strings.first.should(eq("foo"))
  end
  it "should be able to insert strings" do 
    c = Column.new(Array(String|Nil).new+["a","c"])
    c.insert("b", 1)
    c.strings.size.should(eq(3))
    c.strings.should(eq(["a", "b", "c"]))
  end
end
