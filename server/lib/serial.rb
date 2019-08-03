require 'rubyserial'

module Arduino

  class SerialOut
    attr_accessor :playing, :frame
    attr_reader :ports, :connections, :func, :frame_size, :slice_size

    def initialize &func
      @func = func
      @frame = func.call

      # Establish the connections
      @connections = if RUBY_PLATFORM =~ /darwin/ # MacOS
        @ports = `ls /dev/cu.*`.split("\n").select{|s| s =~ /cu.usbmodem/}
        ports.collect do |port|
          Serial.new port
        end
      else
        raise "I don't know how to detect Arduinos on this platform"
      end
    end

    def play
      @playing = true
      if @connections.size == 0
        @frame = fake_play
      else
        @frame = real_play
      end
      @playing = false
      @frame
    end

    private

    def fake_play
      @frame = func.call
      while(@playing) do
        # Render the frame, and do nothing with it....
        @frame = func.call
        sleep(0.1)
      end
      @frame
    end

    def real_play
      # Get a first frame for sizing
      @frame = func.call
      @frame_size = frame.size
      @slice_size = (@frame_size/@connections.size.to_f).round

      while(@playing) do
        # Render the frame
        @frame = func.call

        # Split the frame amongst the connections
        @frame.each_slice( @slice_size ).with_index do |slice, index|
          @connections[index].write(slice.map(&:chr).join(""))
        end
      end

      # Return the last frame
      @frame
    end
  end
end
