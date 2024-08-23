;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reset handler (called when the NES resets or powers on)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.macro INIT_NES
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
.endmacro

