include Effects
include Effects::Meta
include Effects::Core

describe Moving do
  it "does not alter color" do
    c = Colors::Black
    m = Moving.new(1)
    strip_colors = (0...10).collect do |i|
      m.apply(Context.new(10, p: i, c: c)).color
    end
    expect(strip_colors.uniq).to eq([c])
  end

  it "does not alter time" do
    t = Time.now
    m = Moving.new(1)
    strip_times = (0...10).collect do |i|
      m.apply(Context.new(10, p: i, t: t)).time
    end

    expect(strip_times.uniq).to eq([t])
  end

  it "shifts position based on time" do
    t = Time.now

    m = Moving.new(1, s: t)

    strip_positions = (0...10).collect do |i|
      m.apply(Context.new(11, p: i, t: t+1)).position
    end
    expect(strip_positions).to eq((1..10).to_a)

    strip_positions = (0...10).collect do |i|
      m.apply(Context.new(21, p: i, t: t+i)).position
    end
    expect(strip_positions).to eq((0..9).to_a.map{|i| i * 2})
  end

  it "wraps" do
    t = Time.now
    m = Moving.new(1)
    strip_positions = (0...10).collect do |i|
      m.apply(Context.new(10, p: i, t: t+5)).position
    end
    expect(strip_positions).to eq([5, 6, 7, 8, 9, 0, 1, 2, 3, 4])
  end

  it "works with faster frequencies" do
    t = Time.now
    m = Moving.new(2)
    strip_positions = (0...10).collect do |i|
      m.apply(Context.new(20, p: i, t: t+1)).position
    end
    expect(strip_positions).to eq([2, 3, 4, 5, 6, 7, 8, 9, 10, 11])
  end

  it "works with slower frequencies" do
    t = Time.now
    m = Moving.new(0.5)
    strip_positions = (0...10).collect do |i|
      m.apply(Context.new(20, p: i, t: t+1)).position
    end
    expect(strip_positions).to eq([0.5, 1.5, 2.5, 3.5, 4.5, 5.5, 6.5, 7.5, 8.5, 9.5])
  end
end
