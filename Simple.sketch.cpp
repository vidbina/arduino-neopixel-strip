// Simple NeoPixel test.  Lights just a few pixels at a time so a
// 1m strip can safely be powered from Arduino 5V pin.  Arduino
// may nonetheless hiccup when LEDs are first connected and not
// accept code.  So upload code first, unplug USB, connect pixels
// to GND FIRST, then +5V and digital pin 6, then re-plug USB.
// A working strip will show a few pixels moving down the line,
// cycling between red, green and blue.  If you get no response,
// might be connected to wrong end of strip (the end wires, if
// any, are no indication -- look instead for the data direction
// arrows printed on the strip).

// https://learn.adafruit.com/neopixel-painter/test-neopixel-strip

#include <Adafruit_NeoPixel.h>

#define N_STRIPS 2

Adafruit_NeoPixel strips[N_STRIPS] = {
  Adafruit_NeoPixel(60,  9, NEO_GRB + NEO_KHZ800),
  Adafruit_NeoPixel(144, 6, NEO_GRB + NEO_KHZ800),
};

uint16_t cursors[N_STRIPS] = { 0, 0 };

// TODO: check that all strips are defined pre-setup
void setup() {
  for(uint8_t i=0;i<N_STRIPS;i++) {
    strips[i].begin(); // WARN: unsafe, should check that strip exists
    strips[i].show();
  }
}

void loop() {
  scroll_step();
  scroll_refresh();
  delay(100);
}

const uint8_t scroll_width = 10;
static void scroll_step() {
  for(uint8_t i=0;i<N_STRIPS;i++) {
    if(cursors[i] == strips[i].numPixels()-1) {
      cursors[i] = 0;
    } else {
      cursors[i]++;
    }
  }
}

static void scroll_refresh() {
  for(uint8_t i=0;i<N_STRIPS;i++) {
    strips[i].setPixelColor(cursors[i], strips[i].Color(0, 127, 64));
    if(cursors[i] > scroll_width-1) {
      strips[i].setPixelColor(cursors[i]-scroll_width, 0);
    } else {
      strips[i].setPixelColor(strips[i].numPixels()-(scroll_width-cursors[i]), 0);
    }
    strips[i].show();
  }
}

static void chase(uint8_t j, uint32_t c) {
  for(uint16_t i=0; i<strips[j].numPixels()+4; i++) {
      strips[j].setPixelColor(i  , c); // Draw new pixel
      strips[j].setPixelColor(i-4, 0); // Erase pixel a few steps back
      strips[j].show();
      delay(5);
  }
}
