require 'base64'
require 'websocket-client-simple'
require 'pry'

Dir[File.join("./lib", "**/*.rb")].each do |f|
  require f
end

host = "butterfly.local"
#host = "localhost"

serial_out = Arduino::SerialOut.new

$frame_lock = Mutex.new
WebSocket::Client::Simple.connect "ws://#{host}:4567/sync" do |ws|
  ws.on :open do
    puts "connect!"
  end

  ws.on :message do |msg|
    Thread.new {
      if $frame_lock.try_lock
        serial_out.write Base64.decode64(msg.data)
        $frame_lock.unlock
      end
    }
  end
end

loop do
end
