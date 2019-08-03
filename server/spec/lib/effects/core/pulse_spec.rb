include Effects
include Effects::Core

describe Pulse do
  it "is colorful" do
    p = Pulse.new(
      p: 20,
      c: Colors::Green,
      iw: 5,
      ic: Colors::Yellow,
      ow: 5
    )
    strip_colors = (0...40).collect do |i|
      p.apply(Context.new(40, p: i)).color
    end
    expect(strip_colors.uniq.count).to eq(7)
  end

  it "has a center color" do
    p = Pulse.new(
      p: 20,
      c: Colors::Green,
      iw: 5,
      ic: Colors::Yellow,
      ow: 5
    )
    strip_colors = (0...40).collect do |i|
      p.apply(Context.new(40, p: i)).color
    end

    expect(strip_colors[p.position]).to eq(p.color)
  end

  it "has an inner color" do
    p = Pulse.new(
      p: 20,
      c: Colors::Green,
      iw: 5,
      ic: Colors::Yellow,
      ow: 5
    )
    strip_colors = (0...40).collect do |i|
      p.apply(Context.new(40, p: i)).color
    end

    expect(
      strip_colors.select{|c| c == p.inner_color}.count
    ).to eq(2 * p.inner_width)
  end

  it "has a blended outer color" do
    p = Pulse.new(
      p: 20,
      c: Colors::Green,
      iw: 5,
      ic: Colors::Yellow,
      ow: 5
    )
    strip_colors = (0...40).collect do |i|
      p.apply(Context.new(40, p: i)).color
    end

    expect(
      strip_colors[10..15].sort.uniq
    ).to eq(strip_colors[10..15])

    expect(
      strip_colors[25..30].sort.reverse.uniq
    ).to eq(strip_colors[25..30])
  end

# This would be nice, but it's a lot harder than it at first looks
# What you really want to test is move + pulse wrapping
  # it "wraps" do
  #   p = Effects::Core::Pulse.new(
  #     p: 0,
  #     c: Colors::Green,
  #     iw: 5,
  #     ic: Colors::Yellow,
  #     ow: 5
  #   )
  #   strip_colors = (0...40).collect do |i|
  #     p.apply(Context.new(40, p: i)).color
  #   end
  #   # Not zero, because the center point isn't reflected
  #   expect(
  #     strip_colors[1..10]
  #   ).to eq(strip_colors[-10..-1].reverse)
  # end
end
