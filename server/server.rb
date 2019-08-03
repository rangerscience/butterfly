require 'sinatra'

Dir[File.join("./lib", "**/*.rb")].each do |f|
  require f
end

module PrintHex
  def to_hex_s
    "0x" + to_s(16).upcase.rjust(6, '0')
  end
end
Integer.include PrintHex

NUM_LEDS = 300
$version = File.read('.version').chomp
$active_pattern = Compositions::MASTERAVERBAITER_V1
$s = Arduino::SerialOut.new do
  t = Time.now
  c = Effects::Context.new(NUM_LEDS, t: t)
  (0..NUM_LEDS).collect do |i|
    c.position = i
    $active_pattern.apply(c)
    c.color
  end
end

get '/' do
  "Butterfly Server #{$version} #{NUM_LEDS} #{$s.playing}"
end

get '/frame' do
  $s.frame.map{|c| c.to_hex_s}.join("\n")
  #$frame.map{|c| c.to_hex_s}.join("\n")
end

# get '/debug' do
#   require 'pry'
#   binding.pry
#   $s.frame.map{|c| c.to_hex_s}.join("\n")
# end

$t = Thread.new { $s.play }
