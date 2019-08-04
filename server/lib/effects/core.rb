require_relative '../colors.rb'
module Effects
  module Core
    class Wipe < Effect
      attribute :color

      def initialize c
        @color = c
      end

      def apply c
        c.color = color
        c
      end
    end

    class Wheel < Effect
      attribute :wavelength, :saturation, :value

      def initialize w, s: 100, v: 100
        @wavelength = w
        @saturation = s
        @value = v
      end

      def apply c
        phase = (c.position % wavelength) / wavelength.to_f
        hue = phase * 360.0
        c.color = Colors.hsv_to_rgb hue, saturation, value
        c
      end
    end

    class Pulse < Effect
      attribute :position, :color, :inner_color, :inner_width, :outer_width

      def initialize p:, c:, ic:, iw:, ow:
        @position = p
        @color = c
        @inner_color = ic
        @inner_width = iw
        @outer_width = ow
      end

      def apply c
        if c.position == position
          c.color = color
        elsif (position - inner_width) <= c.position && c.position <= (position + inner_width)
          c.color = inner_color
        elsif (position - inner_width - outer_width) <= c.position && c.position <= (position + inner_width + outer_width)
          percent = ((outer_width - (c.position - position).abs).abs - inner_width).abs.to_f / (outer_width+1)
          c.color = Colors.blend c.color, inner_color, percent
        elsif (position - inner_width - outer_width + c.size) <= c.position && c.position <= (position + inner_width + outer_width + c.size)
          percent = ((outer_width - (c.position - (position - c.size)).abs).abs - inner_width).abs.to_f / (outer_width+1)
          c.color = Colors.blend c.color, inner_color, percent
        end
        c
      end
    end
  end
end
