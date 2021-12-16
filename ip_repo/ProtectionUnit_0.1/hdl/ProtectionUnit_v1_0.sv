
`timescale 1 ns / 1 ps

`include "axi/typedef.svh"
`include "axi/assign.svh"

	module ProtectionUnit_v1_0 #
	(
		// Users to add parameters here
		// TODO: add to wrapper
		parameter integer NUM_MEM_REGIONS	= 2,
		parameter integer NUM_DOMAINS		= 2,

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S_AXI_CONFIG
		parameter integer C_S_AXI_CONFIG_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_CONFIG_ADDR_WIDTH	= 8,

		// Parameters of Axi Slave Bus Interface S_AXI
		parameter integer C_S_AXI_ID_WIDTH		= 1,
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

	pu_pkg::policy_entry_t [NUM_MEM_REGIONS-1 :0][NUM_DOMAINS-1 :0] policy;

	// Instantiation of Axi Bus Interface S_AXI_CONFIG  
	ProtectionUnit_v1_0_S_AXI_CONFIG_intf # (
		.NumMemRegions (NUM_MEM_REGIONS),
		.NumDomains	   (NUM_DOMAINS),
		.AXI_ADDR_WIDTH(C_S_AXI_CONFIG_ADDR_WIDTH),
		.AXI_DATA_WIDTH(C_S_AXI_CONFIG_DATA_WIDTH)
	) ProtectionUnit_v1_0_S_AXI_CONFIG_inst (
		.clk_i(aclk),
		.rst_ni(aresetn),
		.slv(conf),
		.policy_o(policy)
	);

	logic aw_granted_d, aw_granted_q;
	logic ar_granted_d, ar_granted_q;

	always_ff @( posedge (aclk) or negedge (aresetn)) begin : latch_decisions
		if (!aresetn) begin
			aw_granted_q <= '0;
			ar_granted_q <= '0;
		end else begin
			aw_granted_q <= (slave.aw_ready && slave.aw_valid) ? aw_granted_d : aw_granted_q;
			ar_granted_q <= (slave.ar_ready && slave.ar_valid) ? ar_granted_d : ar_granted_q;
		end
	end

	PolicyCheck #(
		.NUM_MEM_REGIONS	( NUM_MEM_REGIONS	 ),
    	.NUM_DOMAINS		( NUM_DOMAINS		 ),
    	.ID_WIDTH			( C_S_AXI_ID_WIDTH	 ),
    	.ADDR_WIDTH			( C_M_AXI_ADDR_WIDTH )
	) PolicyCheck_aw_inst (
		.POLICY		( policy			),	
		.ID			( slave.aw_id 		),
		.ADDR		( slave.aw_addr 	),	
		.LEN		( slave.aw_len 		),	
		.SIZE		( slave.aw_size 	),	
		.READ_WRITE	( 1'b1 				),		
		.GRANTED	( aw_granted_d		)
	);

	PolicyCheck #(
		.NUM_MEM_REGIONS	( NUM_MEM_REGIONS	 ),
    	.NUM_DOMAINS		( NUM_DOMAINS		 ),
    	.ID_WIDTH			( C_S_AXI_ID_WIDTH	 ),
    	.ADDR_WIDTH			( C_M_AXI_ADDR_WIDTH )
	) PolicyCheck_ar_inst (
		.POLICY		( policy			),	
		.ID			( slave.ar_id 		),
		.ADDR		( slave.ar_addr 	),	
		.LEN		( slave.ar_len 		),	
		.SIZE		( slave.ar_size 	),	
		.READ_WRITE	( 1'b0 				),		
		.GRANTED	( ar_granted_d		)
	);

	AXI_BUS err_path();

	axi_demux_intf #(
		.AXI_ID_WIDTH(C_S_AXI_ID_WIDTH),
		.AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),
		.AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
		.AXI_USER_WIDTH(C_M_AXI_AWUSER_WIDTH),
		 // TODO: reconsider paramter choices below
		.NO_MST_PORTS(32'd2),
		.MAX_TRANS(32'd8),
		.AXI_LOOK_BITS(C_S_AXI_ID_WIDTH),
		.UNIQUE_IDS(1'b0),
		.FALL_THROUGH(1'b0),
		.SPILL_AW(1'b1),
		.SPILL_W(1'b0),
		.SPILL_B(1'b0),
		.SPILL_AR(1'b1),
		.SPILL_R(1'b0)		 
	) axi_demux_inst (
		.slv_aw_select_i(aw_granted_q),
		.slv_ar_select_i(ar_granted_q),
		.slv(slave),
		.mst('{err_path, master}),
		.clk_i(aclk),
		.rst_ni(aresetn)
	);

// 	module axi_demux_intf #(
//   parameter int unsigned AXI_ID_WIDTH     = 32'd0, // Synopsys DC requires default value for params
//   parameter int unsigned AXI_ADDR_WIDTH   = 32'd0,
//   parameter int unsigned AXI_DATA_WIDTH   = 32'd0,
//   parameter int unsigned AXI_USER_WIDTH   = 32'd0,
//   parameter int unsigned NO_MST_PORTS     = 32'd3,
//   parameter int unsigned MAX_TRANS        = 32'd8,
//   parameter int unsigned AXI_LOOK_BITS    = 32'd3,
//   parameter bit          UNIQUE_IDS       = 1'b0,
//   parameter bit          FALL_THROUGH     = 1'b0,
//   parameter bit          SPILL_AW         = 1'b1,
//   parameter bit          SPILL_W          = 1'b0,
//   parameter bit          SPILL_B          = 1'b0,
//   parameter bit          SPILL_AR         = 1'b1,
//   parameter bit          SPILL_R          = 1'b0,
//   // Dependent parameters, DO NOT OVERRIDE!
//   parameter int unsigned SELECT_WIDTH   = (NO_MST_PORTS > 32'd1) ? $clog2(NO_MST_PORTS) : 32'd1,
//   parameter type         select_t       = logic [SELECT_WIDTH-1:0] // MST port select type
// ) (
//   input  logic    clk_i,                 // Clock
//   input  logic    rst_ni,                // Asynchronous reset active low
//   input  logic    test_i,                // Testmode enable
//   input  select_t slv_aw_select_i,       // has to be stable, when aw_valid
//   input  select_t slv_ar_select_i,       // has to be stable, when ar_valid
//   AXI_BUS.Slave   slv,                   // slave port
//   AXI_BUS.Master  mst [NO_MST_PORTS-1:0] // master ports
// );
	
	

	axi_err_slv_intf #(
		.AxiIdWidth(C_S_AXI_ID_WIDTH),
		.AxiAddrWidth(C_S_AXI_ADDR_WIDTH),
		.AxiUserWidth(C_M_AXI_AWUSER_WIDTH),
		.Resp(axi_pkg::RESP_DECERR),
		.RespWidth(C_S_AXI_DATA_WIDTH),
		.RespData('0),
		.ATOPs(1'b0)
	) axi_err_slv_inst (
		.slv(err_path),
		.clk_i(aclk),
		.rst_ni(aresetn)
	);

	
// module axi_err_slv_intf #(
//     parameter int unsigned          AxiIdWidth   = 0,                    // AXI ID Width
//     parameter int unsigned          AxiAddrWidth = 0,                    // AXI Address Width
//     parameter int unsigned          AxiUserWidth = 0,                    // AXI User Width
//     parameter axi_pkg::resp_t       Resp         = axi_pkg::RESP_DECERR, // Error generated by this slave.
//     parameter int unsigned          RespWidth    = 32'd64,               // Data response width, gets zero extended or truncated to r.data.
//     parameter logic [RespWidth-1:0] RespData     = 64'hCA11AB1EBADCAB1E, // Hexvalue for data return value
//     parameter bit                   ATOPs        = 1'b1,                 // Activate support for ATOPs.  Set to 1 if this slave could ever get an atomic AXI transaction.
//     parameter int unsigned          MaxTrans     = 1                     // Maximum # of accepted transactions before stalling
//   ) (
//     input  logic  clk_i,   // Clock
//     input  logic  rst_ni,  // Asynchronous reset active low
//     input  logic  test_i,  // Testmode enable
//     // slave port
//     AXI_BUS.Slave slv
//   );


	endmodule


	module ProtectionUnit_v1_0_verilog #
	(
		// Parameters of Axi Slave Bus Interface S_AXI_CONFIG
		parameter integer C_S_AXI_CONFIG_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_CONFIG_ADDR_WIDTH	= 8,

		// Parameters of Axi Slave Bus Interface S_AXI
		parameter integer C_S_AXI_ID_WIDTH	= 2,
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

	assign conf.aw_addr =			s_axi_config_awaddr;	// input
	assign conf.aw_prot =			s_axi_config_awprot;	// input
	assign conf.aw_valid =			s_axi_config_awvalid;	// input
	assign s_axi_config_awready = 	conf.aw_ready;			// output

	assign conf.w_data =			s_axi_config_wdata;		// input
	assign conf.w_strb =			s_axi_config_wstrb;		// input
	assign conf.w_valid =			s_axi_config_wvalid;	// input
	assign s_axi_config_wready = 	conf.w_ready;			// output

	assign s_axi_config_bresp = 	conf.b_resp;			// output
	assign s_axi_config_bvalid = 	conf.b_valid;			// output
	assign conf.b_ready =			s_axi_config_bready;	// input
	
	assign conf.ar_addr =			s_axi_config_araddr;	// input
	assign conf.ar_prot =			s_axi_config_arprot;	// input
	assign conf.ar_valid =			s_axi_config_arvalid;	// input
	assign s_axi_config_arready = 	conf.ar_ready;			// output
	assign s_axi_config_rdata = 	conf.r_data;			// output
	assign s_axi_config_rresp = 	conf.r_resp;			// output
	assign s_axi_config_rvalid = 	conf.r_valid;			// output
	assign conf.r_ready =			s_axi_config_rready;	// input

	
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
	assign s_axi_awready = 		slave.aw_ready;	// output
	assign slave.w_data = 		s_axi_wdata;	// input
	assign slave.w_strb = 		s_axi_wstrb;	// input
	assign slave.w_last = 		s_axi_wlast;	// input
	assign slave.w_user = 		s_axi_wuser;	// input
	assign slave.w_valid = 		s_axi_wvalid;	// input
	assign s_axi_wready = 		slave.w_ready;	// output
	assign s_axi_bid = 			slave.b_id;		// output
	assign s_axi_bresp = 		slave.b_resp;	// output
	assign s_axi_buser = 		slave.b_user;	// output
	assign s_axi_bvalid = 		slave.b_valid;	// output
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
	assign s_axi_arready = 		slave.ar_ready;	// output
	assign s_axi_rid = 			slave.r_id;		// output
	assign s_axi_rdata = 		slave.r_data;	// output
	assign s_axi_rresp = 		slave.r_resp;	// output
	assign s_axi_rlast = 		slave.r_last;	// output
	assign s_axi_ruser = 		slave.r_user;	// output
	assign s_axi_rvalid = 		slave.r_valid;	// output
	assign slave.r_ready = 		s_axi_rready;	// input

	// Create and map Axi Master Bus Interface M_AXI

	AXI_BUS #(
		.AXI_ADDR_WIDTH(C_M_AXI_ADDR_WIDTH),
		.AXI_DATA_WIDTH(C_M_AXI_DATA_WIDTH)
	) master();

	assign m_axi_awid = 		master.aw_id;		// output
	assign m_axi_awaddr = 		master.aw_addr;		// output
	assign m_axi_awlen = 		master.aw_len;		// output
	assign m_axi_awsize = 		master.aw_size;		// output
	assign m_axi_awburst = 		master.aw_burst;	// output
	assign m_axi_awlock = 		master.aw_lock;		// output
	assign m_axi_awcache = 		master.aw_cache;	// output
	assign m_axi_awprot = 		master.aw_prot;		// output
	assign m_axi_awqos = 		master.aw_qos;		// output
	assign m_axi_awuser = 		master.aw_user;		// output
	assign m_axi_awvalid = 		master.aw_valid;	// output
	assign master.aw_ready =	m_axi_awready; 		// input
	assign m_axi_wdata = 		master.w_data;		// output
	assign m_axi_wstrb = 		master.w_strb;		// output
	assign m_axi_wlast = 		master.w_last;		// output
	assign m_axi_wuser = 		master.w_user;		// output
	assign m_axi_wvalid = 		master.w_valid;		// output
	assign master.w_ready = 	m_axi_wready; 		// input
	assign master.b_id = 		m_axi_bid; 			// input
	assign master.b_resp = 		m_axi_bresp; 		// input
	assign master.b_user = 		m_axi_buser; 		// input
	assign master.b_valid = 	m_axi_bvalid; 		// input
	assign m_axi_bready = 		master.b_ready;		// output
	assign m_axi_arid = 		master.ar_id;		// output
	assign m_axi_araddr = 		master.ar_addr;		// output
	assign m_axi_arlen = 		master.ar_len;		// output
	assign m_axi_arsize = 		master.ar_size;		// output
	assign m_axi_arburst = 		master.ar_burst;	// output
	assign m_axi_arlock = 		master.ar_lock;		// output
	assign m_axi_arcache = 		master.ar_cache;	// output
	assign m_axi_arprot = 		master.ar_prot;		// output
	assign m_axi_arqos = 		master.ar_qos;		// output
	assign m_axi_aruser = 		master.ar_user;		// output
	assign m_axi_arvalid = 		master.ar_valid;	// output
	assign master.ar_ready = 	m_axi_arready; 		// input
	assign master.r_id = 		m_axi_rid; 			// input
	assign master.r_data = 		m_axi_rdata; 		// input
	assign master.r_resp = 		m_axi_rresp; 		// input
	assign master.r_last = 		m_axi_rlast; 		// input
	assign master.r_user = 		m_axi_ruser; 		// input
	assign master.r_valid = 	m_axi_rvalid; 		// input
	assign m_axi_rready = 		master.r_ready;		// output
	
	ProtectionUnit_v1_0 ProtectionUnit_v1_0_inst(
	   .aclk,
	   .aresetn,
	   .conf(conf),
	   .slave(slave),
	   .master(master)
	);

endmodule
