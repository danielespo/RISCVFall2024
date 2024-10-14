// Program Counter - Stores/Outputs a 32-bit Program Count (B) @ positive clk edge

`timescale 1ns/1ps

module pc_cnt (clk, rst, a, b);

input clk;
input rst;
input [31:0] a;
output reg [31:0] b;

always @(posedge clk)
begin
	if (rst)
		b <= 32'h00000000;
	else
		b <= a;
end

endmodule

