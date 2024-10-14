// Instruction Memory - 32bit width x 256 rows

`timescale 1ns/1ps

module imem (pc, inst);

input [31:0] pc;
output [31:0] inst;

reg [31:0] mem[255:0];
integer i;

// Initializing with a list of instructions to execute
// NOTE: Change this and add the instructions that are missing
initial
begin
	// add x3 x1 x2:	[funct7=0000000][rs2(x2) ][rs1(x1)][funct3=000][rd(x3)  ][opcode=0110011]
	mem[0] <= 		32'b0000000_00010_00001_000_00011_0110011;
	// sub x5 x3 x4:	[funct7=0100000][rs2(x4) ][rs1(x3)][funct3=000][rd(x5)  ][opcode=0110011]
	mem[1] <=		32'b0100000_00100_00011_000_00101_0110011;
	// sw x5 0(x6):		[imm(11:5)     ][rs2(x5) ][rs1(x6)][funct3=010][imm(4:0)][opcode=0100011]
	mem[2] <=		32'b0000000_00101_00110_010_00000_0100011;
	// lw x7 0(x6):		[imm(11:5)     ][imm(4:0)][rs1(x6)][funct3=010][rd(x7)  ][opcode=0000011]
	mem[3] <=		32'b0000000_00000_00110_010_00111_0000011;
	for (i=4; i<256; i=i+1)
		mem[i] = 32'h0000_0000;
end

assign inst = mem[pc[31:2]];	// Upper 30bits of PC = Row Address of IMEM - Lower 2bits: Column Byte Address

endmodule
