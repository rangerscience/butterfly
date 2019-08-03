# About

This is code to control the lights of the Butterfly of https://www.facebook.com/TPATB2019

A Raspberry Pi (see that folder's readme for more) hosts a control server, renders frames,
and pushes those frames to connected devices.

Connected Arduinos (well, technically, the Butterfly uses Teensyduinos) then push the frames
to the LEDs.

The server code is in Ruby; Teensy code is in C.

# Setup

You will need Git LFS: https://git-lfs.github.com/ - *before* you clone the repo.
You will need Ruby (and Bundler). RVM is recommended.

# Contributing

Use branches, forks, and pull requests! Don't commit to master.

# Dev Guide

Instructions and files for setting up the hardware should go into the corresponding folders.

`server/lib/effects` contains the various basic effects out of which patterns can be made. Please add more!
`server/lib/compositions` contains preset patterns. Please add more!
`server/lib/serial` contains the code for pushing data to the Arduinos over serial connections (currently USB serial)

RSpec for testing. All tests currently pass, please keep it that way :)
