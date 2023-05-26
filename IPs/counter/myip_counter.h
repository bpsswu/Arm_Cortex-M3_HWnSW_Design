#ifndef MYIP_COUNTER_H
#define MYIP_COUNTER_H

#include "xil_types.h"
#include "xil_io.h"

void set_counter(u32 base_addr, u32 data);
void set_startvalue(u32 base_addr, u32 data);

u32 read_counter(u32 base_addr);

#endif // MYIP_COUNTER_H
