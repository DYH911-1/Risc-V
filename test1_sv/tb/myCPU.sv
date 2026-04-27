`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/24 10:51:04
// Design Name: 
// Module Name: myCPU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module myCPU (
    input  logic         cpu_rst,
    input  logic         cpu_clk,

    // Interface to IROM
    output logic [31:0]  irom_addr,
    input  logic [31:0]  irom_data,
    
    // Interface to DRAM
    output logic [31:0]  perip_addr,
    output logic         perip_wen,
	output logic [ 1:0]  perip_mask,
    output logic [31:0]  perip_wdata,
    input  logic [31:0]  perip_rdata

);
    // 信号映射：比赛接口 <-> top_riscv接口
	top_riscv u_top_riscv (
		.clk             (cpu_clk),
		.rst             (cpu_rst),
		
		// IROM接口
		.inst_i          (irom_data),
		.inst_addr_o     (irom_addr),
		
		// DRAM/外设接口
		.mem_wr_req_o    (perip_wen),
		.perip_mask_o    (perip_mask),
		.mem_addr_o      (perip_addr),
		.mem_wr_data_o   (perip_wdata),
		.mem_rd_data_i   (perip_rdata)
	);
endmodule

