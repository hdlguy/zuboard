`timescale 1ns / 1ps

module oddr_tb ();

    localparam time clk_period=4; logic clk=0; always #(clk_period/2) clk=~clk;

    logic[7:0] tx_data=0; 
    always_ff @(posedge clk) tx_data <= #0.1 tx_data + 1;
    
    logic[3:0] d_out;
    generate for(genvar i=0; i<4; i++) begin
        ODDRE1 #(.IS_C_INVERTED(1'b0), .IS_D1_INVERTED(1'b0), .IS_D2_INVERTED(1'b0), .SIM_DEVICE("ULTRASCALE_PLUS"), .SRVAL(1'b0)) ODDRE1_data (.Q(d_out[i]), .C(clk), .D1(tx_data[i*2+0]), .D2(tx_data[i*2+1]), .SR(1'b0));  
    end endgenerate

endmodule

