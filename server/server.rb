require 'sinatra'
require 'sinatra-websocket'

Dir[File.join("./lib", "**/*.rb")].each do |f|
  require f
end

require 'pry'

set :server, 'thin'
set :sockets, []
set :num_leds, 4400
set :version, File.read('.version').chomp

class Renderer
  attr_accessor :pattern, :num_leds

  def initialize pattern, num_leds
    @pattern = pattern
    @num_leds = num_leds
  end

  def render
    t = Time.now
    c = Effects::Context.new(@num_leds, t: t)
    (0..@num_leds).collect do |i|
      c.position = i
      @pattern.apply(c)
      c.color
    end
  end
end

set :renderer, Renderer.new(Compositions::MASTERAVERBAITER_V1, settings.num_leds)

set :playing, true

def play
  serial_out = Arduino::SerialOut.new

  Thread.new do
    while(settings.playing)
      # Render frame
      frame = settings.renderer.render

      # Write out to serial ports
      serial_out.write frame

      # Write out to websockets
      settings.sockets.each do |s|
        byte_string = frame.map(&:to_rgba_bytes).join("")
        s.send(Base64.encode64(byte_string))
      end

      # Give other threads some time
      sleep(0.1)
    end
  end
end

get '/' do
  "Butterfly Server #{settings.version} #{settings.num_leds}"
end

get '/frame' do
  settings.renderer.render.map{|c| c.to_hex_s}.join("\n")
end

get '/subscribe' do
  if request.websocket?
    request.websocket do |ws|
      ws.onopen do
        settings.sockets << ws
      end

      ws.onclose do
        settings.sockets.delete(ws)
      end
    end
  else
    "for websockets only"
  end
end

get '/preview' do
  slim :preview
end


get '/pry' do
  binding.pry
end

$t = play
