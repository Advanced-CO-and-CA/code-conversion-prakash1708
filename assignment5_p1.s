/******************************************************************************
* file: assignment5_p1.s
* author: Prakash Tiwari
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

@ BSS section
      .bss

@ DATA SECTION
  
@Input
.data

A_DIGIT:  .word   67

@Output
H_DIGIT: .word 0

@ TEXT section
      .text


/******************************************************************************
* check if A_DIGIT is between ascii 0 to 9 (48 to 57) and subtract 48 to get the H_DIGIT from 0 to 9
* check if A_DIGIT is between ascii A to F (65 to 70) and subtract 55 to get the H_DIGIT from A to F
* check if A_DIGIT is between ascii a to f (96 to 102) and subtract 87 to get the H_DIGIT from A to F
******************************************************************************/

.globl _main
main:
        ldr     r3, =A_DIGIT
        ldrb    r3, [r3]

        @ if A_DIGIT is > 9
        cmp     r3, #57
        bgt     check_capA2F
        ldr     r3, =A_DIGIT
        ldrb    r3, [r3]
        @ if A_DIGIT is < 0
        cmp     r3, #47
        ble     check_capA2F
        ldr     r3, = A_DIGIT
        ldrb    r3, [r3]
        @get the H_DIGIT between 0 to 9
        sub     r3, r3, #48
        ldr     r2, =H_DIGIT
        str     r3, [r2]
        b       END

check_capA2F:
        ldr     r3, =A_DIGIT
        ldrb    r3, [r3]
        @ if A_DIGIT is > F
        cmp     r3, #70
        bgt     check_smallA2F
        ldr     r3, =A_DIGIT
        ldrb    r3, [r3]
        @ if A_DIGIT is < A
        cmp     r3, #64
        ble     check_smallA2F
        ldr     r3, =A_DIGIT
        ldrb    r3, [r3]
        @get the H_DIGIT between A to F
        sub     r3, r3, #55
        ldr     r2, =H_DIGIT
        str     r3, [r2]
        b       END

check_smallA2F:
        ldr     r3, =A_DIGIT
        ldrb    r3, [r3]
        @ if A_DIGIT is > f
        cmp     r3, #102
        bgt     END
        ldr     r3, =A_DIGIT
        ldrb    r3, [r3]
        @ if A_DIGIT is < a
        cmp     r3, #96
        ble     END
        ldr     r3, =A_DIGIT
        ldrb    r3, [r3]
        @get the H_DIGIT between a to f
        sub     r3, r3, #87
        ldr     r2, =H_DIGIT
        str     r3, [r2]

END:
        swi 0x11
        .end