require 'rubyserial'

module PrintHex
  def to_hex_s
    "0x" + to_s(16).upcase.rjust(6, '0')
  end
end
Integer.include PrintHex

module Arduino
  class SerialOut
    attr_reader :ports, :connections, :slice_size

    def initialize
      # Establish the connections
      @connections = if RUBY_PLATFORM =~ /darwin/ # MacOS
        @ports = `ls /dev/cu.*`.split("\n").select{|s| s =~ /cu.usbmodem/}
        @ports.collect do |port|
          Serial.new port
        end
      elsif RUBY_PLATFORM =~ // # Raspberry Pi linux
        @ports = `ls /dev/ttyACM*`.split("\n")
        @ports.collect do |port|
          Serial.new port
        end
      else
        raise "I don't know how to detect Arduinos on this platform"
      end
    end

    def write frame
      @connections.each do |connection|
        connection.write(frame)
        true
      end
    end
  end
end
