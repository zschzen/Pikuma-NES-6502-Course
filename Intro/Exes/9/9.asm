.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
Solution:
    LDA #1
Loop:
    CLC                       ; Increment A
    ADC #1
    CMP #10                   ; Compare the value in A with the decimal value 10
    BNE Loop                  ; Branch back to "Loop" if the comparison was not equals (to zero)

NMI:
    RTI
IRQ:
    RTI

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler


