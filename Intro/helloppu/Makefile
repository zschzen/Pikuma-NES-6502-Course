# ##################################################
# Assembler and linker
# ##################################################
AS = ca65
LD = ld65

# ##################################################
# Project name
# ##################################################
NAME = helloppu

# ##################################################
# Source and output files
# ##################################################
SRC_EXT = .asm .s         # Assembly source file ext
SRC     = $(wildcard $(addprefix $(NAME),$(SRC_EXT)))
OBJ     = $(NAME).o       # Compiled object file
NES     = $(NAME).nes     # Final NES ROM file
DBG     = $(NAME).fdb     # Debug information file

# ##################################################
# Configuration file for NES linker
# ##################################################
CFG = ../../nes.cfg

# ##################################################
# Emulator for testing the NES ROM
# ##################################################
EMU = fceux

# ##################################################
# Build rules
# ##################################################

# Default target to build the NES ROM
all: $(NES)

# Compile the assembly source file into an object file
$(OBJ): $(SRC)
	$(AS) -g -o $(OBJ) $(SRC)

# Link the object file to create the NES ROM and debug file
$(NES): $(OBJ)
	$(LD) $(OBJ) -C $(CFG) -o $(NES) --dbgfile $(DBG)

# Run the ROM in the emulator
run: $(NES)
	$(EMU) $(NES)

# Clean up generated files
clean:
	rm -f $(OBJ) $(NES) $(DBG)

# ##################################################
# Phony targets (not real files)
# ##################################################
.PHONY: all clean run

