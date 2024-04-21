.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
    CLD
Solution:                   ; TODO:
    LDA #$A                 ; Load the A register with the hexadecimal value $A
    LDX %11111111           ; Load the X register with the binary value %11111111
    STA $80                 ; Store the value in the A register into memory address $80
    STX $81                 ; Store the value in the X register into memory address $81

NMI:
    RTI
IRQ:
    RTI

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler

