//
module top (
    inout   logic   temp_i2c_scl,
    inout   logic   temp_i2c_sda
);

    logic [39:0]    M00_AXI_araddr;
    logic [2:0]     M00_AXI_arprot;
    logic           M00_AXI_arready;
    logic           M00_AXI_arvalid;
    logic [39:0]    M00_AXI_awaddr;
    logic [2:0]     M00_AXI_awprot;
    logic           M00_AXI_awready;
    logic           M00_AXI_awvalid;
    logic           M00_AXI_bready;
    logic [1:0]     M00_AXI_bresp;
    logic           M00_AXI_bvalid;
    logic [31:0]    M00_AXI_rdata;
    logic           M00_AXI_rready;
    logic [1:0]     M00_AXI_rresp;
    logic           M00_AXI_rvalid;
    logic [31:0]    M00_AXI_wdata;
    logic           M00_AXI_wready;
    logic [3:0]     M00_AXI_wstrb;
    logic           M00_AXI_wvalid;

    logic           axi_aclk;
    logic [0:0]     axi_aresetn;
    
    logic temp_i2c_scl_i, temp_i2c_scl_o, temp_i2c_scl_t;
    logic temp_i2c_sda_i, temp_i2c_sda_o, temp_i2c_sda_t;    
    
    logic SPI_1_io0_i, SPI_1_io0_io, SPI_1_io0_o, SPI_1_io0_t;
    logic SPI_1_io1_i, SPI_1_io1_io, SPI_1_io1_o, SPI_1_io1_t;
    logic SPI_1_sck_i, SPI_1_sck_io, SPI_1_sck_o, SPI_1_sck_t;
    logic SPI_1_ss_i,  SPI_1_ss_io,  SPI_1_ss_o,  SPI_1_ss_t;

    system system_i (
        .M00_AXI_araddr     (M00_AXI_araddr),
        .M00_AXI_arprot     (M00_AXI_arprot),
        .M00_AXI_arready    (M00_AXI_arready),
        .M00_AXI_arvalid    (M00_AXI_arvalid),
        .M00_AXI_awaddr     (M00_AXI_awaddr),
        .M00_AXI_awprot     (M00_AXI_awprot),
        .M00_AXI_awready    (M00_AXI_awready),
        .M00_AXI_awvalid    (M00_AXI_awvalid),
        .M00_AXI_bready     (M00_AXI_bready),
        .M00_AXI_bresp      (M00_AXI_bresp),
        .M00_AXI_bvalid     (M00_AXI_bvalid),
        .M00_AXI_rdata      (M00_AXI_rdata),
        .M00_AXI_rready     (M00_AXI_rready),
        .M00_AXI_rresp      (M00_AXI_rresp),
        .M00_AXI_rvalid     (M00_AXI_rvalid),
        .M00_AXI_wdata      (M00_AXI_wdata),
        .M00_AXI_wready     (M00_AXI_wready),
        .M00_AXI_wstrb      (M00_AXI_wstrb),
        .M00_AXI_wvalid     (M00_AXI_wvalid),
        //
        .axi_aclk           (axi_aclk),
        .axi_aresetn        (axi_aresetn),
        //
        .temp_i2c_scl_i(temp_i2c_scl_i),
        .temp_i2c_scl_o(temp_i2c_scl_o),
        .temp_i2c_scl_t(temp_i2c_scl_t),
        .temp_i2c_sda_i(temp_i2c_sda_i),
        .temp_i2c_sda_o(temp_i2c_sda_o),
        .temp_i2c_sda_t(temp_i2c_sda_t),
        //
        .SPI_1_io0_i(SPI_1_io0_i),
        .SPI_1_io0_o(SPI_1_io0_o),
        .SPI_1_io0_t(SPI_1_io0_t),
        .SPI_1_io1_i(SPI_1_io1_i),
        .SPI_1_io1_o(SPI_1_io1_o),
        .SPI_1_io1_t(SPI_1_io1_t),
        .SPI_1_sck_i(SPI_1_sck_i),
        .SPI_1_sck_o(SPI_1_sck_o),
        .SPI_1_sck_t(SPI_1_sck_t),
        .SPI_1_ss_i(SPI_1_ss_i),
        .SPI_1_ss_o(SPI_1_ss_o),
        .SPI_1_ss_t(SPI_1_ss_t)        
    );
    
    assign SPI_1_io0_i = SPI_1_io0_o;
    assign SPI_1_io1_i = SPI_1_io0_o;
    assign SPI_1_sck_i = SPI_1_sck_o;
    assign SPI_1_ss_i  = SPI_1_ss_o;
    
    spi_ila spi_ila_inst (.clk(axi_aclk), .probe0({
        SPI_1_io0_i, SPI_1_io0_io, SPI_1_io0_o, SPI_1_io0_t,
        SPI_1_io1_i, SPI_1_io1_io, SPI_1_io1_o, SPI_1_io1_t,
        SPI_1_sck_i, SPI_1_sck_io, SPI_1_sck_o, SPI_1_sck_t,
        SPI_1_ss_i,  SPI_1_ss_io,  SPI_1_ss_o,  SPI_1_ss_t
    }));
    

    IOBUF temp_i2c_scl_iobuf (.I(temp_i2c_scl_o), .IO(temp_i2c_scl), .O(temp_i2c_scl_i), .T(temp_i2c_scl_t));
    IOBUF temp_i2c_sda_iobuf (.I(temp_i2c_sda_o), .IO(temp_i2c_sda), .O(temp_i2c_sda_i), .T(temp_i2c_sda_t));

    
    
    // This register file gives software contol over unit under test (UUT).
    localparam int Nregs = 16;
    logic [Nregs-1:0][31:0] slv_reg, slv_read;

    assign slv_read[0] = 32'hdeadbeef;
    assign slv_read[1] = 32'h76543210;
    
    assign slv_read[2] = slv_reg[2];
    
    assign slv_read[Nregs-1:3] = slv_reg[Nregs-1:3];

	axi_regfile_v1_0_S00_AXI #	(
		.C_S_AXI_DATA_WIDTH(32),
		.C_S_AXI_ADDR_WIDTH(6) // 16 32 bit registers.
	) axi_regfile_inst (
        // register interface
        .slv_read(slv_read), 
        .slv_reg (slv_reg),  
        // axi interface
		.S_AXI_ACLK    (axi_aclk),
		.S_AXI_ARESETN (axi_aresetn),
        //
		.S_AXI_ARADDR  (M00_AXI_araddr ),
		.S_AXI_ARPROT  (M00_AXI_arprot ),
		.S_AXI_ARREADY (M00_AXI_arready),
		.S_AXI_ARVALID (M00_AXI_arvalid),
		.S_AXI_AWADDR  (M00_AXI_awaddr ),
		.S_AXI_AWPROT  (M00_AXI_awprot ),
		.S_AXI_AWREADY (M00_AXI_awready),
		.S_AXI_AWVALID (M00_AXI_awvalid),
		.S_AXI_BREADY  (M00_AXI_bready ),
		.S_AXI_BRESP   (M00_AXI_bresp  ),
		.S_AXI_BVALID  (M00_AXI_bvalid ),
		.S_AXI_RDATA   (M00_AXI_rdata  ),
		.S_AXI_RREADY  (M00_AXI_rready ),
		.S_AXI_RRESP   (M00_AXI_rresp  ),
		.S_AXI_RVALID  (M00_AXI_rvalid ),
		.S_AXI_WDATA   (M00_AXI_wdata  ),
		.S_AXI_WREADY  (M00_AXI_wready ),
		.S_AXI_WSTRB   (M00_AXI_wstrb  ),
		.S_AXI_WVALID  (M00_AXI_wvalid )
	);

endmodule
    
