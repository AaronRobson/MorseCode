.DEFAULT_GOAL := all

.PHONY: all
all: build

.PHONY: clean
clean:
	rm -f \
	*.hi \
	*.o \
	MorseCode

.PHONY: build
build: MorseCode

MorseCode: MorseCode.hs
	ghc MorseCode.hs -main-is MorseCode

.PHONY: run
run: build
	./MorseCode
