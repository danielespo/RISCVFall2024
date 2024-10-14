// Immediate Input Generator
// Check the datawidth for this

`timescale 1ns/1ps

module imm_gen (inst, imm_o);

input [31:0] inst;
output reg [31:0] imm_o;

always @(*)
begin
	case (inst[6:0])
		7'b001_0011:										// I-type Instructions
			begin
				case (inst[14:12])
					3'b001: imm_o <= $signed(inst[24:20]);
					3'b101: imm_o <= $signed(inst[24:20]);
					default: imm_o <= $signed(inst[31:20]);
				endcase
			end
		7'b000_0011:	imm_o <= inst[31:20];							// Load Instructions
		7'b010_0011:	imm_o <= {{20{inst[31]}}, inst[31:25], inst[11:7]};			// Store Instructions
		7'b110_0011:	imm_o <= {{20{inst[31]}}, inst[31:25], inst[11:7]};  	 		// B-Type Instructions
		7'b011_0111:	imm_o <= {inst[31:12], 12'h000};						// U-Type Instructions
		7'b110_1111:	imm_o <= {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0}; 	// J-Type Instructions
		default:	imm_o <= 32'h0000_0000;
	endcase
end

endmodule
