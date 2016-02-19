atomicjpeg : atomicjpeg.o -ljpeg
	gcc -o atomicjpeg atomicjpeg.o -ljpeg

install:
	cp atomicjpeg /usr/local/bin
