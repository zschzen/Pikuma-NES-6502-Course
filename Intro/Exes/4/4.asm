.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
Solution:
    CLD                     ; Disable BCD decimal mode
    LDA #100                ; Load the A register with the literal decimal value 100

    CLC                     ; Must always clear carry flag before addition
    ADC #5                  ; Add the decimal value 5 to the accumulator

    SEC                     ; Must always set carry flag before subtraction
    SBC #10                 ; Subtract the decimal value 10 from the accumulator
                            ; Register A should now contain the decimal 95 (or $5F in hexadecimal)

NMI:
    RTI
IRQ:
    RTI

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler

