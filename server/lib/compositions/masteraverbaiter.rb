require_relative '../effects.rb'
module Compositions
  MASTERAVERBAITER = Effects::Meta::Composition.new(

    # Draw onto a black background
    Effects::Core::Wipe.new(Colors::Black),

    # Multiple moving rainbow
    Effects::Meta::Composition.new(
        Effects::Meta::Moving.new(f: 1),
        Effects::Core::Wheel.new(150)
    ),

    # A black->white pulse
    Effects::Meta::Composition.new(
      Effects::Meta::Moving.new(f: 1.5),
      Effects::Core::Pulse.new(
        p: 15,
        c: Colors::White,
        iw: 2,
        ic: Colors::Black,
        ow: 6
      )
    ),

    # A yellow->green pulse
    Effects::Meta::Composition.new(
      Effects::Meta::Moving.new(f: 1),
      Effects::Core::Pulse.new(
        p: 15,
        c: Colors::Green,
        iw: 2,
        ic: Colors::Yellow,
        ow: 6
      )
    ),

    # A white->black pulse
    Effects::Meta::Composition.new(
      Effects::Meta::Moving.new(f: -1),
      Effects::Core::Pulse.new(
        p: 15,
        c: Colors::Black,
        iw: 8,
        ic: Colors::White,
        ow: 10
      )
    ),
  )
end
