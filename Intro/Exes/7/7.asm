.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
Solution:
    CLD
    LDA #10                   ; Load the A register with the decimal value 10
    STA #$80                  ; Store the value from A into memory position $80

    INC $80                   ; Increment the value inside a (zero page) memory position $80
    DEC $80                   ; Decrement the value inside a (zero page) memory position $80

NMI:
    RTI
IRQ:
    RTI

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler


