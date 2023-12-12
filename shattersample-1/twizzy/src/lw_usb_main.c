#include <stdio.h>
#include "platform.h"
#include "GenericMacros.h"
#include "GenericTypeDefs.h"
#include "MAX3421E.h"
#include "USB.h"
#include "usb_ch9.h"
#include "transfer.h"
#include "HID.h"
#include "xparameters.h"
#include <xgpio.h>
#include "xil_printf.h"
#include <stdint.h>
#include <stdlib.h>

#define MAX_POSITION 255

extern HID_DEVICE hid_device;

static XGpio Gpio_hex;

static BYTE addr = 1; 				//hard-wired USB address
const char* const devclasses[] = { " Uninitialized", " HID Keyboard", " HID Mouse", " Mass storage" };

BYTE GetDriverandReport() {
	BYTE i;
	BYTE rcode;
	BYTE device = 0xFF;
	BYTE tmpbyte;

	DEV_RECORD* tpl_ptr;
	xil_printf("Reached USB_STATE_RUNNING (0x40)\n");
	for (i = 1; i < USB_NUMDEVICES; i++) {
		tpl_ptr = GetDevtable(i);
		if (tpl_ptr->epinfo != NULL) {
			xil_printf("Device: %d", i);
			xil_printf("%s \n", devclasses[tpl_ptr->devclass]);
			device = tpl_ptr->devclass;
		}
	}
	//Query rate and protocol
	rcode = XferGetIdle(addr, 0, hid_device.interface, 0, &tmpbyte);
	if (rcode) {   //error handling
		xil_printf("GetIdle Error. Error code: ");
		xil_printf("%x \n", rcode);
	} else {
		xil_printf("Update rate: ");
		xil_printf("%x \n", tmpbyte);
	}
	xil_printf("Protocol: ");
	rcode = XferGetProto(addr, 0, hid_device.interface, &tmpbyte);
	if (rcode) {   //error handling
		xil_printf("GetProto Error. Error code ");
		xil_printf("%x \n", rcode);
	} else {
		xil_printf("%d \n", tmpbyte);
	}
	return device;
}

void printHex (u32 data, unsigned channel)
{
	XGpio_DiscreteWrite (&Gpio_hex, channel, data);
}

uint8_t randomize(volatile uint8_t setting_position, volatile uint8_t setting_spray)
{
    if (setting_spray == 0) {
        return setting_position;
    }

    int random = (rand() % (int)setting_spray) - (int)(setting_spray / 2);
    int start = (int)setting_position + random;

    if(start > MAX_POSITION) start = MAX_POSITION;
    else if(start < 0) start = 0;

    return (uint8_t)start;
}


uint8_t randomize_bool(uint8_t chance) {
    // Generate a random number between 0 and 255
    uint8_t random_num = rand() % 256;

    // Compare the random number with the input chance
    if (random_num < chance) {
        return 1;
    } else {
        return 0;
    }
}


volatile uint32_t* spray_pos = (uint32_t*)0x40030000;
volatile uint32_t* out = (uint32_t*)0x40040000;
volatile uint32_t* lengths = (uint32_t*)0x40050000;

int main() {
    init_platform();
    XGpio_Initialize(&Gpio_hex, XPAR_GPIO_USB_KEYCODE_DEVICE_ID);
   	XGpio_SetDataDirection(&Gpio_hex, 1, 0x00000000); //configure hex display GPIO
   	XGpio_SetDataDirection(&Gpio_hex, 2, 0x00000000); //configure hex display GPIO


   	BYTE rcode;
	BOOT_MOUSE_REPORT buf;		//USB mouse report
	BOOT_KBD_REPORT kbdbuf;

	BYTE runningdebugflag = 0;//flag to dump out a bunch of information when we first get to USB_STATE_RUNNING
	BYTE errorflag = 0; //flag once we get an error device so we don't keep dumping out state info
	BYTE device;

	xil_printf("initializing MAX3421E...\n");
	MAX3421E_init();
	xil_printf("initializing USB...\n");
	USB_init();
	while (1) {
		xil_printf("."); //A tick here means one loop through the USB main handler
		MAX3421E_Task();
		USB_Task();
		if (GetUsbTaskState() == USB_STATE_RUNNING) {
			if (!runningdebugflag) {
				runningdebugflag = 1;
				device = GetDriverandReport();
			} else if (device == 1) {
				//run keyboard debug polling
				rcode = kbdPoll(&kbdbuf);
				if (rcode == hrNAK) {
					continue; //NAK means no new data
				} else if (rcode) {
					xil_printf("Rcode: ");
					xil_printf("%x \n", rcode);
					continue;
				}
				xil_printf("keycodes: ");
				for (int i = 0; i < 6; i++) {
					xil_printf("%x ", kbdbuf.keycode[i]);
				}
				//Outputs the first 4 keycodes using the USB GPIO channel 1
				printHex (kbdbuf.keycode[0] + (kbdbuf.keycode[1]<<8) + (kbdbuf.keycode[2]<<16) + + (kbdbuf.keycode[3]<<24), 1);
				//Modify to output the last 2 keycodes on channel 2.
				xil_printf("\n");
			}

			else if (device == 2) {
				rcode = mousePoll(&buf);
				if (rcode == hrNAK) {
					//NAK means no new data
					continue;
				} else if (rcode) {
					xil_printf("Rcode: ");
					xil_printf("%x \n", rcode);
					continue;
				}
				xil_printf("X displacement: ");
				xil_printf("%d ", (signed char) buf.Xdispl);
				xil_printf("Y displacement: ");
				xil_printf("%d ", (signed char) buf.Ydispl);
				xil_printf("Buttons: ");
				xil_printf("%x\n", buf.button);
			}
		} else if (GetUsbTaskState() == USB_STATE_ERROR) {
			if (!errorflag) {
				errorflag = 1;
				xil_printf("USB Error State\n");
				//print out string descriptor here
			}
		} else //not in USB running state
		{

			xil_printf("USB task state: ");
			xil_printf("%x\n", GetUsbTaskState());
			if (runningdebugflag) {	//previously running, reset USB hardware just to clear out any funky state, HS/FS etc
				runningdebugflag = 0;
				MAX3421E_init();
				USB_init();
			}
			errorflag = 0;
		}

		volatile uint8_t pos = (uint8_t)(*spray_pos >> 24);
		volatile uint8_t spray = (uint8_t)(*spray_pos >> 16);
		volatile uint8_t dens = (uint8_t)(*spray_pos >> 8);
		volatile uint8_t dens_rand = (uint8_t)(*spray_pos);

		volatile uint8_t len = (uint8_t)(*lengths >> 16);
		volatile uint8_t len_rand = (uint8_t)(*lengths >> 8);
		volatile uint8_t reverse_ratio = (uint8_t)(*lengths);

		uint8_t pos_mod;
		uint8_t dens_mod;
		uint8_t len_mod;
		uint8_t reverse;
		pos_mod = randomize(pos, spray);
		dens_mod = randomize(dens, dens_rand);
		len_mod = randomize(len, len_rand);
		reverse = randomize_bool(reverse_ratio);

		*out = (uint32_t)pos_mod << 24 | (uint32_t)dens_mod << 16 | len_mod << 8 | reverse;

	}
    cleanup_platform();
	return 0;
}

