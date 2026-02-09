module zmod_txdll (
    input         clkin,
    output        clkout,
    output        clkoutx4,
    output        locked
);

    
    localparam int  D = 1;
    localparam real M = 12.5;
    localparam real R0 = 8.0;
    localparam real R1 = 2.0;

    logic clkin_buf, clkfb, clkout0, clkout1;
    BUFG clkin_ibuf (.O (clkin_buf), .I (clkin));
    
    MMCME4_BASE #(
        .DIVCLK_DIVIDE(D),          // Master division value
        .CLKFBOUT_MULT_F(M),        // Multiply value for all CLKOUT
        .CLKFBOUT_PHASE(0),         // Phase offset in degrees of CLKFB
        .CLKIN1_PERIOD(10.0),       // Input clock period in ns to ps resolution (i.e., 33.333 is 30 MHz).
        .CLKOUT0_DIVIDE_F(R0),      // Divide amount for CLKOUT0
        .CLKOUT0_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT0
        .CLKOUT0_PHASE(0.0),        // Phase offset for CLKOUT0
        .CLKOUT1_DIVIDE(R1),        // Divide amount for CLKOUT (1-128)
        .CLKOUT1_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT outputs (0.001-0.999).
        .CLKOUT1_PHASE(0.0),        // Phase offset for CLKOUT outputs (-360.000-360.000).
        .CLKOUT2_DIVIDE(1),         // Divide amount for CLKOUT (1-128)
        .CLKOUT2_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT outputs (0.001-0.999).
        .CLKOUT2_PHASE(0.0),        // Phase offset for CLKOUT outputs (-360.000-360.000).
        .CLKOUT3_DIVIDE(1),         // Divide amount for CLKOUT (1-128)
        .CLKOUT3_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT outputs (0.001-0.999).
        .CLKOUT3_PHASE(0.0),        // Phase offset for CLKOUT outputs (-360.000-360.000).
        .CLKOUT4_CASCADE("FALSE"),  // Divide amount for CLKOUT (1-128)
        .CLKOUT4_DIVIDE(1),         // Divide amount for CLKOUT (1-128)
        .CLKOUT4_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT outputs (0.001-0.999).
        .CLKOUT4_PHASE(0.0),        // Phase offset for CLKOUT outputs (-360.000-360.000).
        .CLKOUT5_DIVIDE(1),         // Divide amount for CLKOUT (1-128)
        .CLKOUT5_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT outputs (0.001-0.999).
        .CLKOUT5_PHASE(0.0),        // Phase offset for CLKOUT outputs (-360.000-360.000).
        .CLKOUT6_DIVIDE(1),         // Divide amount for CLKOUT (1-128)
        .CLKOUT6_DUTY_CYCLE(0.5),   // Duty cycle for CLKOUT outputs (0.001-0.999).
        .CLKOUT6_PHASE(0.0),        // Phase offset for CLKOUT outputs (-360.000-360.000).
        .BANDWIDTH("OPTIMIZED"),    // Jitter programming
        .IS_CLKFBIN_INVERTED(1'b0), // Optional inversion for CLKFBIN
        .IS_CLKIN1_INVERTED(1'b0),  // Optional inversion for CLKIN1
        .IS_PWRDWN_INVERTED(1'b0),  // Optional inversion for PWRDWN
        .IS_RST_INVERTED(1'b0),     // Optional inversion for RST
        .REF_JITTER1(0.0),          // Reference input jitter in UI (0.000-0.999).
        .STARTUP_WAIT("FALSE")      // Delays DONE until MMCM is locked
   ) MMCME4_BASE_inst (
        .CLKFBOUT(clkfb),       // 1-bit output: Feedback clock pin to the MMCM
        .CLKFBOUTB(),           // 1-bit output: Inverted CLKFBOUT
        .CLKOUT0(clkout0),      // 1-bit output: CLKOUT0
        .CLKOUT0B(),            // 1-bit output: Inverted CLKOUT0
        .CLKOUT1(clkout1),      // 1-bit output: CLKOUT1
        .CLKOUT1B(),            // 1-bit output: Inverted CLKOUT1
        .CLKOUT2(),             // 1-bit output: CLKOUT2
        .CLKOUT2B(),            // 1-bit output: Inverted CLKOUT2
        .CLKOUT3(),             // 1-bit output: CLKOUT3
        .CLKOUT3B(),            // 1-bit output: Inverted CLKOUT3
        .CLKOUT4(),             // 1-bit output: CLKOUT4
        .CLKOUT5(),             // 1-bit output: CLKOUT5
        .CLKOUT6(),             // 1-bit output: CLKOUT6
        .LOCKED(locked),        // 1-bit output: LOCK
        .CLKFBIN(clkfb),        // 1-bit input: Feedback clock pin to the MMCM
        .CLKIN1(clkin_buf),     // 1-bit input: Primary clock
        .PWRDWN(1'b0),          // 1-bit input: Power-down
        .RST(1'b0)              // 1-bit input: Reset
    );
    
    BUFG clk0_buf (.O(clkout),   .I(clkout0));
    BUFG clk1_buf (.O(clkoutx4), .I(clkout1));

endmodule


