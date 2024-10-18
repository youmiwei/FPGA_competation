#include "stdio.h"
#include "xparameters.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "sleep.h"
#include "led_test/led_test.h"

#define xil_printf  printf

int main()
{
    printf("BEGIN!\n");
    
    while(1)
    {
        LED_TEST_mWriteReg(XPAR_LED_TEST_0_BASEADDR,LED_TEST_S00_AXI_SLV_REG0_OFFSET,0x00000000);
        sleep(1);
        LED_TEST_mWriteReg(XPAR_LED_TEST_0_BASEADDR,LED_TEST_S00_AXI_SLV_REG0_OFFSET,0x00000001);
        sleep(1);
    }
    return 0;
}