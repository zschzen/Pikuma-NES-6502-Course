.include "consts.s"
.include "header.s"
.include "reset.s"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PRG-ROM code located at $8000
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CODE"

.proc LoadPallete
    LDY #0
:   LDA PaletteData,Y        ; Lookup byte in ROM
    STA PPU_DATA             ; Set value to send to PPU_DATA
    INY                      ; Y++
    CPY #32                  ; Y == 32
    BNE :-                   ; Not equal, keep looping to the previous (-) label
    RTS                      ; ReTurn Subroutine
.endproc

.proc LoadBackground
    LDY #0
:   LDA BackgroundData,Y
    STA PPU_DATA
    INY
    CPY #255
    BNE :-
    RTS
.endproc

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Reset handler (called when the NES resets or powers on)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Reset:
  INIT_NES

Main:
    BIT PPU_STATUS           ; Read PPU_STATUS to reset the PPU_ADDR Latch
    LDX #$3F
    STX PPU_ADDR             ; Set hi-byte of PPU_ADDR to $3F
    LDX #$00
    STX PPU_ADDR             ; Set lo-byte of PPU_ADDR to $00
    JSR LoadPallete          ; Jump to SubRoutine

    ;; Load Nametable Tiles!
    BIT PPU_STATUS           ; Read PPU_STATUS to reset the PPU_ADDR latch
    LDX #$20
    STX PPU_ADDR             ; Set hi-byte of PPU_ADDR to $20
    LDX #$00
    STX PPU_ADDR             ; Set lo-byte of PPU_ADDR to $00
    JSR LoadBackground       ; Jump to subroutine LoadBackground

EnablePPURendering:
    LDA #%10010000           ; Enable NMI and set background to use the 2nd pattern table (at $1000)
    STA PPU_CTRL
    LDA #%00011110
    STA PPU_MASK             ; Set PPU_MASK bits to render the background

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
;; List of color values
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
PaletteData:
.byte $0F,$2A,$0C,$3A, $0F,$2A,$0C,$3A, $0F,$2A,$0C,$3A, $0F,$2A,$0C,$3A ; Background
.byte $0F,$10,$00,$26, $0F,$10,$00,$26, $0F,$10,$00,$26, $0F,$10,$00,$26 ; Sprites

BackgroundData:
.byte $24,$24,$24,$24,$24,$24,$24,$24,$24,$36,$37,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24
.byte $24,$24,$24,$24,$24,$24,$24,$24,$35,$25,$25,$38,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$60,$61,$62,$63,$24,$24,$24,$24
.byte $24,$36,$37,$24,$24,$24,$24,$24,$39,$3a,$3b,$3c,$24,$24,$24,$24,$53,$54,$24,$24,$24,$24,$24,$24,$64,$65,$66,$67,$24,$24,$24,$24
.byte $35,$25,$25,$38,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$24,$55,$56,$24,$24,$24,$24,$24,$24,$68,$69,$26,$6a,$24,$24,$24,$24
.byte $45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45,$45
.byte $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47
.byte $47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47,$47
.byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CHR-ROM Data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "CHARS"
.incbin "mario.chr"
