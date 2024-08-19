# Assembler and linker
AS = ca65
LD = ld65

# Source and output files
SRC = clearmem.asm
OBJ = clearmem.o
NES = clearmem.nes
DBG = clearmem.fdb

# Configuration file
CFG = ../../nes.cfg

# Emulator
EMU = fceux

# Rules
all: $(NES)

$(OBJ): $(SRC)
	$(AS) -g -o $(OBJ) $(SRC)

$(NES): $(OBJ)
	$(LD) $(OBJ) -C $(CFG) -o $(NES) --dbgfile $(DBG)

run: $(NES)
	$(EMU) $(NES)

clean:
	rm -f $(OBJ) $(NES) $(DBG)

.PHONY: all clean run

