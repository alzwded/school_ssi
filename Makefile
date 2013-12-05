CC = gcc
F77 = gfortran
#CFLAGS = -c -O3 -std=c99
#F77FLAGS = -c -O3
CFLAGS = -c -g -std=c99
F77FLAGS = -c -g
LD = gcc
LDOPTS = -lm

COBJS = intlog.o
FOBJS = enc.o tob64.o
OBJS = main.o

ssi: $(COBJS) $(FOBJS) $(OBJS)
	$(LD) -o ssi $(OBJS) $(FOBJS) $(COBJS) $(LDOPTS)

%.o: %.f
	$(F77) -o $@ $(F77FLAGS) $<
    
%.o: %.c
	$(CC) -o $@ $(CFLAGS) $<

clean:
	rm -f *.o ssi
