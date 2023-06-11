#ifndef MYIP_RSA16_H
#define MYIP_RSA16_H

#include "xil_types.h"
#include "xil_io.h"

void rsa16_start(u32 baseAddr);
void rsa16_setInput(u32 baseAddr, u32 base, u32 exp, u32 N);
u32 rsa16_getResult(u32 baseAddr);
u32 rsa16_isEnd(u32 baseAddr);

#endif // MYIP_RSA16_H
