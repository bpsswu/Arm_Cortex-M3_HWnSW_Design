#include "rsa16.h"
// XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR

void rsa16_keygen(struct rsa_key *key)
{
    key->N = 47053;
    key->e = 17837;
    key->d = 22373;
}

u32 rsa16_encrypt(struct rsa_key pub_key, u32 data)
{
    rsa16_setInput(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR, data, pub_key.e, pub_key.N);
    rsa16_start(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR);
    while (!rsa16_isEnd(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR))
        ;
    return rsa16_getResult(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR);
}

u32 rsa16_decrypt(struct rsa_key pri_key, u32 data)
{
    rsa16_setInput(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR, data, pri_key.d, pri_key.N);
    rsa16_start(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR);
    while (!rsa16_isEnd(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR))
        ;
    return rsa16_getResult(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR);
}

u32 rsa16_sign(struct rsa_key pri_key, u32 data)
{
    rsa16_setInput(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR, data, pri_key.d, pri_key.N);
    rsa16_start(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR);
    while (!rsa16_isEnd(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR))
        ;
    return rsa16_getResult(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR);
}

u32 rsa16_verify(struct rsa_key pub_key, u32 data)
{
    rsa16_setInput(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR, data, pub_key.e, pub_key.N);
    rsa16_start(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR);
    while (!rsa16_isEnd(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR))
        ;
    return rsa16_getResult(XPAR_MYIP_RSA16_0_S00_AXI_BASEADDR);
}
