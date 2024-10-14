// 2:1 MUX with two 32bit inputs (x0, x1) and a 32bit output (y), with a binary selection signal (y=x0 if sel=0, y=x1 if sel=1)

`timescale 1ns/1ps

module mux2 (x0, x1, sel, y);

input [31:0] x0;
input [31:0] x1;
input sel;
output [31:0] y;

assign y = (sel==1'b0) ? x0 : x1;

endmodule
