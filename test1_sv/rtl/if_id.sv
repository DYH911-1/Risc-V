`include "defines.sv"

module if_id(
	input  logic clk					,
	input  logic rst					,
	input  logic hold_flag_i			,
	input  logic [31:0]  inst_i			,
	input  logic [31:0]  inst_addr_i	,
	output logic [31:0]  inst_addr_o	, 
	output logic [31:0]  inst_o
);

	dff_set #(32) dff1(clk,rst,hold_flag_i,`INST_NOP,inst_i,inst_o);
	
	dff_set #(32) dff2(clk,rst,hold_flag_i,32'b0,inst_addr_i,inst_addr_o);



endmodule

