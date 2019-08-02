require 'sinatra'

$version = File.read('.version').chomp

$val = 1
t = Thread.new {
  loop do
    puts $val
  end
}

get '/' do
  $val = $val + 1s
  "Butterfly Server #{$version} #{Time.now}"
end
