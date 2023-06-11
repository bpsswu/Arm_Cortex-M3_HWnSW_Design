#ifndef RSA16_H
#define RSA16_H

#include "myip_rsa16.h"
#include "xparameters.h"

struct rsa_key
{
    u32 N;
    u32 e;
    u32 d;
};

void rsa16_keygen(struct rsa_key *key);
u32 rsa16_encrypt(struct rsa_key pub_key, u32 data);
u32 rsa16_decrypt(struct rsa_key pri_key, u32 data);
u32 rsa16_sign(struct rsa_key pri_key, u32 data);
u32 rsa16_verify(struct rsa_key pub_key, u32 data);

#endif // RSA16_H
