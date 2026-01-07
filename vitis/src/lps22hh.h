// LPS22HH Registers

#define INTERRUPT_CFG   0x0B   // R/W 0B 00000000 Interrupt register
#define THS_P_L         0x0C   // R/W 0C 00000000
// Pressure threshold registers
#define THS_P_H         0x0D   // R/W 0D 00000000
#define IF_CTRL         0x0E   // R/W 0E 00000000 Interface control register
#define WHO_AM_I        0x0F   // R 0F 10110011 Who am I
#define CTRL_REG1       0x10   // R/W 10 00000000
#define CTRL_REG2       0x11   // R/W 11 00010000 Control registers
#define CTRL_REG3       0x12   // R/W 12 00000000
#define FIFO_CTRL       0x13   // R/W 13 00000000 FIFO configuration register
#define FIFO_WTM        0x14   // R/W 14 00000000
#define REF_P_L         0x15   // R 15 00000000
// Reference pressure registers
#define REF_P_H         0x16   // R 16 00000000
#define RPDS_L          0x18   // R/W 18 00000000
// Pressure offset registers
#define RPDS_H          0x19   // R/W 19 00000000
#define INT_SOURCE      0x24   // R 24 Output Interrupt register
#define FIFO_STATUS1    0x25   // R 25 Output
// FIFO status registers
#define FIFO_STATUS2    0x26   // R 26 Output
#define STATUS          0x27   // R 27 Output Status register
#define PRESSURE_OUT_XL 0x28   // R 28 Output
#define PRESSURE_OUT_L  0x29   // R 29 Output Pressure output registers
#define PRESSURE_OUT_H  0x2A   // R 2A Output
// Temperature output registers
#define TEMP_OUT_L      0x2B   // R 2B Output
#define TEMP_OUT_H      0x2C   // R 2C Output
// pressure output registers
#define FIFO_DATA_OUT_PRESS_XL  0x78 // R 78 Output
#define FIFO_DATA_OUT_PRESS_L   0x79 // R 79 Output FIFO pressure output registers
#define FIFO_DATA_OUT_PRESS_H   0x7A // R 7A Output

#define READ_MASK				0x80 //

