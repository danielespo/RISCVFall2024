// Adder - Increment Program Count by 4

`timescale 1ns/1ps

module add4 (a, b);

input [31:0] a;
output [31:0] b;

assign b = a + 32'h0000_0004;

endmodule
