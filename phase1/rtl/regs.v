module regs(
	input wire clk,
	input wire rst,
	//from id
	input wire[4:0] reg1_raddr_i,
	input wire[4:0] reg2_raddr_i,
	
	//to id
	output reg[31:0] reg1_rdata_o,
	output reg[31:0] reg2_rdata_o,
	
	//from ex
	input wire[4:0] reg_waddr_i,
	input wire[31:0]reg_wdata_i,
	input 			reg_wen

);
    reg[31:0] regs[0:31];
    integer i;

    // 读端口1：组合逻辑，用阻塞赋值 =
    always @(*) begin
        if(rst == 1'b0)
            reg1_rdata_o = 32'b0;
        else if(reg1_raddr_i == 5'b0)
            reg1_rdata_o = 32'b0;
        else if(reg_wen && reg1_raddr_i == reg_waddr_i)
            reg1_rdata_o = reg_wdata_i;
        else
            reg1_rdata_o = regs[reg1_raddr_i];
    end

    // 读端口2：组合逻辑，用阻塞赋值 =
    always @(*) begin
        if(rst == 1'b0)
            reg2_rdata_o = 32'b0;
        else if(reg2_raddr_i == 5'b0)
            reg2_rdata_o = 32'b0;
        else if(reg_wen && reg2_raddr_i == reg_waddr_i)
            reg2_rdata_o = reg_wdata_i;            
        else
            reg2_rdata_o = regs[reg2_raddr_i];
    end

    // 写端口
    always @(posedge clk ) begin
        if (rst == 1'b0) begin
            // 修复：初始化全部32个寄存器 0~31
            for (i=0 ;i<=31 ;i=i+1 ) begin
                regs[i] <= 32'b0;
            end
        end
        // x0 恒为0，禁止写入
        else if(reg_wen && reg_waddr_i != 5'b0) begin
            regs[reg_waddr_i] <= reg_wdata_i;
        end           
    end

endmodule