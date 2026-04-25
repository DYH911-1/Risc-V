module pc_reg(
	input wire 		 clk,
	input wire 		 rst,
	input wire[31:0] jump_addr_i,
	input wire 		 jump_en,
	output reg[31:0] pc_o
);

	always @(posedge clk) begin
		if(rst)
			pc_o <= 32'h8000_0000; // 比赛要求IROM起始地址
		else if(jump_en)
			pc_o <= jump_addr_i;
		else
			pc_o <= pc_o + 32'h4;
	end

endmodule
