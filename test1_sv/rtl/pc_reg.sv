module pc_reg(
	input  logic 		 clk			,
	input  logic 		 rst			,
	input  logic[31:0]   jump_addr_i	,
	input  logic 		 jump_en		,
	output logic[31:0]   pc_o
);

	always_ff @(posedge clk) begin
		if(rst)
			pc_o <= 32'h0000_0000; // 测试时从0地址开始执行
		else if(jump_en)
			pc_o <= jump_addr_i;
		else
			pc_o <= pc_o + 32'h4;
	end

endmodule
