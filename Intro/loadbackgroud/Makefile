# ##################################################
# Assembler and linker
# ##################################################
AS = ca65
LD = ld65

# ##################################################
# Project name
# ##################################################
NAME = loadbackground

# ##################################################
# Build directory
# ##################################################
BUILD_DIR = build

# ##################################################
# Source and output files
# ##################################################
SRC_EXT = .asm .s         # Assembly source file ext
SRC     = $(wildcard $(addprefix $(NAME),$(SRC_EXT)))
OBJ     = $(BUILD_DIR)/$(NAME).o       # Compiled object file
NES     = $(BUILD_DIR)/$(NAME).nes     # Final NES ROM file
DBG     = $(BUILD_DIR)/$(NAME).fdb     # Debug information file

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

# Create the build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Compile the assembly source file into an object file
$(OBJ): $(BUILD_DIR) $(SRC)
	$(AS) -g -o $(OBJ) $(SRC)

# Link the object file to create the NES ROM and debug file
$(NES): $(OBJ) $(BUILD_DIR)
	$(LD) $(OBJ) -C $(CFG) -o $(NES) --dbgfile $(DBG)

# Run the ROM in the emulator
run: $(NES)
	$(EMU) $(NES)

# Clean up generated files
clean:
	rm -rf $(BUILD_DIR) $(NES)

# ##################################################
# Phony targets (not real files)
# ##################################################
.PHONY: all clean run

