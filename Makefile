HSC2HS = hsc2hs
GHC    = ghc
CABAL  = cabal

GHC_RUNTIME_LINKER_FLAG = -lHSrts-ghc7.8.3

.PHONY: dist/build/Example.o
dist/build/Example.o: src/Example.hs
	$(CABAL) configure && $(CABAL) build

.PHONY: wrapper
wrapper: cbits/wrapper.c dist/build/Example.o
	$(GHC) --make -no-hs-main -optc-O cbits/wrapper.c src/Example.hs -I./dist/build/ -I./include -o wrapper

clean:
	rm -fr src/*.hi *.o */*.o src/*.hsc dist wrapper *.out *.so src/*_out.hs src/*.h

all: wrapper
	./wrapper
