


#include "led.h"
#include "simpletimer.h"

// morse_init(5, &port_a, 0x01, 0x00);
// morse_msg("Hello All");

void morse_init(uint8_t wpm);
void morse_echo_to_usb(uint8_t echo);

void morse_char(char c);
void morse_msg(char* str);

