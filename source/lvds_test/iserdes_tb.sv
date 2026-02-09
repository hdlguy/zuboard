`timescale 1ns / 1ps

module iserdes_tb ();
    
    localparam clk_period=10; logic clk=1; always #(clk_period/2) clk=~clk;
    logic rxclk, rxdivclk=0;
    assign rxclk = clk;
    always #(4*clk_period/2) rxdivclk=~rxdivclk;
    
    logic d_in;
    logic[7:0] rxdata;
    logic reset;
    
    ISERDESE3 #(.DATA_WIDTH(8), .FIFO_ENABLE("FALSE"), .FIFO_SYNC_MODE("FALSE"), .IS_CLK_B_INVERTED(1'b1), .IS_CLK_INVERTED(1'b0), .IS_RST_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"))
    ISERDESE3_inst (.RST(1'b0), .CLK(rxclk), .CLK_B(rxclk), .CLKDIV(rxdivclk), .D(d_in), .Q(rxdata), .FIFO_EMPTY(), .INTERNAL_DIVCLK(), .FIFO_RD_CLK(1'b0), .FIFO_RD_EN(1'b0));  
    
    always_ff @(rxclk) d_in <= #0.25 $random();

endmodule
