/******************************************************************************
* file: assignment3_p3.s
* author: Prakash Tiwari
* Guide: Prof. Madhumutyam IITM, PACE
******************************************************************************/

@ BSS section
      .bss

@ DATA SECTION
  
@Input
.data
.align 1
BCDNUM:  .asciz "92529679"
.align 1
INPUT: .word BCDNUM
@Output
.align 1
OUTPUT : .word 0

@ TEXT section
      .text


/******************************************************************************
* BCD to Decimal conversion
* Read each digit of BCD number and multiply them with their corresponding decimal place value and keep adding them
* Display output once all digits scanned
* Limitations: BCDNUM lenght should be 8 digits to get the correct output
* If number of digits are less or greater than 8 and any digit is not between 0 to 9, OUTPUT will remain 0
******************************************************************************/

.globl _main
main:
        @Read BCDNUM and save in r8 to scan
        ldr     r3, =INPUT
        mov r8,r3
        @output number initialization
        mov r7,#0
        @digit counter initialization (number of digits should be equal to 8)
        mov r6,#0

.SCAN_DIGITS:
        mov r3,r6 
        cmp     r3, #7
        bgt     .UPDATE_RESULT
        mov r3,r6
        ldr r2,[r8]
        add     r3, r2, r3
        ldrb    r3, [r3]
        @check if NULL character found : end of BCDNUM - update result
        cmp     r3, #0
        beq     .UPDATE_RESULT

        @read current digit and check if it is between 0 to 9
        mov r3,r6
        ldr r2,[r8]
        add     r3, r2, r3
        ldrb    r3, [r3]
        cmp     r3, #47
        ble     .UPDATE_RESULT
        mov r3,r6
        ldr r2,[r8]
        add     r3, r2, r3
        ldrb    r3, [r3]
        cmp     r3, #57
        bgt     .UPDATE_RESULT

        @get the decimal value of the digit
        mov r3,r6
        ldr r2,[r8]
        add     r3, r2, r3
        ldrb    r3, [r3]
        sub     r1, r3, #48
        @read the previous output in r2
        mov r2,r7
        mov     r3, r2
        @multiply previous output by 10 
        lsl     r3, r3, #2
        add     r3, r3, r2
        lsl     r3, r3, #1
        
        @and add present decimal value for the digit
        add     r3, r1, r3
        @update output so far
        mov r7,r3 
        @ move to next digit
        mov r3,r6
        add     r3, r3, #1
        mov r6,r3
        b       .SCAN_DIGITS

.UPDATE_RESULT:
        @check if 8 digits are read and uptate OUTPUT
        mov r3,r6
        cmp     r3, #8
        bne     .END
        ldr     r2, =OUTPUT
        mov r3,r7
        str     r3, [r2]
.END:
        swi 0x11  @ end of program
        .end