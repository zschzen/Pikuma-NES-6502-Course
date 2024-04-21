.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
    CLD
Solution:                       ; TODO:
    LDA #$82                    ; Load the A register with the literal hexadecimal value $82
    LDX #82                     ; Load the X register with the literal decimal value 82
    LDY $82                     ; Load the Y register with the value that is inside memory position $82

NMI:
    rti
IRQ:
    rti

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler
