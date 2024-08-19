.segment "HEADER"
.org $7FF0
.byte $4E,$45,$53,$1A,$02,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00

.segment "CODE"
.org $8000

RESET:
    SEI
Solution:
    LDA #!            ; Load the A register with the decimal value 1
    LDX #1            ; Load the X register with the decimal value 2
    LDY #1            ; Load the Y register with the decimal value 3

    INX               ; Increment X
    INY               ; Increment Y
    CLC               ; Increment A
    ADC #1

    DEX               ; Decrement X
    DEY               ; Decrement Y
    SEC               ; Decrement A
    SBC #1

    ; 6502 can only directly increment and decrement X and Y, making them a good fit to control loops and act as counter variables
    ; For A register, we need to make usage of 'CLC+ADC #1' and 'SEC+SBC #1'

NMI:
    RTI
IRQ:
    RTI

.segment "VECTORS"
.org $FFFA
.word NMI                    ; Address (2 bytes) of the NMI handler
.word RESET                  ; Address (2 bytes) of the Reset handler
.word IRQ                    ; Address (2 bytes) of the IRQ handler

