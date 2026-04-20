onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/clk
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/rst
add wave -noupdate -color Red /tb/open_risc_v_soc_inst/open_risc_v_inst/pc_reg_inst/pc_o
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/ifetch_inst/pc_addr_i
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/ifetch_inst/inst_o
add wave -noupdate -radix unsigned /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/reg1_raddr_i
add wave -noupdate -radix unsigned /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/reg2_raddr_i
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/reg1_rdata_o
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/reg2_rdata_o
add wave -noupdate -radix unsigned /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/reg_waddr_i
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/reg_wdata_i
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/reg_wen
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/regs
add wave -noupdate {/tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/regs[1]}
add wave -noupdate {/tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/regs[2]}
add wave -noupdate -color Yellow -radix decimal {/tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/regs[3]}
add wave -noupdate {/tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/regs[26]}
add wave -noupdate {/tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/regs[27]}
add wave -noupdate {/tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/regs[29]}
add wave -noupdate {/tb/open_risc_v_soc_inst/open_risc_v_inst/regs_inst/regs[30]}
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/ctrl_inst/jump_en_o
add wave -noupdate /tb/open_risc_v_soc_inst/open_risc_v_inst/ctrl_inst/hold_flag_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {310 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 115
configure wave -valuecolwidth 44
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {275 ns} {395 ns}
