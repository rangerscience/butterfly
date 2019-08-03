#define USE_OCTOWS2811

// 3rd Party Libs
#include<OctoWS2811.h>
#include <FastLED.h>

#define NUM_STRIPS 8
#define LEDS_PER_STRIP 300
#define NUM_LEDS NUM_STRIPS*LEDS_PER_STRIP

CRGB _LEDS[NUM_LEDS];

void setup() {
  delay(100);
  Serial.begin(9600); // USB is always 12 Mbit/sec

  FastLED.addLeds<OCTOWS2811>(_LEDS, LEDS_PER_STRIP);
  FastLED.setBrightness( 255 );

  for(int j = 0; j < NUM_LEDS; j++) {
    _LEDS[j] = CRGB::White;
  }

  FastLED.show();
}

void loop() {
  if(Serial.available()) {
    int i = 0;
    while (Serial.available() && i < NUM_LEDS) {
      byte pixel[3] = {0,0,0};
      pixel[0] = Serial.read();
      pixel[1] = Serial.read();
      pixel[2] = Serial.read();

      CRGB p = new CRGB;
      p.red = pixel[0];
      p.green = pixel[1];
      p.blue = pixel[2];

      _LEDS[i] = p;


      i++;
    }

    FastLED.show();
  }
}
