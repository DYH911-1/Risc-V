module ifetch(
	//from pc
	input  logic[31:0] pc_addr_i,
	//from rom 
	input  logic[31:0] rom_inst_i,
	//to rom
	output logic[31:0] if2rom_addr_o, 
	// to if_id
	output logic[31:0] inst_addr_o, 
	output logic[31:0] inst_o
	);


	assign if2rom_addr_o = pc_addr_i;
	
	assign inst_addr_o  = pc_addr_i;
	
	assign inst_o = rom_inst_i;



endmodule