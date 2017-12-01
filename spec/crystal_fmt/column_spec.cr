require "../spec_helper"

describe Column do
  it "should be able to calculate the max length" do
    c = Column.new(Array(String | Nil).new + ["1", "22", nil, "333", "4444"])
    c.max_length.should(eq(4))
  end
  it "should be able to calculate the max of an empty column" do
    c = Column.new(Array(String | Nil).new + [nil])
    c.max_length.should(eq(0))
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
end
