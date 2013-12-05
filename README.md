School project for the security of information systems course

It is the implementation of an encryption method.

I have chosen to do the bulk of it in FORTRAN (gnu standard) with glue coming from C (c99 standard). Why? Because I can and I haven't coded in fort in a while. Also, the fixed width format is an anachronism.

Files
=====

| File | Language | Descrption |
|------|----------|------------|
| `main.c` | C | main entry point |
| `intlog.c` | C | `trunc(log(N) * 10)` used by the fort code |
| `enc.f` | FORTRAN | linear encoding function using the key and MAGIC1 |
| `tob64.f` | FORTRAN | razzle-dazzle function, switching alphabet based on permutation |
| `forfuncs.h` | C | header with the extern declarations of the fort procedures |
| `Makefile` | Makefile | Makefile |

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
  - debase64.f (i.e. decoder, pt1)
  - dec.f (i.e. decoder, pt2)
  - rndspc.f (i.e. (pseudo-)random spaces insertion, encoder, pt3)
    + always after `/'./`, `s/("[^"]")/ \1 /`, then furthest away from nearest spaces based on whatever entropy could be gathered from the input

Keys
====

1. secret
1. permutation of alphabet
1. MAGIC1 magic number
