//
module input_delay #(
    parameter   int DELAY = 15
) (
    input   logic   din,
    output  logic   dout
);
    
    (* IODELAY_GROUP = "zmod_idelay_group" *)
    IDELAYE3 #(
      .CASCADE("NONE"),              
      .DELAY_FORMAT("TIME"),        
      .DELAY_SRC("IDATAIN"),         
      .DELAY_TYPE("FIXED"),          
      .DELAY_VALUE(DELAY),           
      .IS_CLK_INVERTED(1'b0),        
      .IS_RST_INVERTED(1'b0),        
      .REFCLK_FREQUENCY(300.0),      
      .SIM_DEVICE("ULTRASCALE_PLUS"),                                     
      .UPDATE_MODE("ASYNC")                                               
    ) IDELAYE3_inst (
      .CASC_OUT(),    
      .CNTVALUEOUT(), 
      .DATAOUT(dout), 
      .CASC_IN(1'b0), 
      .CASC_RETURN(1'b0), 
      .CE(1'b0),          
      .CLK(CLK),          
      .CNTVALUEIN(0), 
      .DATAIN(1'b0),      
      .EN_VTC(1'b1),      
      .IDATAIN(din),      
      .INC(1'b0),         
      .LOAD(1'b0),        
      .RST(1'b0)          
    );

endmodule
    
/*    
    (* IODELAY_GROUP = "zmod_idelay_group" *)
    IDELAYE2  # (
        .CINVCTRL_SEL           ("FALSE"),   // TRUE, FALSE
        .DELAY_SRC              ("IDATAIN"), // IDATAIN, DATAIN
        .HIGH_PERFORMANCE_MODE  ("FALSE"),   // TRUE, FALSE
        .IDELAY_TYPE            ("FIXED"),   // FIXED, VARIABLE, or VAR_LOADABLE
        .IDELAY_VALUE           (DELAY),     // 0 to 31
        .REFCLK_FREQUENCY       (200.0),
        .PIPE_SEL               ("FALSE"),
        .SIGNAL_PATTERN         ("DATA")     // CLOCK, DATA
    ) idelaye2_bus (
        .DATAOUT                (dout),
        .DATAIN                 (1'b0),      // Data from FPGA logic
        .C                      (1'b0),
        .CE                     (1'b0),
        .INC                    (1'b0),
        .IDATAIN                (din),       // Driven by IOB
        .LD                     (1'b0),
        .REGRST                 (1'b0),
        .LDPIPEEN               (1'b0),
        .CNTVALUEIN             (5'b00000),
        .CNTVALUEOUT            (),
        .CINVCTRL               (1'b0)
    );
*/    

/*
   IDELAYE3 #(
      .CASCADE("NONE"),               // Cascade setting (MASTER, NONE, SLAVE_END, SLAVE_MIDDLE)
      .DELAY_FORMAT("TIME"),          // Units of the DELAY_VALUE (COUNT, TIME)
      .DELAY_SRC("IDATAIN"),          // Delay input (DATAIN, IDATAIN)
      .DELAY_TYPE("FIXED"),           // Set the type of tap delay line (FIXED, VARIABLE, VAR_LOAD)
      .DELAY_VALUE(0),                // Input delay value setting
      .IS_CLK_INVERTED(1'b0),         // Optional inversion for CLK
      .IS_RST_INVERTED(1'b0),         // Optional inversion for RST
      .REFCLK_FREQUENCY(300.0),       // IDELAYCTRL clock input frequency in MHz (200.0-800.0)
      .SIM_DEVICE("ULTRASCALE_PLUS"), // Set the device version for simulation functionality (ULTRASCALE,
                                      // ULTRASCALE_PLUS, ULTRASCALE_PLUS_ES1, ULTRASCALE_PLUS_ES2)
      .UPDATE_MODE("ASYNC")           // Determines when updates to the delay will take effect (ASYNC, MANUAL,
                                      // SYNC)
   )
   IDELAYE3_inst (
      .CASC_OUT(CASC_OUT),       // 1-bit output: Cascade delay output to ODELAY input cascade
      .CNTVALUEOUT(CNTVALUEOUT), // 9-bit output: Counter value output
      .DATAOUT(DATAOUT),         // 1-bit output: Delayed data output
      .CASC_IN(CASC_IN),         // 1-bit input: Cascade delay input from slave ODELAY CASCADE_OUT
      .CASC_RETURN(CASC_RETURN), // 1-bit input: Cascade delay returning from slave ODELAY DATAOUT
      .CE(CE),                   // 1-bit input: Active-High enable increment/decrement input
      .CLK(CLK),                 // 1-bit input: Clock input
      .CNTVALUEIN(CNTVALUEIN),   // 9-bit input: Counter value input
      .DATAIN(DATAIN),           // 1-bit input: Data input from the logic
      .EN_VTC(EN_VTC),           // 1-bit input: Keep delay constant over VT
      .IDATAIN(IDATAIN),         // 1-bit input: Data input from the IOBUF
      .INC(INC),                 // 1-bit input: Increment / Decrement tap delay input
      .LOAD(LOAD),               // 1-bit input: Load DELAY_VALUE input
      .RST(RST)                  // 1-bit input: Asynchronous Reset to the DELAY_VALUE
   );
*/
