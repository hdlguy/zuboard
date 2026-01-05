#include "xil_printf.h"
#include "xparameters.h"
#include "fpga.h"


int main()
{

    xil_printf("Hello World\n\r");
    
    uint32_t *regptr = (uint32_t *)XPAR_REGFILE_CTRL_BASEADDR;

    xil_printf("regptr = %p\n\r", regptr);
    
    uint32_t whilecount=0;
	while(1){

        xil_printf("%08d: FPGA_ID = 0x%08x, FPGA_VERSION = 0x%08x\n\r", whilecount, regptr[FPGA_ID], regptr[FPGA_VERSION]);
        for(int i=0; i<20000000; i++);
        whilecount++;
    }
    
    return 0;
}
