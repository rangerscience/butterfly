module Effects
  class Context
    attr_reader :size
    attr_accessor :color, :position, :time

    def initialize size, p: 0, t: Time.now, c: Colors::Black
      @size = size
      @position = p
      @time = t
      @color = c
    end

    def position= pos
      if pos >= @size
        @position = pos % @size
      elsif pos < 0
        @position = @size + pos
      else
        @position = pos
      end
    end
  end

  class Effect
    class << self
      def attribute *names
        names.each do |name|
          attr_accessor name
        end
      end
    end
  end
end
require_relative './effects/core.rb'
require_relative './effects/meta.rb'
