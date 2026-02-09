`timescale 1ns / 1ps

module zmod_test_tb();

    logic clk_out_p, clk_out_n;
    logic[3:0] d_out_p, d_out_n;
    logic clk_in_p, clk_in_n;
    logic[3:0] d_in_p,  d_in_n;
    logic base_clk, rxclk;
    localparam time clk_period=10; logic clk=0; always #(clk_period/2) clk=~clk;
    assign base_clk = clk;
    
    zmod_test uut(.*);
    
    assign clk_in_p = clk_out_p;
    assign clk_in_n = clk_out_n;
    assign d_in_p = d_out_p;
    assign d_in_n = d_out_n;

endmodule
