#include "myip_rsa16.h"

void rsa16_start(u32 baseAddr)
{
    Xil_Out32(baseAddr, 0x00000000);
    Xil_Out32(baseAddr, 0x00000001);
    Xil_Out32(baseAddr, 0x00000000);
}

void rsa16_setInput(u32 baseAddr, u32 base, u32 exp, u32 N)
{
    Xil_Out32(baseAddr + 4, base);
    Xil_Out32(baseAddr + 8, exp);
    Xil_Out32(baseAddr + 12, N);
}

u32 rsa16_getResult(u32 baseAddr)
{
    return Xil_In32(baseAddr + 16);
}

u32 rsa16_isEnd(u32 baseAddr)
{
    return Xil_In32(baseAddr + 20);
}
