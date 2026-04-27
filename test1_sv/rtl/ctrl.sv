module ctrl(
	input  logic [31:0] 	jump_addr_i		,
	input  logic    		jump_en_i		,
	input  logic   			hold_flag_ex_i	,

	output logic [31:0]		jump_addr_o		,
	output logic    		jump_en_o		,
	output logic   	 		hold_flag_o	
);

	always_comb begin
		jump_addr_o = jump_addr_i;
		jump_en_o   = jump_en_i; 
		if( jump_en_i || hold_flag_ex_i)begin 
			hold_flag_o = 1'b1;
		end
		else begin
			hold_flag_o = 1'b0;
		end
	end




endmodule