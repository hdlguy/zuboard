// this little program uses direct access to the i2c driver to read the first page of the AT24M eeprom.
#include <stdint.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>
#include <sys/fcntl.h> 
#include <sys/stat.h>
#include <sys/ioctl.h>      
#include <linux/i2c-dev.h>
#include <unistd.h>     
#include <stdio.h>
#include <stdlib.h>

int main(int argc,char** argv)
{
    static const ulong addr = 0x50;  // 7-bit address on the I2C bus

    char dev[32] = "/dev/i2c-0";
    int fd = open(dev, O_RDWR);
    if (fd == -1) {
        perror("open device:");
        return -1;
    }

    printf("%s open, fd = 0x%08x\n", dev, fd);

    ioctl(fd, I2C_SLAVE, addr);  // tell the driver what i2c address to use.

    char sendbuf[256], recvbuf[256];
    sendbuf[0] = 0; 
    sendbuf[1] = 0;
    write(fd, sendbuf, 2); 
    read(fd, recvbuf, 256);
    
    for (int i=0; i<16; i++) {
        for (int j=0; j<16; j++) {
            printf("%02x ", recvbuf[i*16+j]);
        }
        printf("\n");
    }
   		
    close(fd);

    return 0;
}


