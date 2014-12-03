IDIR=../../Code/Project_Headers

CC=gcc
CFLAGS=-I$(IDIR)

LIBS=

_DEPS = fc_camera.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

OBJ = main.o ../../Code/Sources/fc_camera.o

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

camera_test: $(OBJ)
	gcc -o $@ $^ $(CFLAGS) $(LIBS)
