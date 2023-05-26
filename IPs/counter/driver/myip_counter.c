#include "myip_counter.h"

void set_counter(u32 base_addr, u32 data)
{
    Xil_Out32(base_addr, data);
}

void set_startvalue(u32 base_addr, u32 data)
{
    Xil_Out32(base_addr + 4, data);
}

u32 read_counter(u32 base_addr)
{
    return Xil_In32(base_addr + 12);
}
