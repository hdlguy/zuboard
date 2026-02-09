
module zmod_txpll (
    input         clkin,
    output        clkout,
    output        clkoutx4,
    output        locked
);
    localparam int D = 1;
    localparam int M = 12;
    localparam real R0 = 8.0;
    localparam real R1 = 2.0;

    logic clkin_buf, clkfb, clkout0, clkout1;
    BUFG clkin_ibuf (.O (clkin_buf), .I (clkin));

    PLLE4_BASE #(
        .DIVCLK_DIVIDE(D),          // Master division value
        .CLKFBOUT_MULT(M),          // Multiply value for all CLKOUT
        .CLKFBOUT_PHASE(0.0),       // Phase offset in degrees of CLKFB
        .CLKIN_PERIOD(10.0),        // Input clock period in ns to ps resolution (i.e., 33.333 is 30 MHz).
        .CLKOUT0_DIVIDE(R0),        // Divide amount for CLKOUT0
        .CLKOUT0_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT0
        .CLKOUT0_PHASE(0.0),        // Phase offset for CLKOUT0
        .CLKOUT1_DIVIDE(R1),        // Divide amount for CLKOUT1
        .CLKOUT1_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT1
        .CLKOUT1_PHASE(0.0),        // Phase offset for CLKOUT1
        .CLKOUTPHY_MODE("VCO_2X"),  // Frequency of the CLKOUTPHY
        .IS_CLKFBIN_INVERTED(1'b0), // Optional inversion for CLKFBIN
        .IS_CLKIN_INVERTED(1'b0),   // Optional inversion for CLKIN
        .IS_PWRDWN_INVERTED(1'b0),  // Optional inversion for PWRDWN
        .IS_RST_INVERTED(1'b0),     // Optional inversion for RST
        .REF_JITTER(0.0),           // Reference input jitter in UI
        .STARTUP_WAIT("FALSE")      // Delays DONE until PLL is locked
    ) PLLE4_BASE_inst (
        .CLKFBOUT(clkfb),           // 1-bit output: Feedback clock
        .CLKOUT0(clkout0),          // 1-bit output: General Clock output
        .CLKOUT0B(),                // 1-bit output: Inverted CLKOUT0
        .CLKOUT1(clkout1),          // 1-bit output: General Clock output
        .CLKOUT1B(),                // 1-bit output: Inverted CLKOUT1
        .CLKOUTPHY(),               // 1-bit output: Bitslice clock
        .LOCKED(locked),            // 1-bit output: LOCK
        .CLKFBIN(clkfb),            // 1-bit input: Feedback clock
        .CLKIN(clkin_buf),          // 1-bit input: Input clock
        .CLKOUTPHYEN(1'b0),         // 1-bit input: CLKOUTPHY enable
        .PWRDWN(1'b0),              // 1-bit input: Power-down
        .RST(1'b0)                  // 1-bit input: Reset
    );

  BUFG clk0_buf (.O(clkout),   .I(clkout0));
  BUFG clk1_buf (.O(clkoutx4), .I(clkout1));

endmodule


