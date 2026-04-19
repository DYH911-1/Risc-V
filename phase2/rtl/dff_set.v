// 参数化D触发器：位宽可以改，默认32位
module dff_set #(
	parameter DW  = 32  // 参数：数据位宽，默认32位
)
(
	input wire clk,                // 时钟
	input wire rst,                // 低电平复位
	input wire hold_flag_i,		   //	
	input wire [DW-1:0] set_data,  // 复位时输出的值（空指令/0）
	input wire [DW-1:0] data_i,     // 要寄存的输入数据
	output reg [DW-1:0] data_o	   // 输出：锁存后的数据
);
	always @(posedge clk)begin      // 时钟上升沿触发
		if(rst == 1'b0 || hold_flag_i == 1'b1)// 复位有效：输出设定值
			data_o <= set_data;
		else                       // 正常工作：锁存输入数据
			data_o <= data_i;
	end	
endmodule