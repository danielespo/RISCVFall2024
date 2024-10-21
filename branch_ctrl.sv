// Branch Control

module branch_ctrl (opcode, br_type, rs1_data, rs2_data, br_en);

input [6:0] opcode;
input [2:0] br_type;
input [31:0] rs1_data;
input [31:0] rs2_data;
output br_en;

reg branch;
reg jump;

// Jump (basically checks then asserts)
always @(*)
begin
	if (opcode == 7'b110_1111)
		jump <= 1'b1;
	else
		jump <= 1'b0;
end

// Branch
always @(*)
begin
	if (opcode == 7'b110_0011)
	begin
		case (br_type)
			3'b000:	// beq (Branch if equal)
			begin
				if (rs1_data == rs2_data)
					branch <= 1'b1;
				else
					branch <= 1'b0;
			end
			3'b001: // bne (Branch if not equal)
                        begin
                                if (rs1_data != rs2_data)
                                        branch <= 1'b1;
                                else
                                        branch <= 1'b0;
                        end
			3'b100: // blt (Branch if less than - Signed)
                        begin
                                if ($signed(rs1_data) < $signed(rs2_data))
                                        branch <= 1'b1;
                                else
                                        branch <= 1'b0;
                        end
			3'b101: // bge (Branch if greater than or equal - Signed)
                        begin
                                if ($signed(rs1_data) >= $signed(rs2_data))
                                        branch <= 1'b1;
                                else
                                        branch <= 1'b0;
                        end
			3'b110:	// bltu (Branch if less than - Unsigned)
			begin
				if (rs1_data < rs2_data)
                                        branch <= 1'b1;
                                else
                                        branch <= 1'b0;
			end
			3'b111: // bgeu (Branch if greater than or equal - Unsigned)
                        begin
                                if (rs1_data >= rs2_data)
                                        branch <= 1'b1;
                                else
                                        branch <= 1'b0;
                        end
		endcase
	end
	else
		branch <= 1'b0;
end

assign br_en = (branch | jump);

endmodule
