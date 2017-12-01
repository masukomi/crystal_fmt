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
end


