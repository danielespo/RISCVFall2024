// Instruction Memory - 32bit width x 256 rows
// Edit this to add more instructions

`timescale 1ns/1ps

module imem (pc, inst);

input [31:0] pc;
output [31:0] inst;

reg [31:0] mem[255:0];
integer i;

// Initializing with a list of instructions to execute
// Sajeeb, I am getting instructions from here
// NOTE: Change this and add the instructions that are missing

// https://msyksphinz-self.github.io/riscv-isadoc/html/rvi.html#xor
// https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/notebooks/RISCV/RISCV_CARD.pdf

// Now, showcasing 20 different instructions
initial
begin
	// R Type Instructions (10)
	
	// add x3 x1 x2:	[funct7=0000000][rs2(x2) ][rs1(x1)][funct3=000][rd(x3)][opcode=0110011]
	mem[0] <= 		32'b0000000_00010_00001_000_00011_0110011;
	// sub x5 x3 x4:	[funct7=0100000][rs2(x4) ][rs1(x3)][funct3=000][rd(x5)][opcode=0110011]
	mem[1] <=		32'b0100000_00100_00011_000_00101_0110011; 
	// xor x3 x1 x2:    [funct7=0000000][rs2(x2)][rs1(x1)][funct3=100][rd(x3)][opcode=0110011]
	mem[2] <=		32'b0000000_00010_00001_100_00011_0110011;
	// or x3 x1 x2:		[funct7=0000000][rs2(x2)][rs1(x1)][funct3=110][rd(x3)][opcode=0110011]
	mem[3] <=		32'b0000000_00010_00001_110_00011_0110011;
	// and x3 x1 x2:	[funct7=0000000][rs2(x2)][rs1(x1)][funct3=111][rd(x3)][opcode=0110011]
	mem[4] <=		32'b0000000_00010_00001_111_00011_0110011;
	// sll x3 x1 x2:	[funct7=0000000][rs2(x2)][rs1(x1)][funct3=001][rd(x3)][opcode=0110011]
	mem[5] <=		32'b0000000_00010_00001_001_00011_0110011;
	// srl x3 x1 x2:	[funct7=0000000][rs2(x2)][rs1(x1)][funct3=101][rd(x3)][opcode=0110011]
	mem[6] <=		32'b0000000_00010_00001_101_00011_0110011;
	// sra x3 x1 x2:	[funct7=0000010][rs2(x2)][rs1(x1)][funct3=101][rd(x3)][opcode=0110011] (msb-extends)
	mem[7] <=		32'b0000010_00010_00001_101_00011_0110011;
	// slt x3 x1 x2:	[funct7=0000000][rs2(x2)][rs1(x1)][funct3=010][rd(x3)][opcode=0110011]
	mem[8] <=		32'b0000000_00010_00001_010_00011_0110011;
	// sltu x3 x1 x2:	[funct7=0000000][rs2(x2)][rs1(x1)][funct3=011][rd(x3)][opcode=0110011]
	mem[9] <=		32'b0000000_00010_00001_011_00011_0110011;

	// RV32M Multiply Extension (3)
	// mul x3 x1 x2:	[funct7=0000001][rs2(x2)][rs1(x1)][funct3=000][rd(x3)][opcode=0110011]
	mem[10] <=		32'b0000001_00010_00001_000_00011_0110011;
	// div x3 x1 x2:	[funct7=0000001][rs2(x2)][rs1(x1)][funct3=100][rd(x3)][opcode=0110011]
	mem[11] <=		32'b0000001_00010_00001_100_00011_0110011;
	// rem x3 x1 x2:	[funct7=0000001][rs2(x2)][rs1(x1)][funct3=110][rd(x3)][opcode=0110011]
	mem[12] <=		32'b0000001_00010_00001_110_00011_0110011;




	// I Type Instructions
	
	// addi x7 0(x6):		[imm(11:5)][imm(4:0)][rs1(x6)][funct3=010][rd(x7)][opcode=0000011]
	mem[13] <=		32'b0000001_00010_00001_000_00011_0110011;
	// xori
	mem[13] <=		32'b0000001_00010_00001_000_00011_0110011;


	// Is this imm(11:5)? Do not think so... rd = M[rs1+imm][0:31] right? Might be missing something
	// lw x7 0(x6):		[imm(11:5)][imm(4:0)][rs1(x6)][funct3=010][rd(x7)][opcode=0000011]
	mem[14] <=		32'b0000000_00000_00110_010_00111_0000011;



	// S Type Instructions
	// sw x5 0(x6):		[imm(11:5)     ][rs2(x5) ][rs1(x6)][funct3=010][imm(4:0)][opcode=0100011]
	mem[15] <=		32'b0000000_00101_00110_010_00000_0100011;
	
	// B Type Instructions
	// beq Branch == B 1100011 0x0 if(rs1 == rs2) PC += imm
	// beq x5 0(x6) [imm(11:5)     ][rs2(x5) ][rs1(x6)][funct3=010][imm(4:0)][opcode=0100011]


	for (i=4; i<256; i=i+1)
		mem[i] = 32'h0000_0000;

	// 
end

assign inst = mem[pc[31:2]];	// Upper 30bits of PC = Row Address of IMEM - Lower 2bits: Column Byte Address

endmodule
