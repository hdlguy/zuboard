# sudo python3 mmap_test.py
import mmap
import os

# open /dev/mem driver
f = os.open("/dev/mem", os.O_RDWR | os.O_SYNC)

addr = 0x80000000 # start address of register file in fpga
mem = mmap.mmap(f, mmap.PAGESIZE, mmap.MAP_SHARED, mmap.PROT_READ | mmap.PROT_WRITE, offset=addr)

for i in range(8, 16):
    mem[i] = i

for i in range(0, 16):
    print(hex(mem[i]))

os.close(f)
