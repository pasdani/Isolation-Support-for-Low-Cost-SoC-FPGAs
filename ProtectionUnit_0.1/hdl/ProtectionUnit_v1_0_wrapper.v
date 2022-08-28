
`timescale 1 ns / 1 ps

	module ProtectionUnit_v1_0_wrapper #
	(
		// Users to add parameters here	
		parameter integer NUM_MEM_REGIONS	= 2,
		parameter integer NUM_DOMAINS		= 2,
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface AXI_CONFIG
		parameter integer AXI_CONFIG_DATA_WIDTH	= 32,
		parameter integer AXI_CONFIG_ADDR_WIDTH	= 8,

		// Parameters of Axi Pass Through AXI_PT
		parameter  C_M_AXI_PT_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_S_AXI_PT_BURST_LEN	= 16,
		parameter integer C_S_AXI_PT_ID_WIDTH	= 2,
		parameter integer C_S_AXI_PT_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_PT_ADDR_WIDTH	= 6,
		parameter integer C_S_AXI_PT_AWUSER_WIDTH	= 0,
		parameter integer C_S_AXI_PT_ARUSER_WIDTH	= 0,
		parameter integer C_S_AXI_PT_WUSER_WIDTH	= 0,
		parameter integer C_S_AXI_PT_RUSER_WIDTH	= 0,
		parameter integer C_S_AXI_PT_BUSER_WIDTH	= 0,

		parameter [C_S_AXI_PT_ADDR_WIDTH-1 : 0]	MEM_REGION_0 =      32'h00000000,
                                            MEM_REGION_1 =      32'h00000000,
                                            MEM_REGION_2 =      32'h00000000,
                                            MEM_REGION_3 =      32'h00000000,
                                            MEM_REGION_4 =      32'h00000000,
                                            MEM_REGION_5 =      32'h00000000,
                                            MEM_REGION_6 =      32'h00000000,
                                            MEM_REGION_7 =      32'h00000000,
                                            MEM_REGION_8 =      32'h00000000,
                                            MEM_REGION_9 =      32'h00000000,
                                            MEM_REGION_10 =     32'h00000000,
                                            MEM_REGION_11 =     32'h00000000,
                                            MEM_REGION_12 =     32'h00000000,
                                            MEM_REGION_13 =     32'h00000000,
                                            MEM_REGION_14 =     32'h00000000,
                                            MEM_REGION_15 =     32'h00000000,
                                            
        parameter [31:0]       	            MEM_REGION_0_LSB =  0,
                                            MEM_REGION_1_LSB =  0,
                                            MEM_REGION_2_LSB =  0,
                                            MEM_REGION_3_LSB =  0,
                                            MEM_REGION_4_LSB =  0,
                                            MEM_REGION_5_LSB =  0,
                                            MEM_REGION_6_LSB =  0,
                                            MEM_REGION_7_LSB =  0,
                                            MEM_REGION_8_LSB =  0,
                                            MEM_REGION_9_LSB =  0,
                                            MEM_REGION_10_LSB = 0,
                                            MEM_REGION_11_LSB = 0,
                                            MEM_REGION_12_LSB = 0,
                                            MEM_REGION_13_LSB = 0,
                                            MEM_REGION_14_LSB = 0,
                                            MEM_REGION_15_LSB = 0,

        parameter [C_S_AXI_PT_ID_WIDTH-1 : 0]   DOMAIN_0_ID =       16'h0000,
                                            DOMAIN_1_ID =       16'h0000,
                                            DOMAIN_2_ID =       16'h0000,
                                            DOMAIN_3_ID =       16'h0000,
                                            DOMAIN_4_ID =       16'h0000,
                                            DOMAIN_5_ID =       16'h0000,
                                            DOMAIN_6_ID =       16'h0000,
                                            DOMAIN_7_ID =       16'h0000,
                                            DOMAIN_8_ID =       16'h0000,
                                            DOMAIN_9_ID =       16'h0000,
                                            DOMAIN_10_ID =      16'h0000,
                                            DOMAIN_11_ID =      16'h0000,
                                            DOMAIN_12_ID =      16'h0000,
                                            DOMAIN_13_ID =      16'h0000,
                                            DOMAIN_14_ID =      16'h0000,
                                            DOMAIN_15_ID =      16'h0000,

		parameter [C_S_AXI_PT_ID_WIDTH-1 : 0]   DOMAIN_0_MASK =     16'hFFFF,
                                            DOMAIN_1_MASK =     16'hFFFF,
                                            DOMAIN_2_MASK =     16'hFFFF,
                                            DOMAIN_3_MASK =     16'hFFFF,
                                            DOMAIN_4_MASK =     16'hFFFF,
                                            DOMAIN_5_MASK =     16'hFFFF,
                                            DOMAIN_6_MASK =     16'hFFFF,
                                            DOMAIN_7_MASK =     16'hFFFF,
                                            DOMAIN_8_MASK =     16'hFFFF,
                                            DOMAIN_9_MASK =     16'hFFFF,
                                            DOMAIN_10_MASK =    16'hFFFF,
                                            DOMAIN_11_MASK =    16'hFFFF,
                                            DOMAIN_12_MASK =    16'hFFFF,
                                            DOMAIN_13_MASK =    16'hFFFF,
                                            DOMAIN_14_MASK =    16'hFFFF,
                                            DOMAIN_15_MASK =    16'hFFFF
	)
	(
		input wire  aclk,
		input wire  aresetn,

		// Ports of Axi Slave Bus Interface AXI_CONFIG
		input wire [AXI_CONFIG_ADDR_WIDTH-1 : 0] AXI_CONFIG_awaddr,
		input wire [2 : 0] AXI_CONFIG_awprot,
		input wire  AXI_CONFIG_awvalid,
		output wire  AXI_CONFIG_awready,
		input wire [AXI_CONFIG_DATA_WIDTH-1 : 0] AXI_CONFIG_wdata,
		input wire [(AXI_CONFIG_DATA_WIDTH/8)-1 : 0] AXI_CONFIG_wstrb,
		input wire  AXI_CONFIG_wvalid,
		output wire  AXI_CONFIG_wready,
		output wire [1 : 0] AXI_CONFIG_bresp,
		output wire  AXI_CONFIG_bvalid,
		input wire  AXI_CONFIG_bready,
		input wire [AXI_CONFIG_ADDR_WIDTH-1 : 0] AXI_CONFIG_araddr,
		input wire [2 : 0] AXI_CONFIG_arprot,
		input wire  AXI_CONFIG_arvalid,
		output wire  AXI_CONFIG_arready,
		output wire [AXI_CONFIG_DATA_WIDTH-1 : 0] AXI_CONFIG_rdata,
		output wire [1 : 0] AXI_CONFIG_rresp,
		output wire  AXI_CONFIG_rvalid,
		input wire  AXI_CONFIG_rready,

		// Ports of Axi Slave Bus Interface S_AXI_PT
		input wire [C_S_AXI_PT_ID_WIDTH-1 : 0] S_AXI_PT_awid,
		input wire [C_S_AXI_PT_ADDR_WIDTH-1 : 0] S_AXI_PT_awaddr,
		input wire [7 : 0] S_AXI_PT_awlen,
		input wire [2 : 0] S_AXI_PT_awsize,
		input wire [1 : 0] S_AXI_PT_awburst,
		input wire  S_AXI_PT_awlock,
		input wire [3 : 0] S_AXI_PT_awcache,
		input wire [2 : 0] S_AXI_PT_awprot,
		input wire [3 : 0] S_AXI_PT_awqos,
		input wire [3 : 0] S_AXI_PT_awregion,
		input wire [C_S_AXI_PT_AWUSER_WIDTH-1 : 0] S_AXI_PT_awuser,
		input wire  S_AXI_PT_awvalid,
		output wire  S_AXI_PT_awready,
		input wire [C_S_AXI_PT_DATA_WIDTH-1 : 0] S_AXI_PT_wdata,
		input wire [(C_S_AXI_PT_DATA_WIDTH/8)-1 : 0] S_AXI_PT_wstrb,
		input wire  S_AXI_PT_wlast,
		input wire [C_S_AXI_PT_WUSER_WIDTH-1 : 0] S_AXI_PT_wuser,
		input wire  S_AXI_PT_wvalid,
		output wire  S_AXI_PT_wready,
		output wire [C_S_AXI_PT_ID_WIDTH-1 : 0] S_AXI_PT_bid,
		output wire [1 : 0] S_AXI_PT_bresp,
		output wire [C_S_AXI_PT_BUSER_WIDTH-1 : 0] S_AXI_PT_buser,
		output wire  S_AXI_PT_bvalid,
		input wire  S_AXI_PT_bready,
		input wire [C_S_AXI_PT_ID_WIDTH-1 : 0] S_AXI_PT_arid,
		input wire [C_S_AXI_PT_ADDR_WIDTH-1 : 0] S_AXI_PT_araddr,
		input wire [7 : 0] S_AXI_PT_arlen,
		input wire [2 : 0] S_AXI_PT_arsize,
		input wire [1 : 0] S_AXI_PT_arburst,
		input wire  S_AXI_PT_arlock,
		input wire [3 : 0] S_AXI_PT_arcache,
		input wire [2 : 0] S_AXI_PT_arprot,
		input wire [3 : 0] S_AXI_PT_arqos,
		input wire [3 : 0] S_AXI_PT_arregion,
		input wire [C_S_AXI_PT_ARUSER_WIDTH-1 : 0] S_AXI_PT_aruser,
		input wire  S_AXI_PT_arvalid,
		output wire  S_AXI_PT_arready,
		output wire [C_S_AXI_PT_ID_WIDTH-1 : 0] S_AXI_PT_rid,
		output wire [C_S_AXI_PT_DATA_WIDTH-1 : 0] S_AXI_PT_rdata,
		output wire [1 : 0] S_AXI_PT_rresp,
		output wire  S_AXI_PT_rlast,
		output wire [C_S_AXI_PT_RUSER_WIDTH-1 : 0] S_AXI_PT_ruser,
		output wire  S_AXI_PT_rvalid,
		input wire  S_AXI_PT_rready,

		// Ports of Axi Master Bus Interface M_AXI_PT
		output wire [C_S_AXI_PT_ID_WIDTH-1 : 0] M_AXI_PT_awid,
		output wire [C_S_AXI_PT_ADDR_WIDTH-1 : 0] M_AXI_PT_awaddr,
		output wire [7 : 0] M_AXI_PT_awlen,
		output wire [2 : 0] M_AXI_PT_awsize,
		output wire [1 : 0] M_AXI_PT_awburst,
		output wire  M_AXI_PT_awlock,
		output wire [3 : 0] M_AXI_PT_awcache,
		output wire [2 : 0] M_AXI_PT_awprot,
		output wire [3 : 0] M_AXI_PT_awqos,
		output wire [C_S_AXI_PT_AWUSER_WIDTH-1 : 0] M_AXI_PT_awuser,
		output wire  M_AXI_PT_awvalid,
		input wire  M_AXI_PT_awready,
		output wire [C_S_AXI_PT_DATA_WIDTH-1 : 0] M_AXI_PT_wdata,
		output wire [C_S_AXI_PT_DATA_WIDTH/8-1 : 0] M_AXI_PT_wstrb,
		output wire  M_AXI_PT_wlast,
		output wire [C_S_AXI_PT_WUSER_WIDTH-1 : 0] M_AXI_PT_wuser,
		output wire  M_AXI_PT_wvalid,
		input wire  M_AXI_PT_wready,
		input wire [C_S_AXI_PT_ID_WIDTH-1 : 0] M_AXI_PT_bid,
		input wire [1 : 0] M_AXI_PT_bresp,
		input wire [C_S_AXI_PT_BUSER_WIDTH-1 : 0] M_AXI_PT_buser,
		input wire  M_AXI_PT_bvalid,
		output wire  M_AXI_PT_bready,
		output wire [C_S_AXI_PT_ID_WIDTH-1 : 0] M_AXI_PT_arid,
		output wire [C_S_AXI_PT_ADDR_WIDTH-1 : 0] M_AXI_PT_araddr,
		output wire [7 : 0] M_AXI_PT_arlen,
		output wire [2 : 0] M_AXI_PT_arsize,
		output wire [1 : 0] M_AXI_PT_arburst,
		output wire  M_AXI_PT_arlock,
		output wire [3 : 0] M_AXI_PT_arcache,
		output wire [2 : 0] M_AXI_PT_arprot,
		output wire [3 : 0] M_AXI_PT_arqos,
		output wire [C_S_AXI_PT_ARUSER_WIDTH-1 : 0] M_AXI_PT_aruser,
		output wire  M_AXI_PT_arvalid,
		input wire  M_AXI_PT_arready,
		input wire [C_S_AXI_PT_ID_WIDTH-1 : 0] M_AXI_PT_rid,
		input wire [C_S_AXI_PT_DATA_WIDTH-1 : 0] M_AXI_PT_rdata,
		input wire [1 : 0] M_AXI_PT_rresp,
		input wire  M_AXI_PT_rlast,
		input wire [C_S_AXI_PT_RUSER_WIDTH-1 : 0] M_AXI_PT_ruser,
		input wire  M_AXI_PT_rvalid,
		output wire  M_AXI_PT_rready
	);

	// Instantiation of Verilog compatabile SystemVerilog module  
	ProtectionUnit_v1_0_verilog #(
		.NUM_MEM_REGIONS(NUM_MEM_REGIONS),	
		.NUM_DOMAINS(NUM_DOMAINS),
		.AXI_CONFIG_DATA_WIDTH(AXI_CONFIG_DATA_WIDTH),
		.AXI_CONFIG_ADDR_WIDTH(AXI_CONFIG_ADDR_WIDTH),
		.AXI_PT_ID_WIDTH(C_S_AXI_PT_ID_WIDTH),
		.AXI_PT_DATA_WIDTH(C_S_AXI_PT_DATA_WIDTH),
		.AXI_PT_ADDR_WIDTH(C_S_AXI_PT_ADDR_WIDTH),
		.AXI_PT_AWUSER_WIDTH(C_S_AXI_PT_AWUSER_WIDTH),
		.AXI_PT_ARUSER_WIDTH(C_S_AXI_PT_ARUSER_WIDTH),
		.AXI_PT_WUSER_WIDTH(C_S_AXI_PT_WUSER_WIDTH),
		.AXI_PT_RUSER_WIDTH(C_S_AXI_PT_RUSER_WIDTH),
		.AXI_PT_BUSER_WIDTH(C_S_AXI_PT_BUSER_WIDTH),
		.AXI_PT_TARGET_SLAVE_BASE_ADDR(C_M_AXI_PT_TARGET_SLAVE_BASE_ADDR),
		.AXI_PT_BURST_LEN(C_S_AXI_PT_BURST_LEN),
		.MEM_REGION_0(MEM_REGION_0),
		.MEM_REGION_1(MEM_REGION_1),
		.MEM_REGION_2(MEM_REGION_2),
		.MEM_REGION_3(MEM_REGION_3),
		.MEM_REGION_4(MEM_REGION_4),
		.MEM_REGION_5(MEM_REGION_5),
		.MEM_REGION_6(MEM_REGION_6),
		.MEM_REGION_7(MEM_REGION_7),
		.MEM_REGION_8(MEM_REGION_8),
		.MEM_REGION_9(MEM_REGION_9),
		.MEM_REGION_10(MEM_REGION_10),
		.MEM_REGION_11(MEM_REGION_11),
		.MEM_REGION_12(MEM_REGION_12),
		.MEM_REGION_13(MEM_REGION_13),
		.MEM_REGION_14(MEM_REGION_14),
		.MEM_REGION_15(MEM_REGION_15),
		.MEM_REGION_0_LSB(MEM_REGION_0_LSB),
		.MEM_REGION_1_LSB(MEM_REGION_1_LSB),
		.MEM_REGION_2_LSB(MEM_REGION_2_LSB),
		.MEM_REGION_3_LSB(MEM_REGION_3_LSB),
		.MEM_REGION_4_LSB(MEM_REGION_4_LSB),
		.MEM_REGION_5_LSB(MEM_REGION_5_LSB),
		.MEM_REGION_6_LSB(MEM_REGION_6_LSB),
		.MEM_REGION_7_LSB(MEM_REGION_7_LSB),
		.MEM_REGION_8_LSB(MEM_REGION_8_LSB),
		.MEM_REGION_9_LSB(MEM_REGION_9_LSB),
		.MEM_REGION_10_LSB(MEM_REGION_10_LSB),
		.MEM_REGION_11_LSB(MEM_REGION_11_LSB),
		.MEM_REGION_12_LSB(MEM_REGION_12_LSB),
		.MEM_REGION_13_LSB(MEM_REGION_13_LSB),
		.MEM_REGION_14_LSB(MEM_REGION_14_LSB),
		.MEM_REGION_15_LSB(MEM_REGION_15_LSB),
		.DOMAIN_0_ID(DOMAIN_0_ID),
		.DOMAIN_1_ID(DOMAIN_1_ID),
		.DOMAIN_2_ID(DOMAIN_2_ID),
		.DOMAIN_3_ID(DOMAIN_3_ID),
		.DOMAIN_4_ID(DOMAIN_4_ID),
		.DOMAIN_5_ID(DOMAIN_5_ID),
		.DOMAIN_6_ID(DOMAIN_6_ID),
		.DOMAIN_7_ID(DOMAIN_7_ID),
		.DOMAIN_8_ID(DOMAIN_8_ID),
		.DOMAIN_9_ID(DOMAIN_9_ID),
		.DOMAIN_10_ID(DOMAIN_10_ID),
		.DOMAIN_11_ID(DOMAIN_11_ID),
		.DOMAIN_12_ID(DOMAIN_12_ID),
		.DOMAIN_13_ID(DOMAIN_13_ID),
		.DOMAIN_14_ID(DOMAIN_14_ID),
		.DOMAIN_15_ID(DOMAIN_15_ID),
		.DOMAIN_0_MASK(DOMAIN_0_MASK),
		.DOMAIN_1_MASK(DOMAIN_1_MASK),
		.DOMAIN_2_MASK(DOMAIN_2_MASK),
		.DOMAIN_3_MASK(DOMAIN_3_MASK),
		.DOMAIN_4_MASK(DOMAIN_4_MASK),
		.DOMAIN_5_MASK(DOMAIN_5_MASK),
		.DOMAIN_6_MASK(DOMAIN_6_MASK),
		.DOMAIN_7_MASK(DOMAIN_7_MASK),
		.DOMAIN_8_MASK(DOMAIN_8_MASK),
		.DOMAIN_9_MASK(DOMAIN_9_MASK),
		.DOMAIN_10_MASK(DOMAIN_10_MASK),
		.DOMAIN_11_MASK(DOMAIN_11_MASK),
		.DOMAIN_12_MASK(DOMAIN_12_MASK),
		.DOMAIN_13_MASK(DOMAIN_13_MASK),
		.DOMAIN_14_MASK(DOMAIN_14_MASK),
		.DOMAIN_15_MASK(DOMAIN_15_MASK)
	) ProtectionUnit_v1_0_verilog_inst (
		.aclk(aclk),
		.aresetn(aresetn),
		.AXI_CONFIG_awaddr(AXI_CONFIG_awaddr),
		.AXI_CONFIG_awprot(AXI_CONFIG_awprot),
		.AXI_CONFIG_awvalid(AXI_CONFIG_awvalid),
		.AXI_CONFIG_awready(AXI_CONFIG_awready),
		.AXI_CONFIG_wdata(AXI_CONFIG_wdata),
		.AXI_CONFIG_wstrb(AXI_CONFIG_wstrb),
		.AXI_CONFIG_wvalid(AXI_CONFIG_wvalid),
		.AXI_CONFIG_wready(AXI_CONFIG_wready),
		.AXI_CONFIG_bresp(AXI_CONFIG_bresp),
		.AXI_CONFIG_bvalid(AXI_CONFIG_bvalid),
		.AXI_CONFIG_bready(AXI_CONFIG_bready),
		.AXI_CONFIG_araddr(AXI_CONFIG_araddr),
		.AXI_CONFIG_arprot(AXI_CONFIG_arprot),
		.AXI_CONFIG_arvalid(AXI_CONFIG_arvalid),
		.AXI_CONFIG_arready(AXI_CONFIG_arready),
		.AXI_CONFIG_rdata(AXI_CONFIG_rdata),
		.AXI_CONFIG_rresp(AXI_CONFIG_rresp),
		.AXI_CONFIG_rvalid(AXI_CONFIG_rvalid),
		.AXI_CONFIG_rready(AXI_CONFIG_rready),
		.S_AXI_PT_awid(S_AXI_PT_awid),
		.S_AXI_PT_awaddr(S_AXI_PT_awaddr),
		.S_AXI_PT_awlen(S_AXI_PT_awlen),
		.S_AXI_PT_awsize(S_AXI_PT_awsize),
		.S_AXI_PT_awburst(S_AXI_PT_awburst),
		.S_AXI_PT_awlock(S_AXI_PT_awlock),
		.S_AXI_PT_awcache(S_AXI_PT_awcache),
		.S_AXI_PT_awprot(S_AXI_PT_awprot),
		.S_AXI_PT_awqos(S_AXI_PT_awqos),
		.S_AXI_PT_awregion(S_AXI_PT_awregion),
		.S_AXI_PT_awuser(S_AXI_PT_awuser),
		.S_AXI_PT_awvalid(S_AXI_PT_awvalid),
		.S_AXI_PT_awready(S_AXI_PT_awready),
		.S_AXI_PT_wdata(S_AXI_PT_wdata),
		.S_AXI_PT_wstrb(S_AXI_PT_wstrb),
		.S_AXI_PT_wlast(S_AXI_PT_wlast),
		.S_AXI_PT_wuser(S_AXI_PT_wuser),
		.S_AXI_PT_wvalid(S_AXI_PT_wvalid),
		.S_AXI_PT_wready(S_AXI_PT_wready),
		.S_AXI_PT_bid(S_AXI_PT_bid),
		.S_AXI_PT_bresp(S_AXI_PT_bresp),
		.S_AXI_PT_buser(S_AXI_PT_buser),
		.S_AXI_PT_bvalid(S_AXI_PT_bvalid),
		.S_AXI_PT_bready(S_AXI_PT_bready),
		.S_AXI_PT_arid(S_AXI_PT_arid),
		.S_AXI_PT_araddr(S_AXI_PT_araddr),
		.S_AXI_PT_arlen(S_AXI_PT_arlen),
		.S_AXI_PT_arsize(S_AXI_PT_arsize),
		.S_AXI_PT_arburst(S_AXI_PT_arburst),
		.S_AXI_PT_arlock(S_AXI_PT_arlock),
		.S_AXI_PT_arcache(S_AXI_PT_arcache),
		.S_AXI_PT_arprot(S_AXI_PT_arprot),
		.S_AXI_PT_arqos(S_AXI_PT_arqos),
		.S_AXI_PT_arregion(S_AXI_PT_arregion),
		.S_AXI_PT_aruser(S_AXI_PT_aruser),
		.S_AXI_PT_arvalid(S_AXI_PT_arvalid),
		.S_AXI_PT_arready(S_AXI_PT_arready),
		.S_AXI_PT_rid(S_AXI_PT_rid),
		.S_AXI_PT_rdata(S_AXI_PT_rdata),
		.S_AXI_PT_rresp(S_AXI_PT_rresp),
		.S_AXI_PT_rlast(S_AXI_PT_rlast),
		.S_AXI_PT_ruser(S_AXI_PT_ruser),
		.S_AXI_PT_rvalid(S_AXI_PT_rvalid),
		.S_AXI_PT_rready(S_AXI_PT_rready),
		.M_AXI_PT_awid(M_AXI_PT_awid),
		.M_AXI_PT_awaddr(M_AXI_PT_awaddr),
		.M_AXI_PT_awlen(M_AXI_PT_awlen),
		.M_AXI_PT_awsize(M_AXI_PT_awsize),
		.M_AXI_PT_awburst(M_AXI_PT_awburst),
		.M_AXI_PT_awlock(M_AXI_PT_awlock),
		.M_AXI_PT_awcache(M_AXI_PT_awcache),
		.M_AXI_PT_awprot(M_AXI_PT_awprot),
		.M_AXI_PT_awqos(M_AXI_PT_awqos),
		.M_AXI_PT_awuser(M_AXI_PT_awuser),
		.M_AXI_PT_awvalid(M_AXI_PT_awvalid),
		.M_AXI_PT_awready(M_AXI_PT_awready),
		.M_AXI_PT_wdata(M_AXI_PT_wdata),
		.M_AXI_PT_wstrb(M_AXI_PT_wstrb),
		.M_AXI_PT_wlast(M_AXI_PT_wlast),
		.M_AXI_PT_wuser(M_AXI_PT_wuser),
		.M_AXI_PT_wvalid(M_AXI_PT_wvalid),
		.M_AXI_PT_wready(M_AXI_PT_wready),
		.M_AXI_PT_bid(M_AXI_PT_bid),
		.M_AXI_PT_bresp(M_AXI_PT_bresp),
		.M_AXI_PT_buser(M_AXI_PT_buser),
		.M_AXI_PT_bvalid(M_AXI_PT_bvalid),
		.M_AXI_PT_bready(M_AXI_PT_bready),
		.M_AXI_PT_arid(M_AXI_PT_arid),
		.M_AXI_PT_araddr(M_AXI_PT_araddr),
		.M_AXI_PT_arlen(M_AXI_PT_arlen),
		.M_AXI_PT_arsize(M_AXI_PT_arsize),
		.M_AXI_PT_arburst(M_AXI_PT_arburst),
		.M_AXI_PT_arlock(M_AXI_PT_arlock),
		.M_AXI_PT_arcache(M_AXI_PT_arcache),
		.M_AXI_PT_arprot(M_AXI_PT_arprot),
		.M_AXI_PT_arqos(M_AXI_PT_arqos),
		.M_AXI_PT_aruser(M_AXI_PT_aruser),
		.M_AXI_PT_arvalid(M_AXI_PT_arvalid),
		.M_AXI_PT_arready(M_AXI_PT_arready),
		.M_AXI_PT_rid(M_AXI_PT_rid),
		.M_AXI_PT_rdata(M_AXI_PT_rdata),
		.M_AXI_PT_rresp(M_AXI_PT_rresp),
		.M_AXI_PT_rlast(M_AXI_PT_rlast),
		.M_AXI_PT_ruser(M_AXI_PT_ruser),
		.M_AXI_PT_rvalid(M_AXI_PT_rvalid),
		.M_AXI_PT_rready(M_AXI_PT_rready)
	);

	endmodule