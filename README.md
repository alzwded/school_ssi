School project for the security of information systems course

It is the implementation of an encryption method.

I have chosen to do the bulk of it in FORTRAN (gnu standard) with glue coming from C (c99 standard). Why? Because I can and I haven't coded in fort in a while. Also, the fixed width format is an anachronism.

Files
=====

| File | Language | Descrption |
|------|----------|------------|
| `main.c` | C | main entry point |
| `forfuncs.h` | C | header with the extern declarations of the fort procedures |
| `enc.f` | FORTRAN | linear encoding function using the key and MAGIC1 |
| `tob64.f` | FORTRAN | razzle-dazzle function, switching alphabet based on permutation |
| `spacfr.f` | FORTRAN | random character inserter |
| `alphbt.f` | FORTRAN | alphabet coding functions and data |
| `keyhas.f` | FORTRAN | key hash function and data |
| `despcf.f` | FORTRAN | remove randomly inserted characters |
| `rngmat.f` | FORTRAN | generate a vector of random numbers and data |
| `rng.c` | C | RNG used by the fort code |
| `Makefile` | Makefile | Makefile |

Dependencies
============

| File | Deps |
|------|------|
| `rng.c` | - |
| `keyhas.f` | - |
| `alphbt.f` | - |
| `rngmat.f` | `rng.c` |
| `enc.f` | `keyhas.f` |
| `tob64.f` | `alphbt.f` `rng.c` `keyhas.f` |
| `spacfr.f` | `alphbt.f` `rng.c`  `keyhas.f` |
| `despcf.f` | `alphbt.f` `rngmat.f` `keyhas.f` |
| `main.c` | `enc.f` `tob64.f` `spacfr.f` `despcf.f` |

TODO
====

* test bed
* command line interface
  - read key from STDIN
  - read MAGIC1 from config file
  - read permutation of alphabet from config file
  - read input
  - read encode-or-decode switch
  - write output
* backend
  - use external permutation on alphabet
  - MAGIC1 is not a PARAMETER, but an input parameter
  - ~~despcf.f (i.e. decoder, pt1)~~
  - deb64.f (i.e. decoder, pt2)
  - dec.f (i.e. decoder, pt3)
  - ~~rndspc.f (i.e. (pseudo-)random spaces insertion, encoder, pt3)~~
    + ~~no more spaces. Based on the key hash acting as a seed, insert random characters from the alphabet on positions matching a certain rule~~

Keys
====

1. secret
1. permutation of alphabet
1. MAGIC1 magic number

Tentative notes
===============

Right, I haven't studied enough to know what I'm talking about, so I'll throw some buzzwords around:
* private key
* autokey
* linear transformations
* permutation
* alphabet
* confusion

Architecture
============

Layer 1:  
This is the command line utility and main entry point level. This here receives switch from the user, reads the config file containing the permutation and MAGIC1 values, prompts the user for the secret, reads the input and writes the resulting output, all the while sanity-checking input parameters of any kind.

Layer 2:  
Encryption/Decryption functions. These take input and assume it's consistent and produce output

Layer 3:  
Utilities used by the enc/dec functions. These are essentially very low level.
