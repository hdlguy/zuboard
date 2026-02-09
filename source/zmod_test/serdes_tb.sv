`timescale 1ns / 1ps

module serdes_tb ();

    localparam int N = 3; // number of data lanes

    localparam clk_period=10; logic clk=1; always #(clk_period/2) clk=~clk;

    // tx clocks
    logic txclk, txdivclk, hssclk, hssclk_p, hssclk_n;
    zmod_txpll txpll_inst (.clkin(clk), .clkout(txdivclk), .clkoutx4(txclk), .locked(txlocked));
    OSERDESE3 #(.DATA_WIDTH(8), .INIT(1'b0), .IS_CLKDIV_INVERTED(1'b0), .IS_CLK_INVERTED(1'b0), .IS_RST_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"))
    OSERDESE3_txclk (.CLK(txclk), .CLKDIV(txdivclk), .D(8'b10101010), .RST(1'b0), .OQ(hssclk), .T(1'b0), .T_OUT());
    OBUFDS OBUFDS_hssclk (.I(hssclk), .O(hssclk_p), .OB(hssclk_n));   

    // tx sync
    logic hss_sync, hss_sync_p, hss_sync_n;
    OSERDESE3 #(.DATA_WIDTH(8), .INIT(1'b0), .IS_CLKDIV_INVERTED(1'b0), .IS_CLK_INVERTED(1'b0), .IS_RST_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"))
    OSERDESE3_txsync (.CLK(txclk), .CLKDIV(txdivclk), .D(8'b0000_0001), .RST(1'b0), .OQ(hss_sync), .T(1'b0), .T_OUT());
    OBUFDS OBUFDS_hss_sync (.I(hss_sync), .O(hss_sync_p), .OB(hss_sync_n));   

    // tx data
    logic[N-1:0][7:0] txdata=0;
    always_ff @(posedge txdivclk) txdata <= txdata+1;
    logic[N-1:0] txhssdata, hssdata_p, hssdata_n;
    generate for (genvar i=0; i<N; i++) begin
        OSERDESE3 #(.DATA_WIDTH(8), .INIT(1'b0), .IS_CLKDIV_INVERTED(1'b0), .IS_CLK_INVERTED(1'b0), .IS_RST_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"))
        OSERDESE3_txdata (.CLK(txclk), .CLKDIV(txdivclk), .D(txdata[i]), .RST(1'b0), .OQ(txhssdata[i]), .T(1'b0), .T_OUT());
        OBUFDS OBUFDS_txdata (.I(txhssdata[i]), .O(hssdata_p[i]), .OB(hssdata_n[i]));   
    end endgenerate

    // rx clock
    logic rxdivclk, rxclk, rxclk_buf, rxlocked;
    IBUFDS IBUFDS_clk (.I(hssclk_p), .IB(hssclk_n), .O(rxclk_buf));        
    zmod_rxdll rxdll_inst(.clkin(rxclk_buf), .clkout(rxclk), .divclkout(rxdivclk), .locked(rxlocked));

    // rx sync
    logic[7:0] rxsync;
    logic rx_hss_sync;
    IBUFDS IBUFDS_sync (.I(hss_sync_p), .IB(hss_sync_n), .O(rx_hss_sync));        
    ISERDESE3 #(.DATA_WIDTH(8), .FIFO_ENABLE("FALSE"), .FIFO_SYNC_MODE("FALSE"), .IS_CLK_B_INVERTED(1'b1), .IS_CLK_INVERTED(1'b0), .IS_RST_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"))
    ISERDESE3_rxsync (.RST(1'b0), .CLK(rxclk), .CLK_B(rxclk), .CLKDIV(rxdivclk), .D(rx_hss_sync), .Q(rxsync), .FIFO_EMPTY(), .INTERNAL_DIVCLK(), .FIFO_RD_CLK(1'b0), .FIFO_RD_EN(1'b0));  

    // rx data
    logic[N-1:0] rxhssdata;
    logic[N-1:0][7:0] rxdata;
    generate for (genvar i=0; i<N; i++) begin
        IBUFDS IBUFDS_data (.I(hssdata_p[i]), .IB(hssdata_n[i]), .O(rxhssdata[i]));        
        ISERDESE3 #(.DATA_WIDTH(8), .FIFO_ENABLE("FALSE"), .FIFO_SYNC_MODE("FALSE"), .IS_CLK_B_INVERTED(1'b1), .IS_CLK_INVERTED(1'b0), .IS_RST_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"))
        ISERDESE3_rxdata (.RST(1'b0), .CLK(rxclk), .CLK_B(rxclk), .CLKDIV(rxdivclk), .D(rxhssdata[i]), .Q(rxdata[i]), .FIFO_EMPTY(), .INTERNAL_DIVCLK(), .FIFO_RD_CLK(1'b0), .FIFO_RD_EN(1'b0));  
    end endgenerate

    // rx alignment gearbox
    logic[N-1:0][15:0] rxshift;
    logic[3:0] shift;
    logic[N-1:0][7:0] rx_dout, rx_dout_q;
    logic error=0; 
    logic[N-1:0][7:0] inc_sum;
    assign inc_sum = rx_dout_q+1;
    always_ff @(posedge rxdivclk) begin

        for (int i=0; i<N; i++) rxshift[i] <= {rxdata[i], rxshift[i][15:8]};

        // determine the needed shift
        case (rxsync)
            8'b0000_0001: shift <= 0;
            8'b0000_0010: shift <= 1;
            8'b0000_0100: shift <= 2;
            8'b0000_1000: shift <= 3;
            8'b0001_0000: shift <= 4;
            8'b0010_0000: shift <= 5;
            8'b0100_0000: shift <= 6;
            8'b1000_0000: shift <= 7;
            default:      shift <= 0;
        endcase

        // apply shift
        for (int i=0; i<N; i++) rx_dout[i] <= rxshift[i] >> shift;

        // rx data verification
        rx_dout_q <= rx_dout;
        error <= (rx_dout != inc_sum);        

    end
    
endmodule
