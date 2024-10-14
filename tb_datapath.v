// RISC-V Single Cycle 32bit Processor
// Test bench for Program Count, Instruction Fetch, Instruction Decode, Execution, and Memory
// A full datapath, except for Immediate & Branch operations
// Clock frequency: 100MHz

`timescale 1ns/1ps

module tb_pc ();

// Clock and Reset signals (Test bench generated)
reg clk;
reg rst;

// Control signals (from Main/ALU/Branch Controls)
wire br_en;
wire reg_wr;
wire [2:0] br_type;
wire sel_a;
wire sel_b;
wire [3:0] alu_op;
wire mem_wr;
wire mem_rd;
wire [2:0] mask;
wire [1:0] sel_wb;

// Datapath wires
// Program Counter
wire [31:0] pc_o;	// program count
wire [31:0] pc_p4;	// program count + 4 (add4 output)
wire [31:0] pc_i;	// program count (next)
// Instruction Memory
wire [31:0] inst;	// read instruction from imem
// Register File
wire [31:0] rs1_data;	// read source register 1 from reg_file
wire [31:0] rs2_data;	// read source register 2 from reg_file
// Immediate Generator
wire [31:0] imm_o;	// immediate input generator output
// ALU
wire [31:0] alu_a;	// 'A' input for the ALU
wire [31:0] alu_b;	// 'B' input for the ALU
wire [31:0] alu_o;
// Data Memory
wire [31:0] dmem_o;
wire [31:0] wb_data;

initial
begin
	clk = 1'b0;
	rst = 1'b1;
	#5	clk = 1'b1;
	#5	clk = 1'b0;
		rst = 1'b0;
	#5	clk = 1'b1;
	#5	clk = 1'b0;
	#5	clk = 1'b1;
	#5	clk = 1'b0;
	#5	clk = 1'b1;
	#5	clk = 1'b0;
	#5	clk = 1'b1;
	#5	clk = 1'b0;
	#5	clk = 1'b1;
	#5	clk = 1'b0;
end

// Program Counter & Adder (Add 4)
mux2 i_mux2_pc(.x0(pc_p4), .x1(alu_o), .sel(br_en), .y(pc_i));
pc_cnt i_pc_cnt(.clk(clk), .rst(rst), .a(pc_i), .b(pc_o));
add4 i_add4(.a(pc_o), .b(pc_p4));

// Input Memory
imem i_imem(.pc(pc_o), .inst(inst));

// Register File
reg_file i_reg_file(.clk(clk), .rst(rst), .reg_wr(reg_wr), .rs1_addr(inst[19:15]), .rs2_addr(inst[24:20]), .wr_addr(inst[11:7]), .wr_data(wb_data), .rs1_data(rs1_data), .rs2_data(rs2_data));

// MUX for ALU A input
mux2 i_mux2_a(.x0(rs1_data), .x1(pc_o), .sel(sel_a), .y(alu_a));
// Immediate Generator & MUX for ALU B input
imm_gen i_imm_gen(.inst(inst), .imm_o(imm_o));
mux2 i_mux2_b(.x0(rs2_data), .x1(imm_o), .sel(sel_b), .y(alu_b));
// ALU for Execution
alu i_alu(.a(alu_a), .b(alu_b), .alu_op(alu_op), .y(alu_o));

// Data Memory
dmem i_dmem(.clk(clk), .addr(alu_o), .wr_data(rs2_data), .mem_wr(mem_wr), .mem_rd(mem_rd), .mask(mask), .rd_data(dmem_o));
// MUX for Write-Back to Register
mux_wb i_mux_wb(.mem(dmem_o), .alu(alu_o), .pc_p4(pc_p4), .sel_wb(sel_wb), .wb_data(wb_data));

// Control Blocks
alu_ctrl i_alu_ctrl(.opcode(inst[6:0]), .funct7(inst[31:25]), .funct3(inst[14:12]), .alu_op(alu_op));
main_ctrl i_main_ctrl(.opcode(inst[6:0]), .funct3(inst[14:12]), .reg_wr(reg_wr), .br_type(br_type), .sel_a(sel_a), .sel_b(sel_b), .mem_wr(mem_wr), .mem_rd(mem_rd), .mask(mask), .sel_wb(sel_wb));
branch_ctrl i_branch_ctrl(.opcode(inst[6:0]), .br_type(br_type), .rs1_data(rs1_data), .rs2_data(rs2_data), .br_en(br_en));

endmodule
