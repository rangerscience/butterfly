module Effects
  module Meta
    class Composition
      attr_accessor :effects

      def initialize *effects
        @effects = effects
      end

      def apply c
        c.color = @effects.inject(c.dup) do |c, effect|
          effect.apply(c)
        end.color
        c
      end
    end

    class Moving
      attr_accessor :frequency

      def initialize f, s: Time.now
        @frequency = f
        @start = s
      end

      def apply c
        #binding.pry
        c.position = c.position + ((c.time.to_i - @start.to_i) * @frequency)
        c
      end
    end
  end
end
