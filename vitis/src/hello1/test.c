
#include <stdio.h>
#include "xil_printf.h"
#include "xparameters.h"
#include "fpga.h"

#define XPAR_M00_AXI_BASEADDR 0x80000000

int main () 
{    
    xil_printf("\n\rHello!\n\r");

    uint32_t *regptr = (uint32_t *)XPAR_M00_AXI_BASEADDR;
    xil_printf("regptr = %u\n\r", regptr);
    xil_printf("FPGA_ID = 0x%08x, FPGA_VERSION = 0x%08x\n\r", regptr[FPGA_ID], regptr[FPGA_VERSION]);

    xil_printf("Goodbye!\n\r");

    return(0);
}