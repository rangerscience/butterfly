include Effects

describe Effects::Context do
  it "wraps positive past zero" do
    c = Context.new(10)
    c.position = 11
    expect(c.position).to eq(1)
  end

  it "wraps positive to zero" do
    c = Context.new(10)
    c.position = 10
    expect(c.position).to eq(0)
  end

  it "wraps negative past zero" do
    c = Context.new(10)
    c.position = -1
    expect(c.position).to eq(9)
  end
end
