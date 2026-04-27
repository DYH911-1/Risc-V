module dff_set #(
	parameter DW  = 32
)
(
	input  logic clk				,
	input  logic rst				,
	input  logic hold_flag_i		,
	input  logic [DW-1:0]  set_data	, 
	input  logic [DW-1:0]  data_i	, 
	output logic [DW-1:0]  data_o	
);
	always_ff @(posedge clk)begin
		if(rst || hold_flag_i == 1'b1)//rst高电平有效，hold_flag_i高电平有效
			data_o <= set_data;
		else
			data_o <= data_i;
	end	

endmodule