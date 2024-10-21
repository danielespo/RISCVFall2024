# RISCVFall2024
RISC V Processor RTL code and Cadence Files

We implemented 13 instructions:

ADD Adds x1 and x2, stores result in x3.
SUB Subtracts x4 from x3, stores result in x5.
XOR Performs bitwise XOR between x1 and x2, stores result in x3.
OR Performs bitwise OR between x1 and x2, stores result in x3.
AND Performs bitwise AND between x1 and x2, stores result in x3.
SLL Shifts x1 left by the number of bits specified in x2, stores result in x3.
SRL Shifts x1 right logically by x2, stores result in x3.
SRA Shifts x1 right arithmetically (sign-extended) by x2, stores result in x3.
SLT Sets x3 to 1 if x1 is less than x2, otherwise sets it to 0.
SLTU Sets x3 to 1 if x1 is less than x2 in an unsigned comparison, otherwise sets it to 0.
LW x6 + 0 into x7. Loads the value from memory address 
SW Stores value into memory address Here: Store x5 at x6 + 0.
JALR Calculates a target address. PC = rs1 + imm. 
Here: 
PC <- x6 + imm (e.g., 0x10).
x8 <- pc_p4 


