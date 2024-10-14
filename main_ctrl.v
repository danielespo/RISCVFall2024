// Main Ctrl Signal Generator vs. opcode[6:0]
// 1) reg_wr - Register File Write Enable
// 2) sel_a - ALU A input selection signal (0: rs1_data, 1: pc_o)
// 3) sel_b - ALU B input selection signal (0: rs2_data, 1: imm_o)
// 4) mem_wr - Data Memory Write Enable
// 5) mem_rd - Data Memory Read Enable
// 6) sel_wb[1:0] - Writeback Selection (00: dmem_o, 01: alu_o, 1x: pc_p4)

module main_ctrl (opcode, funct3, reg_wr, br_type, sel_a, sel_b, mem_wr, mem_rd, mask, sel_wb);

input [6:0] opcode;
input [2:0] funct3;
output reg reg_wr;
output reg [2:0] br_type;
output reg sel_a;
output reg sel_b;
output reg mem_wr;
output reg mem_rd;
output reg [2:0] mask;
output reg [1:0] sel_wb;

always @(*)
begin
	case (opcode)
		7'b011_0011:	// R-type instructions
			begin
				reg_wr <= 1'b1;
				br_type <= 3'b000;
				sel_a <= 1'b0;	// rs1_data
				sel_b <= 1'b0;	// rs2_data
				mem_wr <= 1'b0;
				mem_rd <= 1'b0;
				mask <= 3'b000;
				sel_wb <= 2'b01;	// alu_o
			end
		7'b001_0011:    // I-type instructions
                        begin
                                reg_wr <= 1'b1;
				br_type <= 3'b000;
				sel_a <= 1'b0;	// rs1_data
				sel_b <= 1'b1;	// imm_o
                                mem_wr <= 1'b0;
				mem_rd <= 1'b0;
                                mask <= 3'b000;
                                sel_wb <= 2'b01;	// alu_o
                        end
		7'b000_0011:	// Load instructions
			begin
				reg_wr <= 1'b1;
                                br_type <= 3'b000;
				sel_a <= 1'b0;	// rs1_data
				sel_b <= 1'b1;	// imm_o
				mem_wr <= 1'b0;
				mem_rd <= 1'b1;
				mask <= funct3;
				sel_wb <= 2'b00;	// dmem_o
			end
		7'b010_0011:	// Store instructions
			begin
				reg_wr <= 1'b0;
                                br_type <= 3'b000;
				sel_a <= 1'b0;	// rs1_data
				sel_b <= 1'b1;	// imm_o
				mem_wr <= 1'b1;
				mem_rd <= 1'b0;
				mask <= funct3;
				sel_wb <= 2'b00;	// dmem_o
			end
		7'b110_0011:	// B-Type instructions
			begin
				reg_wr <= 1'b0;
				br_type <= funct3;
				sel_a <= 1'b1;	// pc_o
				sel_b <= 1'b1;	// imm_o
				mem_wr <= 1'b0;
				mem_rd <= 1'b0;
                                mask <= 3'b000;
				sel_wb <= 2'b01;	// alu_o
			end
		7'b011_0111:	// U-Type instructions
			begin
				reg_wr <= 1'b1;
                                br_type <= 3'b000;
				sel_a <= 1'b0;	// rs1_data
				sel_b <= 1'b1;	// imm_o
				mem_wr <= 1'b0;
				mem_rd <= 1'b0;
                                mask <= 3'b000;
				sel_wb <= 2'b01;	// alu_o
			end
		7'b110_1111:	// J-Type instructions
			begin
				reg_wr <= 1'b1;
                                br_type <= 3'b000;
				sel_a <= 1'b1;	// pc_o
				sel_b <= 1'b1;	// imm_o
				mem_wr <= 1'b0;
				mem_rd <= 1'b0;
                                mask <= 3'b000;
				sel_wb <= 2'b10;	// pc_p4
			end
		default:	// Default (after reset & if opcode is not one of the instruction's opcode
			begin
				reg_wr <= 1'b0;
                                br_type <= 3'b000;
                                sel_a <= 1'b0;  // rs1_data
                                sel_b <= 1'b0;  // rs2_data
                                mem_wr <= 1'b0;
                                mem_rd <= 1'b0;
                                mask <= 3'b000;
                                sel_wb <= 2'b01;        // alu_o
			end
	endcase
end

endmodule
