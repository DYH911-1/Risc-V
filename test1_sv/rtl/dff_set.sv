module dff_set #(
	parameter DW  = 32
)
(
	input wire clk,
	input wire rst,
	input wire hold_flag_i,
	input wire [DW-1:0]  set_data, 
	input wire [DW-1:0]  data_i, 
	output reg [DW-1:0]  data_o	
);
	always @(posedge clk)begin
		if(rst || hold_flag_i == 1'b1)//rst高电平有效，hold_flag_i高电平有效
			data_o <= set_data;
		else
			data_o <= data_i;
	end	

endmodule