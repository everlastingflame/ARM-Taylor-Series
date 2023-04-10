//use lab 10 and 9 for reference
//snippet one

.text
.global _start

_start:
ADR x0, x
LDUR d0, [x0]
FMOV d1, d0

ADR x0, precision  //j
LDUR x1, [x0]

FMOV d3, #1.0  //sum holder
FSUB d3, d3, d3
FMOV d4, #1.0  //1 holder 
fmov d9, d1     //x multiplier
MOV x2, #1     //int i = 1
MOV x3, #1     //factorial holder f
MOV x4, #1     //j 
MOV x5, #1     //k


taylor: 
CMP x2, x1        //for loop (if int i > precision (d2) exit out)
bgt printer
bl factorial      //function call factorial
SCVTF d5, x3      //convert factorial calculation to decimal
fdiv d6, d1, d5   //(p/factorial(j))
fadd d3, d3, d6   //sum up the calculations
add x2, x2, #1
mov x3, #1 
mov x5, #1
fmul d1, d1, d9
b taylor


factorial:
subs xzr, x2, x5     //checking if k is greater than f
blt factorial_exit         //return to taylor function if true
MUL x3, x3, x5 //f * k
ADD x5, x5, #1 // k++
b factorial
factorial_exit:
BR LR


printer:
FADD d3, d3, d4
ADR X0, fmt_str
FMOV D0, d3
bl printf


Exit:
mov x0, #0
mov W8, #93
SVC #0

.data
fmt_str: 
.ascii "The approximation is: %lf\n\0"

x:
.double 1 //x variable

precision:
.dword 4  //precision

.bss
result: .skip 8

.end