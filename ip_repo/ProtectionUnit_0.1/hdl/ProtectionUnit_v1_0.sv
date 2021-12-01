
`timescale 1 ns / 1 ps

`include "../../axi/include/axi/typedef.svh"
`include "../../axi/include/axi/assign.svh"
`include "../../axi/src/axi_intf.sv"

	module ProtectionUnit_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S_AXI_CONFIG
		parameter integer C_S_AXI_CONFIG_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_CONFIG_ADDR_WIDTH	= 8,

		// Parameters of Axi Slave Bus Interface S_AXI
		parameter integer C_S_AXI_ID_WIDTH	= 1,
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_ADDR_WIDTH	= 6,
		parameter integer C_S_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_S_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_S_AXI_WUSER_WIDTH	= 0,
		parameter integer C_S_AXI_RUSER_WIDTH	= 0,
		parameter integer C_S_AXI_BUSER_WIDTH	= 0,

		// Parameters of Axi Master Bus Interface M_AXI
		parameter  C_M_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_M_AXI_BURST_LEN	= 16,
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)
	(
		input wire aclk,
		input wire aresetn,
		AXI_LITE.Slave conf,
		AXI_BUS.Slave slave,
		AXI_BUS.Master master
	);

// Instantiation of Axi Bus Interface S_AXI_CONFIG  
	ProtectionUnit_v1_0_S_AXI_CONFIG_intf # (
		.AXI_ADDR_WIDTH(C_S_AXI_CONFIG_ADDR_WIDTH),
		.AXI_DATA_WIDTH(C_S_AXI_CONFIG_DATA_WIDTH)
	) ProtectionUnit_v1_0_S_AXI_CONFIG_inst (
		.clk_i(aclk),
		.rst_ni(aresetn),
		.slv(conf)
	);
	

// Instantiation of Axi Bus Interface S_AXI
	ProtectionUnit_v1_0_S_AXI # ( 
		.C_S_AXI_ID_WIDTH(C_S_AXI_ID_WIDTH),
		.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),
		.C_S_AXI_AWUSER_WIDTH(C_S_AXI_AWUSER_WIDTH),
		.C_S_AXI_ARUSER_WIDTH(C_S_AXI_ARUSER_WIDTH),
		.C_S_AXI_WUSER_WIDTH(C_S_AXI_WUSER_WIDTH),
		.C_S_AXI_RUSER_WIDTH(C_S_AXI_RUSER_WIDTH),
		.C_S_AXI_BUSER_WIDTH(C_S_AXI_BUSER_WIDTH)
	) ProtectionUnit_v1_0_S_AXI_inst (
		.S_AXI_ACLK(s_axi_aclk),
		.S_AXI_ARESETN(s_axi_aresetn),
		.S_AXI_AWID(s_axi_awid),
		.S_AXI_AWADDR(s_axi_awaddr),
		.S_AXI_AWLEN(s_axi_awlen),
		.S_AXI_AWSIZE(s_axi_awsize),
		.S_AXI_AWBURST(s_axi_awburst),
		.S_AXI_AWLOCK(s_axi_awlock),
		.S_AXI_AWCACHE(s_axi_awcache),
		.S_AXI_AWPROT(s_axi_awprot),
		.S_AXI_AWQOS(s_axi_awqos),
		.S_AXI_AWREGION(s_axi_awregion),
		.S_AXI_AWUSER(s_axi_awuser),
		.S_AXI_AWVALID(s_axi_awvalid),
		.S_AXI_AWREADY(s_axi_awready),
		.S_AXI_WDATA(s_axi_wdata),
		.S_AXI_WSTRB(s_axi_wstrb),
		.S_AXI_WLAST(s_axi_wlast),
		.S_AXI_WUSER(s_axi_wuser),
		.S_AXI_WVALID(s_axi_wvalid),
		.S_AXI_WREADY(s_axi_wready),
		.S_AXI_BID(s_axi_bid),
		.S_AXI_BRESP(s_axi_bresp),
		.S_AXI_BUSER(s_axi_buser),
		.S_AXI_BVALID(s_axi_bvalid),
		.S_AXI_BREADY(s_axi_bready),
		.S_AXI_ARID(s_axi_arid),
		.S_AXI_ARADDR(s_axi_araddr),
		.S_AXI_ARLEN(s_axi_arlen),
		.S_AXI_ARSIZE(s_axi_arsize),
		.S_AXI_ARBURST(s_axi_arburst),
		.S_AXI_ARLOCK(s_axi_arlock),
		.S_AXI_ARCACHE(s_axi_arcache),
		.S_AXI_ARPROT(s_axi_arprot),
		.S_AXI_ARQOS(s_axi_arqos),
		.S_AXI_ARREGION(s_axi_arregion),
		.S_AXI_ARUSER(s_axi_aruser),
		.S_AXI_ARVALID(s_axi_arvalid),
		.S_AXI_ARREADY(s_axi_arready),
		.S_AXI_RID(s_axi_rid),
		.S_AXI_RDATA(s_axi_rdata),
		.S_AXI_RRESP(s_axi_rresp),
		.S_AXI_RLAST(s_axi_rlast),
		.S_AXI_RUSER(s_axi_ruser),
		.S_AXI_RVALID(s_axi_rvalid),
		.S_AXI_RREADY(s_axi_rready)
	);

