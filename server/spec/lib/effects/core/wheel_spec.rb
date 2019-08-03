include Effects
include Effects::Core

describe Wheel do
  it "is colorful" do
    w = Wheel.new(10)
    strip_colors = (0...10).collect do |i|
      w.apply(Context.new(10, p: i)).color
    end
    expect(strip_colors).not_to include(Colors::Black)
    expect(strip_colors).not_to include(Colors::White)
    expect(strip_colors.uniq.count).to eq(10)
  end

  it "wraps" do
    w = Wheel.new(10)
    strip_colors = (0...20).collect do |i|
      w.apply(Context.new(20, p: i)).color
    end
    expect(strip_colors.first).to eq(strip_colors[10])
    expect(strip_colors[9]).to eq(strip_colors[19])
    expect(strip_colors.uniq.count).to eq(10)
  end

  it "extends" do
    w = Wheel.new(20)
    strip_colors = (0...10).collect do |i|
      w.apply(Context.new(10, p: i)).color
    end
    expect(strip_colors.first).not_to eq(strip_colors.last)
    expect(strip_colors.uniq.count).to eq(10)
  end
end
