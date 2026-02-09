# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -part xczu1cg-sbva484-1-e -force proj 
#set_property board_part avnet.com:zuboard_1cg:part0:1.0 [current_project]
#set_property part xczu1cg-sbva484-1-e [current_project]
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]
load_features ipintegrator

read_ip ../source/zmod_test/zmod_ila/zmod_ila.xci
upgrade_ip -quiet  [get_ips *]
generate_target {all} [get_ips *]

source ../source/system.tcl
generate_target {synthesis implementation} [get_files ./proj.srcs/sources_1/bd/system/system.bd]
set_property synth_checkpoint_mode None    [get_files ./proj.srcs/sources_1/bd/system/system.bd]

#read_verilog -sv ../source/zmod_test/zmod_txpll.sv
read_verilog -sv ../source/zmod_test/zmod_txdll.sv
read_verilog -sv ../source/zmod_test/zmod_rxdll.sv
read_verilog -sv ../source/zmod_test/zmod_test.sv

#read_verilog -sv ../source/axi_regfile/axi_regfile_v1_0_S00_AXI.sv
read_verilog -sv ../source/mem_regfile.sv
read_verilog -sv ../source/top.sv

read_xdc ../source/pins.xdc
read_xdc ../source/timing.xdc
#set_property used_in_synthesis false [get_files ../source/timing.xdc]

close_project

#########################



