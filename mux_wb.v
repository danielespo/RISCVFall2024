// A 3:1 MUX for Write-Back (0: Memory, 1: ALU, 2: PC+4)

`timescale 1ns/1ps

module mux_wb (mem, alu, pc_p4, sel_wb, wb_data);

input [31:0] mem;
input [31:0] alu;
input [31:0] pc_p4;
input [1:0] sel_wb;
output reg [31:0] wb_data;

always @(*)
begin
	case (sel_wb)
		2'b00:	wb_data <= mem;
		2'b01:	wb_data <= alu;
		2'b10: 	wb_data <= pc_p4;
		2'b11:	wb_data <= pc_p4;
	endcase
end

endmodule
