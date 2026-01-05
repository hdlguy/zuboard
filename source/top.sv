//
module top (
    inout   logic   temp_i2c_scl,
    inout   logic   temp_i2c_sda,
    //
    inout   logic   spi_1_mosi,
    inout   logic   spi_1_miso,
    inout   logic   spi_1_sck,
    inout   logic   spi_1_csn,
    //
    output  logic   led1_red,
    output  logic   led1_green,
    output  logic   led1_blue,
    output  logic   led2_red,
    output  logic   led2_green,
    output  logic   led2_blue,
    //
    output  logic           zmod_clk_out_p,
    output  logic           zmod_clk_out_n,
    output  logic[3:0]      zmod_d_out_p,
    output  logic[3:0]      zmod_d_out_n,
    input   logic           zmod_clk_in_p,
    input   logic           zmod_clk_in_n,
    input   logic[3:0]      zmod_d_in_p,
    input   logic[3:0]      zmod_d_in_n
);

    logic [15:0] regfile_addr;       
    logic regfile_clk;                
    logic [31:0] regfile_din;         
    logic [31:0] regfile_dout;        
    logic regfile_en;                  
    logic regfile_rst;                
    logic [3:0] regfile_we;            

    logic           axi_aclk;
    logic [0:0]     axi_aresetn;
    
    logic temp_i2c_scl_i, temp_i2c_scl_o, temp_i2c_scl_t;
    logic temp_i2c_sda_i, temp_i2c_sda_o, temp_i2c_sda_t;    
    
    logic SPI_1_io0_i, SPI_1_io0_o, SPI_1_io0_t;
    logic SPI_1_io1_i, SPI_1_io1_o, SPI_1_io1_t;
    logic SPI_1_sck_i, SPI_1_sck_o, SPI_1_sck_t;
    logic SPI_1_ss_i,  SPI_1_ss_o,  SPI_1_ss_t;

    system system_i (
        .regfile_addr   (regfile_addr), // output wire [15:0] regfile_addr
        .regfile_clk    (regfile_clk), // output wire regfile_clk
        .regfile_din    (regfile_din), // output wire [31:0] regfile_din
        .regfile_dout   (regfile_dout), // input wire [31:0] regfile_dout
        .regfile_en     (regfile_en), // output wire regfile_en
        .regfile_rst    (regfile_rst), // output wire regfile_rst
        .regfile_we     (regfile_we), // output wire [3:0] regfile_we
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
    

    IOBUF SPI_1_io0_iobuf (.I(SPI_1_io0_o), .IO(spi_1_mosi), .O(SPI_1_io0_i), .T(SPI_1_io0_t));
    IOBUF SPI_1_io1_iobuf (.I(SPI_1_io1_o), .IO(spi_1_miso), .O(SPI_1_io1_i), .T(SPI_1_io1_t));
    IOBUF SPI_1_sck_iobuf (.I(SPI_1_sck_o), .IO(spi_1_sck),  .O(SPI_1_sck_i), .T(SPI_1_sck_t));
    IOBUF SPI_1_ss_iobuf  (.I(SPI_1_ss_o),  .IO(spi_1_csn),  .O(SPI_1_ss_i),  .T(SPI_1_ss_t));
    

    IOBUF temp_i2c_scl_iobuf (.I(temp_i2c_scl_o), .IO(temp_i2c_scl), .O(temp_i2c_scl_i), .T(temp_i2c_scl_t));
    IOBUF temp_i2c_sda_iobuf (.I(temp_i2c_sda_o), .IO(temp_i2c_sda), .O(temp_i2c_sda_i), .T(temp_i2c_sda_t));

    logic[27:0] led_count;
    always_ff @(posedge axi_aclk) led_count <= led_count + 1;
    assign led1_red   = led_count[27];
    assign led1_green = led_count[26];
    assign led1_blue  = led_count[25];
    
    
    
    localparam int Naddr = 4;
    localparam int Nregs = 2**Naddr;
    localparam logic[Nregs-1:0][31:0] init_reg = 0;

    logic[Nregs-1:0][31:0]  reg_val, pul_val, read_val;
    mem_regfile #(
       .Naddr       (Naddr),
       .init_reg    (init_reg)
    ) uut (
       .clk         (regfile_clk),
       .addr        (regfile_addr[Naddr+2-1:2]),
       .wr_data     (regfile_din),
       .rd_data     (regfile_dout),
       .en          (regfile_en),
       .we          (regfile_we),
       //
       .reg_val     (reg_val),
       .pul_val     (pul_val),
       .read_val    (read_val)
    );

    assign read_val[0] = 32'hdeadbeef;
    assign read_val[1] = 32'h01234567;
    assign read_val[Nregs-1:2] = reg_val[Nregs-1:2];
    

    logic zmod_rx_clk;
    zmod_test zmod_test_inst (
        .clk(axi_aclk), 
        .clk_out_p(zmod_clk_out_p), .clk_out_n(zmod_clk_out_n), .d_out_p(zmod_d_out_p), .d_out_n(zmod_d_out_n), 
        .clk_in_p(zmod_clk_in_p),   .clk_in_n(zmod_clk_in_n),   .d_in_p(zmod_d_in_p),   .d_in_n(zmod_d_in_n),
        .rxclk(zmod_rxclk)
    );
    
    logic[31:0] zmod_count;
    always_ff @(posedge zmod_rxclk) begin
        zmod_count <= zmod_count + 1;
        led2_red <= zmod_count[27];
        led2_green <= zmod_count[26];
        led2_blue <= zmod_count[25];
    end     

endmodule

/*
module zmod_test (
    input   logic           base_clk,  // base clock
    output  logic           clk_out_p, clk_out_n,
    output  logic[3:0]      d_out_p, d_out_n,
    input   logic           clk_in_p, clk_in_n,
    input   logic[3:0]      d_in_p,  d_in_n
);
*/
