// Register File - 32bit width x 32 rows - 1st register (x0) is fixed to 32'h0000_0000
// Read - combinational
// Write - sequential @ negative clk edge

`timescale 1ns/1ps

module reg_file (clk, rst, reg_wr, rs1_addr, rs2_addr, wr_addr, wr_data, rs1_data, rs2_data);

input clk;
input rst;
input reg_wr;
input [4:0] rs1_addr;		// rs1 - register source #1 for READ - inst[19:15]
input [4:0] rs2_addr;		// rs2 - register source #2 for READ - inst[24:20]
input [4:0] wr_addr;		// rd - register destination for WRITE - inst[11:7]
input [31:0] wr_data;		// data for WRITE (write-back operation) from DMEM (e.g.lw) or ALU (e.g.add)
output [31:0] rs1_data;
output [31:0] rs2_data;

reg [31:0] register[31:0];
integer i;

// Initialize registers: Synchronous reset
always @(posedge clk)
begin
	if (rst)
	begin
		register[0] <= 32'h0000_0000;
		register[1] <= 32'h0000_1000;	// 8
		register[2] <= 32'h0000_0111;	// 7
		register[3] <= 32'h0000_0000;
		register[4] <= 32'h0000_0100;	// 4
		register[5] <= 32'h0000_0000;
		register[6] <= 32'h0000_0000;	// 0
		register[7] <= 32'h0000_0000;
		for (i=8; i<32; i=i+1)
			register[i] <= 32'h0000_0000;
	end
end

// Combinational read
assign	rs1_data = register[rs1_addr];
assign	rs2_data = register[rs2_addr];

// Sequential write @ negative clk edge
always @(negedge clk)
begin
	if(reg_wr & (wr_addr!=5'b00000))	// if register write-back is enabled from main_ctrl & the write address is not 0
		register[wr_addr] <= wr_data;
end

endmodule
