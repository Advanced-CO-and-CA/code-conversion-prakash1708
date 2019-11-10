/******************************************************************************
* file: assignment5_p2.s
* author: Prakash Tiwari
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

@ BSS section
      .bss

@ DATA SECTION
  
@Input
.data
@Input

.align 1
test_string1: .asciz  "11010010"
.align 1
test_string2: .asciz  "11010710"
.align 1
testA: .word test_string1
.align 1
testB: .word test_string2


@Output
NUMBER: .word  0
ERROR : .word -1

@ TEXT section
      .text

.globl _main

/******************************************************************************
* Scan through digits from MSB to LSB, check if either ascii 0 or 1 and is of 8 maximum 8 digits
* If any digit is not 0 or 1, flag it as wrong number and save the output (NUMBER = 0, ERROR = -1)
* If there are less or more than 8 digits, flag it as worng number and save the output (NUMBER = 0, ERROR = -1)
* If no error: save the number and set ERROR as 0.
******************************************************************************/
main:

        mov     r4, #0
        @save starting address of test string in r8
        ldr     r8, =testA

.SCAN_DIGITS:
        @check if all 8 digits are read
        mov     r3, r4
        cmp     r3, #7
        bgt     .RESULT_OUTPUT
        mov     r3, r4
        ldr     r2, [r8]
        add     r3, r2, r3
        @check if NULL character found
        ldrb    r3, [r3]
        cmp     r3, #0
        beq     .RESULT_OUTPUT
        @check if current digit is either 0 or 1
        mov     r3,r4
        ldr     r2, [r8]
        add     r3, r2, r3
        ldrb    r3, [r3]
        cmp     r3, #48
        beq     .UPDATE_NUM
        mov     r3,r4
        ldr     r2, [r8]
        add     r3, r2, r3
        ldrb    r3, [r3]
        cmp     r3, #49
        bne     .WRONG_INPUT

.UPDATE_NUM:
        @subtract 48 from the digit to get the bit value 0 or 1
        mov     r3,r4
        ldr     r2, [r8]
        add     r3, r2, r3
        ldrb    r3, [r3]
        sub     r3, r3, #48
        mov     r5, r3
        mov     r3, r6
        lsl     r2, r3, #1
        mov     r3, r5
        @ OR the new bit with previous value after left shift
        orr     r3, r2, r3
        mov     r6, r3
        b       .NEXT_DIGIT

.WRONG_INPUT:
        @set wrong number flag if any digit is other than 0 or 1
        mov     r3, #1
        mov     r7, r3
        b       .RESULT_OUTPUT
.NEXT_DIGIT:
        mov     r3, r4
        add     r3, r3, #1
        mov     r4,r3
        b       .SCAN_DIGITS
.RESULT_OUTPUT:
        @check if wrong number
        mov     r3, r7
        cmp     r3, #1
        beq     .NEGATIVE_RES
        @check if number string length is less or more than 8 digits
        mov     r3, r4
        cmp     r3, #7
        ble     .NEGATIVE_RES
        mov     r3, r4
        cmp     r3, #8
        ble     .POSITIVE_RES
@wrong number with digits other than 0 or 1
.NEGATIVE_RES:
        ldr     r3,=NUMBER
        mov     r2, #0
        str     r2, [r3]
        ldr     r3, =ERROR
        mvn     r2, #0
        str     r2, [r3]
        b       .END
@output the result for correct number
.POSITIVE_RES:
        ldr     r2, =NUMBER
        mov     r3, r6
        str     r3, [r2]
        ldr     r3, =ERROR
        mov     r2, #0
        str     r2, [r3]
.END:
        swi 0x11  @ end of program
        .end