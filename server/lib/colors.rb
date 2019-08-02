module Colors
  #          RRGGBB
  Black  = 0x000000
  White  = 0xFFFFFF
  Yellow = 0xFFFF00
  Green  = 0x00FF00

  class << self
    def hsv_to_rgb(h, s, v)
      h, s, v = h.to_f/360, s.to_f/100, v.to_f/100
      h_i = (h*6).to_i
      f = h*6 - h_i
      p = v * (1 - s)
      q = v * (1 - f*s)
      t = v * (1 - (1 - f) * s)
      r, g, b = v, t, p if h_i==0
      r, g, b = q, v, p if h_i==1
      r, g, b = p, v, t if h_i==2
      r, g, b = p, q, v if h_i==3
      r, g, b = t, p, v if h_i==4
      r, g, b = v, p, q if h_i==5
      [(r*255).to_i, (g*255).to_i, (b*255).to_i]
    end

    def blend c1, c2, r
      # Can't really do fancier math, but could mabe unroll the loop, etc
      c2 + [0xFF0000, 0x00FF00, 0x0000FF].collect do |m|
        (((m & c1) - (m & c2)) * r).to_i & m
      end.sum
    end
  end
end
