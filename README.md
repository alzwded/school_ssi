school_ssi
==========

School project for the security of information systems course

It is the implementation of an encryption method.

I have chosen to do the bulk of it in FORTRAN (gnu standard) with glue coming from C (c99 standard). Why? Because I can and I haven't coded in fort in a while. Also, the fixed width format is an anachronism.

Files
=====

| File | Language | Descrption |
|------|----------|------------|
| main.c | C | main entry point |
| intlog.c | C | trunc(log(N) * 10) used by the fort code |
| enc.f | FORTRAN | encoding function |
| tob64.f | FORTRAN | razzle-dazzle function |
| forfuncs.h | C | header with the extern declarations of the fort procedure |
| Makefile | Makefile | Makefile |

TODO
====

* debase64.f
* dec.f
* test bed
* command line interface
