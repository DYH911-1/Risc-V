module regs(
	input logic clk,
	input logic rst,
	//from id
	input logic[4:0] reg1_raddr_i,
	input logic[4:0] reg2_raddr_i,
	
	//to id
	output reg[31:0] reg1_rdata_o,
	output reg[31:0] reg2_rdata_o,
	
	//from ex
	input logic[4:0] reg_waddr_i,
	input logic[31:0]reg_wdata_i,
	input 			reg_wen

);
	reg[31:0] regs[0:31];
	integer i;
// ===================== 读端口1：组合逻辑读+读写冲突旁路 =====================
	always_comb begin
		if(rst)
			reg1_rdata_o = 32'b0;
		else if(reg1_raddr_i == 5'b0)
			reg1_rdata_o = 32'b0;
		else if(reg_wen && reg1_raddr_i == reg_waddr_i)
			reg1_rdata_o = reg_wdata_i;
		else
			reg1_rdata_o = regs[reg1_raddr_i];
	end
// ===================== 读端口2：组合逻辑读+读写冲突旁路 =====================	
	always_comb begin
		if(rst)
			reg2_rdata_o = 32'b0;
		else if(reg2_raddr_i == 5'b0)
			reg2_rdata_o = 32'b0;
		else if(reg_wen && reg2_raddr_i == reg_waddr_i)
			reg2_rdata_o = reg_wdata_i;
		else
			reg2_rdata_o = regs[reg2_raddr_i];
	end
	//写寄存器，时序，复位时寄存器清零，写寄存器地址不为0，写使能有效
	always_ff @(posedge clk)begin
		if(rst) begin
			for(i=0;i<32;i=i+1)begin
				regs[i] <= 32'b0;
			end
		end	
		else if(reg_wen && reg_waddr_i != 5'b0)begin
			regs[reg_waddr_i] <= reg_wdata_i;
		end	
	end

endmodule