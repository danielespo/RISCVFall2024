// ALU with two 32bit inputs (a and b), a 4bit ALU operation selection signal (alu_op), a 32bit output (y)
// 0. ADD: 			y = a + b 		if alu_op=4'b0000 (funct7[5]=0, funct3[2:0]=000)
// 1. Shift-Left-Logical:	y = a << b 		if alu_op=4'b0001 (funct7[5]=0, funct3[2:0]=001)
// 2. Set-Less-Than (Signed):	y = (a < b)?1:0		if alu_op=4'b0010 (funct7[5]=0, funct3[2:0]=010)
// 3. Set-Less-Than (Unsigned):	y = (a < b)?1:0 	if alu_op=4'b0011 (funct7[5]=0, funct3[2:0]=011)
// 4. Bitwise XOR:		y = a ^ b		if alu_op=4'b0100 (funct7[5]=0, funct3[2:0]=100)
// 5. Shift-Right-Logical:	y = a >> b(zero-extend)	if alu_op=4'b0101 (funct7[5]=0, funct3[2:0]=101)
// 6. Shift-Right-Arithmetic:	y = a >> b(sign-extend)	if alu_op=4'b0110 (funct7[5]=1, funct3[2:0]=101)
// 7. Bitwise OR:		y = a | b		if alu_op=4'b0111 (funct7[5]=1, funct3[2:0]=110)
// 8. Bitwise AND:		y = a & b		if alu_op=4'b1000 (funct7[5]=0, funct3[2:0]=111)
// 9. SUB:			y = a - b		if alu_op=4'b1001 (funct7[5]=1, funct3[2:0]=000)

`timescale 1ns/1ps

module alu (a, b, alu_op, y);

input [31:0] a;
input [31:0] b;
input [3:0] alu_op;
output reg [31:0] y;

always @(*)
begin
	case (alu_op)
		4'h0:	y = a + b;
		4'h1:	y = a << b;
		4'h2:	y = $signed(a) < $signed(b);
		4'h3:	y = a < b;
		4'h4:	y = a ^ b;
		4'h5:	y = a >> b;
		4'h6:	y = a >>> b;
		4'h7:	y = a | b;
		4'h8:	y = a & b;
		4'h9:	y = a - b;
		default: y = 32'h0000;
	endcase
end

endmodule
