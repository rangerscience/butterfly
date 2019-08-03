include Effects
include Effects::Meta
include Effects::Core
describe Composition do
  it "is colorful" do
    c = Composition.new(
      Wheel.new(10),
      Pulse.new(
       p: 20,
       c: Colors::Green,
       iw: 5,
       ic: Colors::Yellow,
       ow: 5
     )
    )

    strip_colors = (0...40).collect do |i|
      c.apply(Context.new(40, p: i)).color
    end

    expect(strip_colors).not_to include(0)
    expect(strip_colors).not_to include(0xFFFFFF)
    expect(strip_colors.uniq.count).to eq(20)
  end

  describe "using other meta effects" do
    it "combines Effects" do
      t = Time.now
      c = Composition.new(
        Moving.new(1),
        Pulse.new(
         p: 5,
         c: Colors::Green,
         iw: 1,
         ic: Colors::Yellow,
         ow: 1
       )
     )

     strip_colors_t0 = (0...10).collect do |i|
       c.apply(Context.new(11, p: i, t: t)).color
     end

     strip_colors_t1 = (0...10).collect do |i|
       c.apply(Context.new(11, p: i, t: t+1)).color
     end

     expect(strip_colors_t0[1..8]).to eq(strip_colors_t1[0..7])
    end

    it "does not have side effects for position" do |i|
      t = Time.now
      c = Composition.new(
        Moving.new(1),
        Pulse.new(
         p: 5,
         c: Colors::Green,
         iw: 1,
         ic: Colors::Yellow,
         ow: 1
       )
     )

     strip_positions = (0...10).collect do |i|
       c.apply(Context.new(11, p: i, t: t+i)).position
     end

     expect(strip_positions).to eq((0...10).to_a)
    end
  end
end
