.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
Solution:
    LDY #10                   ; Initialize the Y register with the decimal value 10
Loop:
    TYA                       ; Transfer Y to A
    STA $80,Y                 ; Store the value in A inside memory position $80+Y
    DEY                       ; Decrement Y
    BPL Loop                  ; Branch if plus, if the last instruction was positive

NMI:
    RTI
IRQ:
    RTI

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler

