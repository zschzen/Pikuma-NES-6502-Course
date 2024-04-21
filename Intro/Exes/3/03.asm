.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
    CLD
Solution:                  ; TODO:
    LDA #15                ; Load the A register with the literal decimal value 15
    TAX                    ; Transfer the value from A to X
    TAY                    ; Transfer the value from A to Y
    LDX #$AA
    TXA                    ; Transfer the value from X to A
    LDY #$BB
    TYA                    ; Transfer the value from Y to A

    LDX #6                 ; Load X with the decimal value 6
    TXA                    ; Transfer the value from X to Y
    TAY

NMI:
    RTI
IRQ:
    RTI

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler
