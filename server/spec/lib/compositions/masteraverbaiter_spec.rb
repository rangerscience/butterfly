include Compositions
include Effects

describe MASTERAVERBAITER_V1 do
  it "is very colorful" do
    t = Time.now
    strip_colors = (0...100).collect do |i|
      MASTERAVERBAITER_V1.apply(Context.new(100, p: i, t: t)).color
    end

    # 4 black from the inner color of the first pulse, one black from the
    # peak of the last pulse
    expect(strip_colors.select{|c| c == 0}.count).to eq(2*2 + 1)

    # 1 white from the peak of the first pulse, and 16 from the inner part
    # of the last pulse
    expect(strip_colors.select{|c| c == 0xFFFFFF}.count).to eq(8*2 + 1)

    # Peak of the middle pulse, plus one...?
    expect(strip_colors.select{|c| c == Colors::Green}.count).to eq(2)

    # Inner of the middle pulse
    expect(strip_colors.select{|c| c == Colors::Yellow}.count).to eq(4)

    # Everything else :) (just as measured, not actually derived)
    # (it's a deliberately chaotic pattern after all :D)
    expect(strip_colors.uniq.count).to eq(76)
  end

  it "changes over time" do
    t = Time.now

    strip_colors_t0 = (0...100).collect do |i|
      MASTERAVERBAITER_V1.apply(Context.new(100, p: i, t: t)).color
    end

    strip_colors_t1 = (0...100).collect do |i|
      MASTERAVERBAITER_V1.apply(Context.new(100, p: i, t: t+1)).color
    end

    # Can't do the usual trick, because some of the things in MRB move backwards
    expect(strip_colors_t0[10..90]).not_to eq(strip_colors_t1[11..91])
  end
end
