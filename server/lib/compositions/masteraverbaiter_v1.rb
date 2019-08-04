require_relative '../effects.rb'
module Compositions
  # MRB_V1 is also used in testing,
  # so make new ones rather than modifying this one :)

  MASTERAVERBAITER_V1 = Effects::Meta::Composition.new(

    # Draw onto a black background
    Effects::Core::Wipe.new(Colors::Black),

    # Multiple moving rainbow
    Effects::Meta::Composition.new(
        Effects::Meta::Moving.new(1),
        Effects::Core::Wheel.new(225),
        Effects::Core::Pulse.new(
          p: 0,
          c: 0xFFFFFF,
          iw: 4,
          ic: 0x000000,
          ow: 8
        )
    ),

    # A yellow->green pulse
    Effects::Meta::Composition.new(
      Effects::Meta::Moving.new(1),
      Effects::Core::Pulse.new(
        p: 35,
        c: Colors::Green,
        iw: 2,
        ic: Colors::Yellow,
        ow: 6
      )
    ),

    # A white->black pulse
    Effects::Meta::Composition.new(
      Effects::Meta::Moving.new(-1),
      Effects::Core::Pulse.new(
        p: 55,
        c: 0x000000,
        iw: 8,
        ic: 0xFFFFFF,
        ow: 10
      )
    ),
  )
end
