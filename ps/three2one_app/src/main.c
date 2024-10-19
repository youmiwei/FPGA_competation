#include "stdio.h"
#include "xparameters.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "sleep.h"
#include "decode_conf_data/decode_conf_data.h"

#define xil_printf  printf

int main()
{
    u32 i = 0;
    printf("BEGIN!\n");

    while(1)
    {
        DECODE_CONF_DATA_mWriteReg(XPAR_DECODE_CONF_DATA_0_BASEADDR,DECODE_CONF_DATA_S00_AXI_SLV_REG0_OFFSET,0x00000000);
        DECODE_CONF_DATA_mWriteReg(XPAR_DECODE_CONF_DATA_0_BASEADDR,DECODE_CONF_DATA_S00_AXI_SLV_REG1_OFFSET,0x00001000);
        DECODE_CONF_DATA_mWriteReg(XPAR_DECODE_CONF_DATA_0_BASEADDR,DECODE_CONF_DATA_S00_AXI_SLV_REG2_OFFSET,0x00000000);
        DECODE_CONF_DATA_mWriteReg(XPAR_DECODE_CONF_DATA_0_BASEADDR,DECODE_CONF_DATA_S00_AXI_SLV_REG3_OFFSET,0);
        DECODE_CONF_DATA_mWriteReg(XPAR_DECODE_CONF_DATA_0_BASEADDR,DECODE_CONF_DATA_S00_AXI_SLV_REG0_OFFSET,0x00000001);
        sleep(10);
        i++;
        if(i == 4)
            i = 0;
    }
    return 0;
}
