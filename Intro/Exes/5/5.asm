.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
    CLD
Solution:
    LDA #$A                 ; Load the A register with the hexadecimal value $A
    LDX #%1010              ; Load the X register with the binary value %1010

    STA #80                 ; Store the value in the A register into (zero page) memory address $80
    STX #81                 ; Store the value in the X register into (zero page) memory address $81

    LDA #10                 ; Load A with the decimal value 10
    CLC
    ADC #80                 ; Add to A the value inside RAM address $80
    ADC #81                 ; Add to A the value inside RAM address $81
                            ; A should contain (#10 + $A + %1010) = #30 (or $1E in hexadecimal)

    STA #82                 ; Store the value of A into RAM position $82

NMI:
    RTI
IRQ:
    RTI

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler
