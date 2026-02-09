//
module zmod_test (
    input   logic           base_clk,  // 100MHz reference clock
    output  logic           clk_out_p, clk_out_n,
    output  logic[3:0]      d_out_p,   d_out_n,
    input   logic           clk_in_p,  clk_in_n,
    input   logic[3:0]      d_in_p,    d_in_n,
    output  logic           rxclk
);

    // tx clock synthesis
    logic txclk, locked, refclk;
    zmod_clk_wiz clk_wiz_inst (.clk_in1(base_clk), .clkout(txclk), .locked(locked));    

    // pattern generation
    logic[7:0] tx_data=0;
    always_ff @(posedge txclk) tx_data <= tx_data + 1;
    
    // transmit the tx clock
    ODDRE1 #(.IS_C_INVERTED(1'b0), .IS_D1_INVERTED(1'b0), .IS_D2_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"), .SRVAL(1'b0)) ODDRE1_clk_out (.Q(clk_out), .C(txclk), .D1(1'b1), .D2(1'b0), .SR(1'b0));   
    OBUFDS OBUFDS_clk_out (.I(clk_out), .O(clk_out_p),  .OB(clk_out_n));   
    

    // rx clock synthesis
    logic rxlocked, rxclk;
    zmod_clk_in_wiz clk_in_wiz_inst (.clk_in1_p(clk_in_p), .clk_in1_n(clk_in_n), .clkout(rxclk), .locked(rxlocked));
    

    // IO Logic
    logic[3:0] d_in; 
    logic[7:0] d_in_q, d_in_qq;
    localparam int DELAY = 0;
    logic[3:0] d_out;
    generate for(genvar i=0; i<4; i++) begin
    
        ODDRE1 #(.IS_C_INVERTED(1'b0), .IS_D1_INVERTED(1'b0), .IS_D2_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"), .SRVAL(1'b0)) ODDRE1_data (.Q(d_out[i]), .C(txclk), .D1(tx_data[i*2+0]), .D2(tx_data[i*2+1]), .SR(1'b0));  
        OBUFDS OBUFDS_data (.I(d_out[i]), .O(d_out_p[i]),  .OB(d_out_n[i]));   
        
        IBUFDS IBUFDS_data (.I(d_in_p[i]), .IB(d_in_n[i]), .O(d_in[i]));    
        IDDRE1 #(.DDR_CLK_EDGE("SAME_EDGE"), .IS_CB_INVERTED(1'b1), .IS_C_INVERTED(1'b0)) IDDRE1_inst (.Q1(d_in_q[i*2+1]), .Q2(d_in_q[i*2+0]), .C(rxclk),.CB(rxclk), .D(d_in[i]), .R(1'b0));
        
    end endgenerate

    // rx data verification
    logic error=0; 
    logic[7:0] inc_sum;
    assign inc_sum = d_in_qq+1;
    always_ff @(posedge rxclk) begin
        d_in_qq <= d_in_q;
        error <= (d_in_q != inc_sum);        
    end

    // debug
    zmod_ila ila_inst (.clk(rxclk), .probe0({error, d_in_q})); // 9

endmodule


/*
*/
