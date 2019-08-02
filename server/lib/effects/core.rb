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
      attribute :position, :color, :inner_color, :inner_width, :outer_color, :outer_width

      def initialize p:, c:, ic:, iw:, oc:, ow:
        @position = p
        @color = c
        @inner_color = ic
        @inner_width = iw
        @outer_color = oc
        @outer_width = ow
      end

      def apply c
        if c.position == position
          c.color = color
        elsif (position - inner_width) <= c.position && c.position <= (position + inner_width)
          c.color = inner_color
        elsif (position - inner_width - outer_width) <= c.position && c.position <= (position + inner_width + outer_width)
          percent = (c.position - position).abs / (inner_width + outer_width)
          c.color = Colors.blend c.color, color, percent
        end
        c
      end
    end
  end
end
