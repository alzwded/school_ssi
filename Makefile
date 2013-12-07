CC = gcc
F77 = gfortran
#CFLAGS = -c -O3 -std=c99
#F77FLAGS = -c -O3 -cpp
CFLAGS = -c -g -std=c99 -I.
F77FLAGS = -c -g -cpp -I. -std=gnu
LD = gcc
LDOPTS = -lm

# C obj's the fortran obj's depend on
COBJS = rng.o
# main fortran backend obj's
FOBJS = enc.o tob64.o spacfr.o alphbt.o 
# main user-facing obj's
OBJS = main.o
# ...and dependencies are accounted for!

ssi: $(COBJS) $(FOBJS) $(OBJS)
	$(LD) -o ssi $(OBJS) $(FOBJS) $(COBJS) $(LDOPTS)

%.o: %.f
	$(F77) -o $@ $(F77FLAGS) $<
    
%.o: %.c
	$(CC) -o $@ $(CFLAGS) $<

clean:
	rm -f *.o ssi
