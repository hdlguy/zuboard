
create_clock -period 1.600 -name zmod_clk_in [get_ports {zmod_clk_in_p}]

#set zmod_mindel 1.05
#set zmod_maxdel 1.45

#set zmod_mindel -0.1
#set zmod_maxdel +0.1

#set_input_delay -clock [get_clocks {zmod_clk_in}] -clock_fall -min -add_delay $zmod_mindel [get_ports {zmod_d_in_p[*]}]
#set_input_delay -clock [get_clocks {zmod_clk_in}] -clock_fall -max -add_delay $zmod_maxdel [get_ports {zmod_d_in_p[*]}]
#set_input_delay -clock [get_clocks {zmod_clk_in}]             -min -add_delay $zmod_mindel [get_ports {zmod_d_in_p[*]}]
#set_input_delay -clock [get_clocks {zmod_clk_in}]             -max -add_delay $zmod_maxdel [get_ports {zmod_d_in_p[*]}]



#create_generated_clock -name zmod_clk_out -divide_by 1 -source [get_pins zmod_test_inst/ODDRE1_clk_out/C] [get_ports zmod_clk_out_p]

#set_output_delay -clock [get_clocks {zmod_clk_out}] -clock_fall -min -add_delay -0.1 [get_ports {zmod_d_out_p[*]}]
#set_output_delay -clock [get_clocks {zmod_clk_out}] -clock_fall -max -add_delay +0.1 [get_ports {zmod_d_out_p[*]}]
#set_output_delay -clock [get_clocks {zmod_clk_out}]             -min -add_delay -0.1 [get_ports {zmod_d_out_p[*]}]
#set_output_delay -clock [get_clocks {zmod_clk_out}]             -max -add_delay +0.1 [get_ports {zmod_d_out_p[*]}]

#set_output_delay -clock [get_clocks {zmod_clk_out}] -clock_fall -min -add_delay 0.1  [get_ports {zmod_d_out_p[*]}]
#set_output_delay -clock [get_clocks {zmod_clk_out}] -clock_fall -max -add_delay 1.15 [get_ports {zmod_d_out_p[*]}]
#set_output_delay -clock [get_clocks {zmod_clk_out}]             -min -add_delay 0.1  [get_ports {zmod_d_out_p[*]}]
#set_output_delay -clock [get_clocks {zmod_clk_out}]             -max -add_delay 1.15 [get_ports {zmod_d_out_p[*]}]
