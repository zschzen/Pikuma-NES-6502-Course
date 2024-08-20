;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Constants for PPU registers mapped from addresses $2000 to $2007
;; These registers control various aspects of the NES Picture Processing Unit (PPU)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PPU_CTRL   = $2000           ; Configures NMI, sprite size, background pattern table, etc.
PPU_MASK   = $2001           ; Controls color emphasis, sprite visibility, background visibility, etc.
PPU_STATUS = $2002           ; Read-only, returns the status of the PPU, including v-blank and sprite overflow
OAM_ADDR   = $2003           ; Sets the address in the Object Attribute Memory (OAM) to write data to
OAM_DATA   = $2004           ; Writes data to the Object Attribute Memory (OAM) for sprite information
PPU_SCROLL = $2005           ; Controls the scroll position of the background in the PPU
PPU_ADDR   = $2006           ; Sets the VRAM address for subsequent data reads/writes to $2007
PPU_DATA   = $2007           ; Read/write data to/from VRAM (Video RAM) based on the address set in $2006

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The iNES header (contains a total of 16 bytes with the flags at $7F00)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "HEADER"
.byte $4E,$45,$53,$1A        ; 4 bytes with the characters 'N','E','S','\n'
.byte $02                    ; How many 16KB of PRG-ROM we'll use (=32KB)
.byte $01                    ; How many 8KB of CHR-ROM we'll use (=8KB)
.byte %00000000              ; Horz mirroring, no battery, mapper 0
.byte %00000000              ; mapper 0, playchoice, NES 2.0
.byte $00                    ; No PRG-RAM
.byte $00                    ; NTSC TV format
.byte $00                    ; Extra flags for TV format and PRG-RAM
.byte $00,$00,$00,$00,$00    ; Unused padding to complete 16 bytes of header

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PRG-ROM code located at $8000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reset handler (called when the NES resets or powers on)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Reset:
    SEI                      ; Disable all IRQ interrupts
    CLD                      ; Clear decimal mode (not supported by the NES)
    LDX #$FF
    TXS                      ; Initialize the stack pointer at address $FF

    INX                      ; Increment X, causing a rolloff from $FF to $00
    STX PPU_CTRL             ; disable NMI
    STX PPU_MASK             ; disable rendering
    STX $4010                ; disable DMC IRQs

    LDA #$40
    STA $4017                ; Disable APU frame IRQ

Wait1stVBlank:               ; Wait for the first VBlank from the PPU
    BIT PPU_STATUS           ; Perform a bit-wise check with the PPU_STATUS port
    BPL Wait1stVBlank        ; Loop until bit-7 (sign bit) is 1 (inside VBlank)

    TXA                      ; A = 0

ClearRAM:
    STA $0000,x              ; Zero RAM addresses from $0000 to $00FF
    STA $0100,x              ; Zero RAM addresses from $0100 to $01FF
    STA $0200,x              ; Zero RAM addresses from $0200 to $02FF
    STA $0300,x              ; Zero RAM addresses from $0300 to $03FF
    STA $0400,x              ; Zero RAM addresses from $0400 to $04FF
    STA $0500,x              ; Zero RAM addresses from $0500 to $05FF
    STA $0600,x              ; Zero RAM addresses from $0600 to $06FF
    STA $0700,x              ; Zero RAM addresses from $0700 to $07FF
    INX
    BNE ClearRAM

Wait2ndVBlank:               ; Wait for the second VBlank from the PPU
    BIT PPU_STATUS           ; Perform a bit-wise check with the PPU_STATUS port
    BPL Wait2ndVBlank        ; Loop until bit-7 (sign bit) is 1 (inside VBlank)

Main:
    LDX #$3F
    STX PPU_ADDR             ; Set hi-byte of PPU_ADDR to $3F
    LDX #$00
    STX PPU_ADDR             ; Set lo-byte of PPU_ADDR to $00

    LDA #$04
    STA PPU_DATA             ; Send $04 to PPU_DATA

    LDA #%00011110
    STA PPU_MASK             ; Set PPU_MASK bits to show background and sprites

LoopForever:
    JMP LoopForever

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NMI interrupt handler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
NMI:
    RTI                      ; Return from interrupt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; IRQ interrupt handler
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IRQ:
    RTI                      ; Return from interrupt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Vectors with the addresses of the handlers that we always add at $FFFA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "VECTORS"
.word NMI                    ; Address (2 bytes) of the NMI handler
.word Reset                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler

