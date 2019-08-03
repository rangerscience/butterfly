include Effects
include Effects::Core

describe Wipe do
  it "wipes to the specified color" do
    c = Context.new(10, c: 0xFF00FF)
    w = Wipe.new Colors::Black

    c = w.apply(c)
    expect(c.color).to eq(Colors::Black)
  end
end
