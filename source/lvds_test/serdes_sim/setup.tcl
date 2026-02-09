# This script sets up a Vivado project with all ip references resolved.
close_project -quiet
file delete -force proj.xpr *.os *.jou *.log proj.srcs proj.cache proj.runs
#
create_project -part xczu1cg-sbva484-1-e -force proj 
set_property target_language Verilog [current_project]
set_property default_lib work [current_project]

#read_ip ../zmod_rx_ila/zmod_rx_ila.xci
#upgrade_ip -quiet  [get_ips *]
#generate_target {all} [get_ips *]

read_verilog -sv ../iserdes_tb.sv

add_files -fileset sim_1 -norecurse ./iserdes_tb_behav.wcfg

close_project

#########################



