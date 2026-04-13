module rom(
	input wire[31:0] inst_addr_i,
	output reg[31:0] inst_o
);
    reg[31:0] rom_mem[0:4065];//4095个 32bit的空间
    
    always @(*)begin 
        inst_o = rom_mem[inst_addr_i>>2];//右移两位=除以4，转换为地址索引
    end   

endmodule