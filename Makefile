all: concat build clean

concat:
	cat src/pkgman-* > pkgman.tmp
	
	sed '/# INSERT PKGMAN/ r pkgman.tmp' src/main.sh > piu1.tmp
	sed '/# INSERT DISTRO-DETECT/ r src/distro-detect.sh' piu1.tmp > piu2.tmp

build:
	mkdir -p bin
	cp piu2.tmp bin/piu

clean:
	rm pkgman.tmp
	rm piu1.tmp
	rm piu2.tmp