// Instantiation of Axi Bus Interface M_AXI
	ProtectionUnit_v1_0_M_AXI # ( 
		.C_M_TARGET_SLAVE_BASE_ADDR(C_M_AXI_TARGET_SLAVE_BASE_ADDR),
		.C_M_AXI_BURST_LEN(C_M_AXI_BURST_LEN),
		.C_M_AXI_ID_WIDTH(C_M_AXI_ID_WIDTH),
		.C_M_AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH),
		.C_M_AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH),
		.C_M_AXI_AWUSER_WIDTH(C_M_AXI_AWUSER_WIDTH),
		.C_M_AXI_ARUSER_WIDTH(C_M_AXI_ARUSER_WIDTH),
		.C_M_AXI_WUSER_WIDTH(C_M_AXI_WUSER_WIDTH),
		.C_M_AXI_RUSER_WIDTH(C_M_AXI_RUSER_WIDTH),
		.C_M_AXI_BUSER_WIDTH(C_M_AXI_BUSER_WIDTH)
	) ProtectionUnit_v1_0_M_AXI_inst (
		.INIT_AXI_TXN(m_axi_init_axi_txn),
		.TXN_DONE(m_axi_txn_done),
		.ERROR(m_axi_error),
		.M_AXI_ACLK(m_axi_aclk),
		.M_AXI_ARESETN(m_axi_aresetn),
		.M_AXI_AWID(m_axi_awid),
		.M_AXI_AWADDR(m_axi_awaddr),
		.M_AXI_AWLEN(m_axi_awlen),
		.M_AXI_AWSIZE(m_axi_awsize),
		.M_AXI_AWBURST(m_axi_awburst),
		.M_AXI_AWLOCK(m_axi_awlock),
		.M_AXI_AWCACHE(m_axi_awcache),
		.M_AXI_AWPROT(m_axi_awprot),
		.M_AXI_AWQOS(m_axi_awqos),
		.M_AXI_AWUSER(m_axi_awuser),
		.M_AXI_AWVALID(m_axi_awvalid),
		.M_AXI_AWREADY(m_axi_awready),
		.M_AXI_WDATA(m_axi_wdata),
		.M_AXI_WSTRB(m_axi_wstrb),
		.M_AXI_WLAST(m_axi_wlast),
		.M_AXI_WUSER(m_axi_wuser),
		.M_AXI_WVALID(m_axi_wvalid),
		.M_AXI_WREADY(m_axi_wready),
		.M_AXI_BID(m_axi_bid),
		.M_AXI_BRESP(m_axi_bresp),
		.M_AXI_BUSER(m_axi_buser),
		.M_AXI_BVALID(m_axi_bvalid),
		.M_AXI_BREADY(m_axi_bready),
		.M_AXI_ARID(m_axi_arid),
		.M_AXI_ARADDR(m_axi_araddr),
		.M_AXI_ARLEN(m_axi_arlen),
		.M_AXI_ARSIZE(m_axi_arsize),
		.M_AXI_ARBURST(m_axi_arburst),
		.M_AXI_ARLOCK(m_axi_arlock),
		.M_AXI_ARCACHE(m_axi_arcache),
		.M_AXI_ARPROT(m_axi_arprot),
		.M_AXI_ARQOS(m_axi_arqos),
		.M_AXI_ARUSER(m_axi_aruser),
		.M_AXI_ARVALID(m_axi_arvalid),
		.M_AXI_ARREADY(m_axi_arready),
		.M_AXI_RID(m_axi_rid),
		.M_AXI_RDATA(m_axi_rdata),
		.M_AXI_RRESP(m_axi_rresp),
		.M_AXI_RLAST(m_axi_rlast),
		.M_AXI_RUSER(m_axi_ruser),
		.M_AXI_RVALID(m_axi_rvalid),
		.M_AXI_RREADY(m_axi_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule


	module ProtectionUnit_v1_0_verilog #
	(
		// Parameters of Axi Slave Bus Interface S_AXI_CONFIG
		parameter integer C_S_AXI_CONFIG_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_CONFIG_ADDR_WIDTH	= 8,

		// Parameters of Axi Slave Bus Interface S_AXI
		parameter integer C_S_AXI_ID_WIDTH	= 1,
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_ADDR_WIDTH	= 6,
		parameter integer C_S_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_S_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_S_AXI_WUSER_WIDTH	= 0,
		parameter integer C_S_AXI_RUSER_WIDTH	= 0,
		parameter integer C_S_AXI_BUSER_WIDTH	= 0,

		// Parameters of Axi Master Bus Interface M_AXI
		parameter  C_M_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_M_AXI_BURST_LEN	= 16,
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)
	(
		input wire  aclk,
		input wire  aresetn,

		// Ports of Axi Slave Bus Interface S_AXI_CONFIG
		input wire [C_S_AXI_CONFIG_ADDR_WIDTH-1 : 0] 	 s_axi_config_awaddr,
		input wire [2 : 0] 								 s_axi_config_awprot,
		input wire  									 s_axi_config_awvalid,
		output wire  									 s_axi_config_awready,
		input wire [C_S_AXI_CONFIG_DATA_WIDTH-1 : 0] 	 s_axi_config_wdata,
		input wire [(C_S_AXI_CONFIG_DATA_WIDTH/8)-1 : 0] s_axi_config_wstrb,
		input wire  									 s_axi_config_wvalid,
		output wire  									 s_axi_config_wready,
		output wire [1 : 0] 							 s_axi_config_bresp,
		output wire  									 s_axi_config_bvalid,
		input wire  									 s_axi_config_bready,
		input wire [C_S_AXI_CONFIG_ADDR_WIDTH-1 : 0] 	 s_axi_config_araddr,
		input wire [2 : 0] 								 s_axi_config_arprot,
		input wire  									 s_axi_config_arvalid,
		output wire  									 s_axi_config_arready,
		output wire [C_S_AXI_CONFIG_DATA_WIDTH-1 : 0] 	 s_axi_config_rdata,
		output wire [1 : 0] 							 s_axi_config_rresp,
		output wire  									 s_axi_config_rvalid,
		input wire  									 s_axi_config_rready,

		// Ports of Axi Slave Bus Interface S_AXI
		input wire [C_S_AXI_ID_WIDTH-1 : 0] 		s_axi_awid,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] 		s_axi_awaddr,
		input wire [7 : 0] 							s_axi_awlen,
		input wire [2 : 0] 							s_axi_awsize,
		input wire [1 : 0] 							s_axi_awburst,
		input wire  								s_axi_awlock,
		input wire [3 : 0] 							s_axi_awcache,
		input wire [2 : 0] 							s_axi_awprot,
		input wire [3 : 0] 							s_axi_awqos,
		input wire [3 : 0] 							s_axi_awregion,
		input wire [C_S_AXI_AWUSER_WIDTH-1 : 0] 	s_axi_awuser,
		input wire  								s_axi_awvalid,
		output wire  								s_axi_awready,
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] 		s_axi_wdata,
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] 	s_axi_wstrb,
		input wire  								s_axi_wlast,
		input wire [C_S_AXI_WUSER_WIDTH-1 : 0] 		s_axi_wuser,
		input wire  								s_axi_wvalid,
		output wire  								s_axi_wready,
		output wire [C_S_AXI_ID_WIDTH-1 : 0] 		s_axi_bid,
		output wire [1 : 0] 						s_axi_bresp,
		output wire [C_S_AXI_BUSER_WIDTH-1 : 0] 	s_axi_buser,
		output wire  								s_axi_bvalid,
		input wire  								s_axi_bready,
		input wire [C_S_AXI_ID_WIDTH-1 : 0] 		s_axi_arid,
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] 		s_axi_araddr,
		input wire [7 : 0] 							s_axi_arlen,
		input wire [2 : 0] 							s_axi_arsize,
		input wire [1 : 0] 							s_axi_arburst,
		input wire  								s_axi_arlock,
		input wire [3 : 0] 							s_axi_arcache,
		input wire [2 : 0] 							s_axi_arprot,
		input wire [3 : 0] 							s_axi_arqos,
		input wire [3 : 0] 							s_axi_arregion,
		input wire [C_S_AXI_ARUSER_WIDTH-1 : 0] 	s_axi_aruser,
		input wire  								s_axi_arvalid,
		output wire  								s_axi_arready,
		output wire [C_S_AXI_ID_WIDTH-1 : 0] 		s_axi_rid,
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] 		s_axi_rdata,
		output wire [1 : 0] 						s_axi_rresp,
		output wire  								s_axi_rlast,
		output wire [C_S_AXI_RUSER_WIDTH-1 : 0] 	s_axi_ruser,
		output wire  								s_axi_rvalid,
		input wire  								s_axi_rready,

		// Ports of Axi Master Bus Interface M_AXI
		output wire [C_M_AXI_ID_WIDTH-1 : 0] 		m_axi_awid,
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] 		m_axi_awaddr,
		output wire [7 : 0] 						m_axi_awlen,
		output wire [2 : 0] 						m_axi_awsize,
		output wire [1 : 0] 						m_axi_awburst,
		output wire  								m_axi_awlock,
		output wire [3 : 0] 						m_axi_awcache,
		output wire [2 : 0] 						m_axi_awprot,
		output wire [3 : 0] 						m_axi_awqos,
		output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] 	m_axi_awuser,
		output wire  								m_axi_awvalid,
		input wire  								m_axi_awready,
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] 		m_axi_wdata,
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] 	m_axi_wstrb,
		output wire  								m_axi_wlast,
		output wire [C_M_AXI_WUSER_WIDTH-1 : 0] 	m_axi_wuser,
		output wire  								m_axi_wvalid,
		input wire  								m_axi_wready,
		input wire [C_M_AXI_ID_WIDTH-1 : 0] 		m_axi_bid,
		input wire [1 : 0] 							m_axi_bresp,
		input wire [C_M_AXI_BUSER_WIDTH-1 : 0] 		m_axi_buser,
		input wire  								m_axi_bvalid,
		output wire  								m_axi_bready,
		output wire [C_M_AXI_ID_WIDTH-1 : 0] 		m_axi_arid,
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] 		m_axi_araddr,
		output wire [7 : 0] 						m_axi_arlen,
		output wire [2 : 0] 						m_axi_arsize,
		output wire [1 : 0] 						m_axi_arburst,
		output wire  								m_axi_arlock,
		output wire [3 : 0] 						m_axi_arcache,
		output wire [2 : 0] 						m_axi_arprot,
		output wire [3 : 0] 						m_axi_arqos,
		output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] 	m_axi_aruser,
		output wire  								m_axi_arvalid,
		input wire  								m_axi_arready,
		input wire [C_M_AXI_ID_WIDTH-1 : 0] 		m_axi_rid,
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] 		m_axi_rdata,
		input wire [1 : 0] 							m_axi_rresp,
		input wire  								m_axi_rlast,
		input wire [C_M_AXI_RUSER_WIDTH-1 : 0] 		m_axi_ruser,
		input wire  								m_axi_rvalid,
		output wire  								m_axi_rready
	);
	
	// Ports of Axi Slave Bus Interface S_AXI_CONFIG

	AXI_LITE #(
		.AXI_ADDR_WIDTH(C_S_AXI_CONFIG_ADDR_WIDTH),
		.AXI_DATA_WIDTH(C_S_AXI_CONFIG_DATA_WIDTH)
	) conf();

	assign conf.aw_addr =		s_axi_config_awaddr;		// input
	assign conf.aw_prot =		s_axi_config_awprot;		// input
	assign conf.aw_valid =		s_axi_config_awvalid;		// input
	assign conf.aw_ready =		s_axi_config_awready;		// output
	
	assign conf.w_data =		s_axi_config_wdata;			// input
	assign conf.w_strb =		s_axi_config_wstrb;			// input
	assign conf.w_valid =		s_axi_config_wvalid;		// input
	assign conf.w_ready =		s_axi_config_wready;		// output
	
	assign conf.b_resp =		s_axi_config_bresp;			// output
	assign conf.b_valid =		s_axi_config_bvalid;		// output
	assign conf.b_ready =		s_axi_config_bready;		// input
	
	assign conf.ar_addr =		s_axi_config_araddr;		// input
	assign conf.ar_prot =		s_axi_config_arprot;		// input
	assign conf.ar_valid =		s_axi_config_arvalid;		// input
	assign conf.ar_ready =		s_axi_config_arready;		// output
	
	assign conf.r_data =		s_axi_config_rdata;			// output
	assign conf.r_resp =		s_axi_config_rresp;			// output
	assign conf.r_valid =		s_axi_config_rvalid;		// output
	assign conf.r_ready =		s_axi_config_rready;		// input

	
	// Create and map Axi Slave Bus Interface S_AXI

	AXI_BUS #(
		.AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),
		.AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH)
	) slave();
	
	assign slave.aw_id = 		s_axi_awid;		// input
	assign slave.aw_addr = 		s_axi_awaddr;	// input
	assign slave.aw_len = 		s_axi_awlen;	// input
	assign slave.aw_size = 		s_axi_awsize;	// input
	assign slave.aw_burst = 	s_axi_awburst;	// input
	assign slave.aw_lock = 		s_axi_awlock;	// input
	assign slave.aw_cache = 	s_axi_awcache;	// input
	assign slave.aw_prot = 		s_axi_awprot;	// input
	assign slave.aw_qos = 		s_axi_awqos;	// input
	assign slave.aw_region = 	s_axi_awregion;	// input
	assign slave.aw_user = 		s_axi_awuser;	// input
	assign slave.aw_valid = 	s_axi_awvalid;	// input
	assign slave.aw_ready = 	s_axi_awready;	// output
	assign slave.w_data = 		s_axi_wdata;	// input
	assign slave.w_strb = 		s_axi_wstrb;	// input
	assign slave.w_last = 		s_axi_wlast;	// input
	assign slave.w_user = 		s_axi_wuser;	// input
	assign slave.w_valid = 		s_axi_wvalid;	// input
	assign slave.w_ready = 		s_axi_wready;	// output
	assign slave.b_id = 		s_axi_bid;		// output
	assign slave.b_resp = 		s_axi_bresp;	// output
	assign slave.b_user = 		s_axi_buser;	// output
	assign slave.b_valid = 		s_axi_bvalid;	// output
	assign slave.b_ready = 		s_axi_bready;	// input
	assign slave.ar_id = 		s_axi_arid;		// input
	assign slave.ar_addr = 		s_axi_araddr;	// input
	assign slave.ar_len = 		s_axi_arlen;	// input
	assign slave.ar_size = 		s_axi_arsize;	// input
	assign slave.ar_burst = 	s_axi_arburst;	// input
	assign slave.ar_lock = 		s_axi_arlock;	// input
	assign slave.ar_cache = 	s_axi_arcache;	// input
	assign slave.ar_prot = 		s_axi_arprot;	// input
	assign slave.ar_qos = 		s_axi_arqos;	// input
	assign slave.ar_region = 	s_axi_arregion;	// input
	assign slave.ar_user = 		s_axi_aruser;	// input
	assign slave.ar_valid = 	s_axi_arvalid;	// input
	assign slave.ar_ready = 	s_axi_arready;	// output
	assign slave.r_id = 		s_axi_rid;		// output
	assign slave.r_data = 		s_axi_rdata;	// output
	assign slave.r_resp = 		s_axi_rresp;	// output
	assign slave.r_last = 		s_axi_rlast;	// output
	assign slave.r_user = 		s_axi_ruser;	// output
	assign slave.r_valid = 		s_axi_rvalid;	// output
	assign slave.r_ready = 		s_axi_rready;	// input

	// Create and map Axi Master Bus Interface M_AXI

	AXI_BUS #(
		.AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH),
		.AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH)
	) master();

	assign master.aw_id = m_axi_awid; 			// output
	assign master.aw_addr = m_axi_awaddr; 		// output
	assign master.aw_len = m_axi_awlen; 		// output
	assign master.aw_size = m_axi_awsize; 		// output
	assign master.aw_burst = m_axi_awburst; 	// output
	assign master.aw_lock = m_axi_awlock; 		// output
	assign master.aw_cache = m_axi_awcache; 	// output
	assign master.aw_prot = m_axi_awprot; 		// output
	assign master.aw_qos = m_axi_awqos; 		// output
	assign master.aw_user = m_axi_awuser; 		// output
	assign master.aw_valid = m_axi_awvalid; 	// output
	assign master.aw_ready = m_axi_awready; 	// input
	assign master.w_data = m_axi_wdata; 		// output
	assign master.w_strb = m_axi_wstrb; 		// output
	assign master.w_last = m_axi_wlast; 		// output
	assign master.w_user = m_axi_wuser; 		// output
	assign master.w_valid = m_axi_wvalid; 		// output
	assign master.w_ready = m_axi_wready; 		// input
	assign master.b_id = m_axi_bid; 			// input
	assign master.b_resp = m_axi_bresp; 		// input
	assign master.b_user = m_axi_buser; 		// input
	assign master.b_valid = m_axi_bvalid; 		// input
	assign master.b_ready = m_axi_bready; 		// output
	assign master.ar_id = m_axi_arid; 			// output
	assign master.ar_addr = m_axi_araddr; 		// output
	assign master.ar_len = m_axi_arlen; 		// output
	assign master.ar_size = m_axi_arsize; 		// output
	assign master.ar_burst = m_axi_arburst; 	// output
	assign master.ar_lock = m_axi_arlock; 		// output
	assign master.ar_cache = m_axi_arcache; 	// output
	assign master.ar_prot = m_axi_arprot; 		// output
	assign master.ar_qos = m_axi_arqos; 		// output
	assign master.ar_user = m_axi_aruser; 		// output
	assign master.ar_valid = m_axi_arvalid; 	// output
	assign master.ar_ready = m_axi_arready; 	// input
	assign master.r_id = m_axi_rid; 			// input
	assign master.r_data = m_axi_rdata; 		// input
	assign master.r_resp = m_axi_rresp; 		// input
	assign master.r_last = m_axi_rlast; 		// input
	assign master.r_user = m_axi_ruser; 		// input
	assign master.r_valid = m_axi_rvalid; 		// input
	assign master.r_ready = m_axi_rready;		// output
	
	ProtectionUnit_v1_0 ProtectionUnit_v1_0_inst(
	   .aclk,
	   .aresetn,
	   .conf(conf.Slave),
	   .slave(slave),
	   .master(master)
	);

//  	req_lite_t  axi_lite_req;
//  	resp_lite_t axi_lite_resp;

//  	`AXI_LITE_ASSIGN_TO_REQ(axi_lite_req, slv)
//  	`AXI_LITE_ASSIGN_FROM_RESP(slv, axi_lite_resp)


	//TODO: map ports
endmodule
