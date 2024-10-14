// ALU Control Signal Generator

module alu_ctrl (opcode, funct7, funct3, alu_op);

input [6:0] opcode;
input [6:0] funct7;
input [2:0] funct3;
output reg [3:0] alu_op;

always @(*)
begin

case (opcode)	
7'b011_0011:	// R-Type Instructions
	begin
		case (funct3)
		3'b000:
			begin
				if (funct7==7'b010_0000)
					alu_op <= 4'b1001;	// 9. SUB (-)
				else
					alu_op <= 4'b0000;	// 0. ADD (+)
			end	
		3'b001:	alu_op <= 4'b0001;			// 1. Shift-Left-Logical (<<)
		3'b010:	alu_op <= 4'b0010;			// 2. Set-Less-Than-Signed (<)
		3'b011:	alu_op <= 4'b0011;			// 3. Set-Less-Than-Unsigned (<)
		3'b100:	alu_op <= 4'b0100;			// 4. Bitwise XOR (^)
		3'b101:
			begin
				if (funct7==7'b010_0000)
					alu_op <= 4'b0110;	// 6. Shift-Right-Arithmetic (>>>)
				else
					alu_op <= 4'b0101;	// 5. Shift-Right-Logical (>>)
			end
		3'b110:	alu_op <= 4'b0111;			// 7. Bitwise OR (|)
		3'b111:	alu_op <= 4'b1000;			// 8. Bitwise AND (&)
		endcase
	end
7'b001_0011:	// I-Type Instructions
        begin
                case (funct3)
                3'b000: alu_op <= 4'b0000;			// 0. ADD (+)
                3'b001: alu_op <= 4'b0001;                      // 1. Shift-Left-Logical (<<)
                3'b010: alu_op <= 4'b0010;                      // 2. Set-Less-Than-Signed (<)
                3'b011: alu_op <= 4'b0011;                      // 3. Set-Less-Than-Unsigned (<)
                3'b100: alu_op <= 4'b0100;                      // 4. Bitwise XOR (^)
                3'b101:
                        begin
                                if (funct7==7'b010_0000)
                                        alu_op <= 4'b0110;      // 6. Shift-Right-Arithmetic (>>>)
                                else
                                        alu_op <= 4'b0101;      // 5. Shift-Right-Logical (>>)
                        end
                3'b110: alu_op <= 4'b0111;                      // 7. Bitwise OR (|)
                3'b111: alu_op <= 4'b1000;                      // 8. Bitwise AND (&)
                endcase
        end
7'b000_0011:    // Load Instructions
        begin
                alu_op <= 4'b0000;                      // 0. ADD (+)
        end
7'b010_0011:    // Store Instructions
        begin
                alu_op <= 4'b0000;                      // 0. ADD (+)
        end
7'b110_0011:    // B-Type Instructions
        begin
                alu_op <= 4'b0000;                      // 0. ADD (+)
        end
7'b011_0111:    // U-Type Instructions
        begin
                alu_op <= 4'b0000;                      // 0. ADD (+)
        end
7'b110_1111:    // J-Type Instructions
        begin
                alu_op <= 4'b0000;                      // 0. ADD (+)
        end
default:	// Default
	begin
                alu_op <= 4'b0000;                      // 0. ADD (+)
        end
endcase

end

endmodule
