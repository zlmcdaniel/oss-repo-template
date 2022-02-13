all: static_block dynamic_block

static_block: program.o staticlib.a
	cc -o static_block program.o staticlib.a
dynamic_block: program.o sharedlib.so
	cc program.o sharedlib.so -o dynamic_block -Wl,-rpath .
block.o: source/block.c
	cc -fPIC -c source/block.c -o block.o
program.o: program.c
	cc -c program.c -o program.o
staticlib.a: block.o
	ar -rcs staticlib.a block.o
sharedlib.so: block.o
	cc -shared -o sharedlib.so block.o
clean:
	rm static_block dynamic_block block.o sharedlib.so staticlib.a