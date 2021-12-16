
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


		// Parameters of Axi Slave Bus Interface AXI_CONFIG
		parameter integer AXI_CONFIG_DATA_WIDTH	= 32,
		parameter integer AXI_CONFIG_ADDR_WIDTH	= 8,

		// Parameters of Axi Pass Through AXI_PT
		parameter  AXI_PT_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer AXI_PT_BURST_LEN	= 16,
		parameter integer AXI_PT_ID_WIDTH		= 1,
		parameter integer AXI_PT_DATA_WIDTH	= 32,
		parameter integer AXI_PT_ADDR_WIDTH	= 6,
		parameter integer AXI_PT_AWUSER_WIDTH	= 0,
		parameter integer AXI_PT_ARUSER_WIDTH	= 0,
		parameter integer AXI_PT_WUSER_WIDTH	= 0,
		parameter integer AXI_PT_RUSER_WIDTH	= 0,
		parameter integer AXI_PT_BUSER_WIDTH	= 0
	)
	(
		input wire aclk,
		input wire aresetn,
		AXI_LITE.Slave conf,
		AXI_BUS.Slave slave,
		AXI_BUS.Master master
	);

	pu_pkg::policy_entry_t [NUM_MEM_REGIONS-1 :0][NUM_DOMAINS-1 :0] policy;

	// Instantiation of Axi Bus Interface AXI_CONFIG  
	ProtectionUnit_v1_0_AXI_CONFIG_intf # (
		.NumMemRegions (NUM_MEM_REGIONS),
		.NumDomains	   (NUM_DOMAINS),
		.AXI_ADDR_WIDTH(AXI_CONFIG_ADDR_WIDTH),
		.AXI_DATA_WIDTH(AXI_CONFIG_DATA_WIDTH)
	) ProtectionUnit_v1_0_AXI_CONFIG_inst (
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
    	.ID_WIDTH			( AXI_PT_ID_WIDTH	 ),
    	.ADDR_WIDTH			( AXI_PT_ADDR_WIDTH )
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
    	.ID_WIDTH			( AXI_PT_ID_WIDTH	 ),
    	.ADDR_WIDTH			( AXI_PT_ADDR_WIDTH )
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
		.AXI_ID_WIDTH(AXI_PT_ID_WIDTH),
		.AXI_ADDR_WIDTH(AXI_PT_ADDR_WIDTH),
		.AXI_DATA_WIDTH(AXI_PT_DATA_WIDTH),
		.AXI_USER_WIDTH(AXI_PT_AWUSER_WIDTH),
		 // TODO: reconsider paramter choices below
		.NO_MST_PORTS(32'd2),
		.MAX_TRANS(32'd8),
		.AXI_LOOK_BITS(AXI_PT_ID_WIDTH),
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
		.AxiIdWidth(AXI_PT_ID_WIDTH),
		.AxiAddrWidth(AXI_PT_ADDR_WIDTH),
		.AxiUserWidth(AXI_PT_AWUSER_WIDTH),
		.Resp(axi_pkg::RESP_DECERR),
		.RespWidth(AXI_PT_DATA_WIDTH),
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
		// Parameters of Axi Slave Bus Interface AXI_CONFIG
		parameter integer AXI_CONFIG_DATA_WIDTH	= 32,
		parameter integer AXI_CONFIG_ADDR_WIDTH	= 8,

		// Parameters of Axi Pass Through AXI_PT
		parameter  AXI_PT_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer AXI_PT_BURST_LEN	= 16,
		parameter integer AXI_PT_ID_WIDTH	= 2,
		parameter integer AXI_PT_DATA_WIDTH	= 32,
		parameter integer AXI_PT_ADDR_WIDTH	= 6,
		parameter integer AXI_PT_AWUSER_WIDTH	= 0,
		parameter integer AXI_PT_ARUSER_WIDTH	= 0,
		parameter integer AXI_PT_WUSER_WIDTH	= 0,
		parameter integer AXI_PT_RUSER_WIDTH	= 0,
		parameter integer AXI_PT_BUSER_WIDTH	= 0
	)
	(
		input wire  aclk,
		input wire  aresetn,

		// Ports of Axi Slave Bus Interface AXI_CONFIG
		input wire [AXI_CONFIG_ADDR_WIDTH-1 : 0] 	 	AXI_CONFIG_awaddr,
		input wire [2 : 0] 								AXI_CONFIG_awprot,
		input wire  									AXI_CONFIG_awvalid,
		output wire  									AXI_CONFIG_awready,
		input wire [AXI_CONFIG_DATA_WIDTH-1 : 0] 	 	AXI_CONFIG_wdata,
		input wire [(AXI_CONFIG_DATA_WIDTH/8)-1 : 0] 	AXI_CONFIG_wstrb,
		input wire  									AXI_CONFIG_wvalid,
		output wire  									AXI_CONFIG_wready,
		output wire [1 : 0] 							AXI_CONFIG_bresp,
		output wire  									AXI_CONFIG_bvalid,
		input wire  									AXI_CONFIG_bready,
		input wire [AXI_CONFIG_ADDR_WIDTH-1 : 0] 	 	AXI_CONFIG_araddr,
		input wire [2 : 0] 								AXI_CONFIG_arprot,
		input wire  									AXI_CONFIG_arvalid,
		output wire  									AXI_CONFIG_arready,
		output wire [AXI_CONFIG_DATA_WIDTH-1 : 0] 	 	AXI_CONFIG_rdata,
		output wire [1 : 0] 							AXI_CONFIG_rresp,
		output wire  									AXI_CONFIG_rvalid,
		input wire  									AXI_CONFIG_rready,

		// Ports of Axi Slave Bus Interface AXI_PT
		input wire [AXI_PT_ID_WIDTH-1 : 0] 			S_AXI_PT_awid,
		input wire [AXI_PT_ADDR_WIDTH-1 : 0] 		S_AXI_PT_awaddr,
		input wire [7 : 0] 							S_AXI_PT_awlen,
		input wire [2 : 0] 							S_AXI_PT_awsize,
		input wire [1 : 0] 							S_AXI_PT_awburst,
		input wire  								S_AXI_PT_awlock,
		input wire [3 : 0] 							S_AXI_PT_awcache,
		input wire [2 : 0] 							S_AXI_PT_awprot,
		input wire [3 : 0] 							S_AXI_PT_awqos,
		input wire [3 : 0] 							S_AXI_PT_awregion,
		input wire [AXI_PT_AWUSER_WIDTH-1 : 0] 		S_AXI_PT_awuser,
		input wire  								S_AXI_PT_awvalid,
		output wire  								S_AXI_PT_awready,
		input wire [AXI_PT_DATA_WIDTH-1 : 0] 		S_AXI_PT_wdata,
		input wire [(AXI_PT_DATA_WIDTH/8)-1 : 0]	S_AXI_PT_wstrb,
		input wire  								S_AXI_PT_wlast,
		input wire [AXI_PT_WUSER_WIDTH-1 : 0] 		S_AXI_PT_wuser,
		input wire  								S_AXI_PT_wvalid,
		output wire  								S_AXI_PT_wready,
		output wire [AXI_PT_ID_WIDTH-1 : 0] 		S_AXI_PT_bid,
		output wire [1 : 0] 						S_AXI_PT_bresp,
		output wire [AXI_PT_BUSER_WIDTH-1 : 0] 		S_AXI_PT_buser,
		output wire  								S_AXI_PT_bvalid,
		input wire  								S_AXI_PT_bready,
		input wire [AXI_PT_ID_WIDTH-1 : 0] 			S_AXI_PT_arid,
		input wire [AXI_PT_ADDR_WIDTH-1 : 0] 		S_AXI_PT_araddr,
		input wire [7 : 0] 							S_AXI_PT_arlen,
		input wire [2 : 0] 							S_AXI_PT_arsize,
		input wire [1 : 0] 							S_AXI_PT_arburst,
		input wire  								S_AXI_PT_arlock,
		input wire [3 : 0] 							S_AXI_PT_arcache,
		input wire [2 : 0] 							S_AXI_PT_arprot,
		input wire [3 : 0] 							S_AXI_PT_arqos,
		input wire [3 : 0] 							S_AXI_PT_arregion,
		input wire [AXI_PT_ARUSER_WIDTH-1 : 0] 		S_AXI_PT_aruser,
		input wire  								S_AXI_PT_arvalid,
		output wire  								S_AXI_PT_arready,
		output wire [AXI_PT_ID_WIDTH-1 : 0] 		S_AXI_PT_rid,
		output wire [AXI_PT_DATA_WIDTH-1 : 0] 		S_AXI_PT_rdata,
		output wire [1 : 0] 						S_AXI_PT_rresp,
		output wire  								S_AXI_PT_rlast,
		output wire [AXI_PT_RUSER_WIDTH-1 : 0] 		S_AXI_PT_ruser,
		output wire  								S_AXI_PT_rvalid,
		input wire  								S_AXI_PT_rready,

		// Ports of Axi Master Bus Interface AXI_PT
		output wire [AXI_PT_ID_WIDTH-1 : 0] 		M_AXI_PT_awid,
		output wire [AXI_PT_ADDR_WIDTH-1 : 0] 		M_AXI_PT_awaddr,
		output wire [7 : 0] 						M_AXI_PT_awlen,
		output wire [2 : 0] 						M_AXI_PT_awsize,
		output wire [1 : 0] 						M_AXI_PT_awburst,
		output wire  								M_AXI_PT_awlock,
		output wire [3 : 0] 						M_AXI_PT_awcache,
		output wire [2 : 0] 						M_AXI_PT_awprot,
		output wire [3 : 0] 						M_AXI_PT_awqos,
		output wire [AXI_PT_AWUSER_WIDTH-1 : 0] 	M_AXI_PT_awuser,
		output wire  								M_AXI_PT_awvalid,
		input wire  								M_AXI_PT_awready,
		output wire [AXI_PT_DATA_WIDTH-1 : 0] 		M_AXI_PT_wdata,
		output wire [AXI_PT_DATA_WIDTH/8-1 : 0] 	M_AXI_PT_wstrb,
		output wire  								M_AXI_PT_wlast,
		output wire [AXI_PT_WUSER_WIDTH-1 : 0] 		M_AXI_PT_wuser,
		output wire  								M_AXI_PT_wvalid,
		input wire  								M_AXI_PT_wready,
		input wire [AXI_PT_ID_WIDTH-1 : 0] 			M_AXI_PT_bid,
		input wire [1 : 0] 							M_AXI_PT_bresp,
		input wire [AXI_PT_BUSER_WIDTH-1 : 0] 		M_AXI_PT_buser,
		input wire  								M_AXI_PT_bvalid,
		output wire  								M_AXI_PT_bready,
		output wire [AXI_PT_ID_WIDTH-1 : 0] 		M_AXI_PT_arid,
		output wire [AXI_PT_ADDR_WIDTH-1 : 0] 		M_AXI_PT_araddr,
		output wire [7 : 0] 						M_AXI_PT_arlen,
		output wire [2 : 0] 						M_AXI_PT_arsize,
		output wire [1 : 0] 						M_AXI_PT_arburst,
		output wire  								M_AXI_PT_arlock,
		output wire [3 : 0] 						M_AXI_PT_arcache,
		output wire [2 : 0] 						M_AXI_PT_arprot,
		output wire [3 : 0] 						M_AXI_PT_arqos,
		output wire [AXI_PT_ARUSER_WIDTH-1 : 0] 	M_AXI_PT_aruser,
		output wire  								M_AXI_PT_arvalid,
		input wire  								M_AXI_PT_arready,
		input wire [AXI_PT_ID_WIDTH-1 : 0] 			M_AXI_PT_rid,
		input wire [AXI_PT_DATA_WIDTH-1 : 0] 		M_AXI_PT_rdata,
		input wire [1 : 0] 							M_AXI_PT_rresp,
		input wire  								M_AXI_PT_rlast,
		input wire [AXI_PT_RUSER_WIDTH-1 : 0] 		M_AXI_PT_ruser,
		input wire  								M_AXI_PT_rvalid,
		output wire  								M_AXI_PT_rready
	);
	
	// Ports of Axi Slave Bus Interface AXI_CONFIG

	AXI_LITE #(
		.AXI_ADDR_WIDTH(AXI_CONFIG_ADDR_WIDTH),
		.AXI_DATA_WIDTH(AXI_CONFIG_DATA_WIDTH)
	) conf();

	assign conf.aw_addr =			AXI_CONFIG_awaddr;	// input
	assign conf.aw_prot =			AXI_CONFIG_awprot;	// input
	assign conf.aw_valid =			AXI_CONFIG_awvalid;	// input
	assign AXI_CONFIG_awready = 	conf.aw_ready;			// output

	assign conf.w_data =			AXI_CONFIG_wdata;		// input
	assign conf.w_strb =			AXI_CONFIG_wstrb;		// input
	assign conf.w_valid =			AXI_CONFIG_wvalid;	// input
	assign AXI_CONFIG_wready = 	conf.w_ready;			// output

	assign AXI_CONFIG_bresp = 	conf.b_resp;			// output
	assign AXI_CONFIG_bvalid = 	conf.b_valid;			// output
	assign conf.b_ready =			AXI_CONFIG_bready;	// input
	
	assign conf.ar_addr =			AXI_CONFIG_araddr;	// input
	assign conf.ar_prot =			AXI_CONFIG_arprot;	// input
	assign conf.ar_valid =			AXI_CONFIG_arvalid;	// input
	assign AXI_CONFIG_arready = 	conf.ar_ready;			// output
	assign AXI_CONFIG_rdata = 	conf.r_data;			// output
	assign AXI_CONFIG_rresp = 	conf.r_resp;			// output
	assign AXI_CONFIG_rvalid = 	conf.r_valid;			// output
	assign conf.r_ready =			AXI_CONFIG_rready;	// input

	
	// Create and map Axi Slave Bus Interface AXI_PT

	AXI_BUS #(
		.AXI_ADDR_WIDTH(AXI_PT_ADDR_WIDTH),
		.AXI_DATA_WIDTH(AXI_PT_DATA_WIDTH)
	) slave();
	
	assign slave.aw_id = 		S_AXI_PT_awid;		// input
	assign slave.aw_addr = 		S_AXI_PT_awaddr;	// input
	assign slave.aw_len = 		S_AXI_PT_awlen;		// input
	assign slave.aw_size = 		S_AXI_PT_awsize;	// input
	assign slave.aw_burst = 	S_AXI_PT_awburst;	// input
	assign slave.aw_lock = 		S_AXI_PT_awlock;	// input
	assign slave.aw_cache = 	S_AXI_PT_awcache;	// input
	assign slave.aw_prot = 		S_AXI_PT_awprot;	// input
	assign slave.aw_qos = 		S_AXI_PT_awqos;		// input
	assign slave.aw_region = 	S_AXI_PT_awregion;	// input
	assign slave.aw_user = 		S_AXI_PT_awuser;	// input
	assign slave.aw_valid = 	S_AXI_PT_awvalid;	// input
	assign S_AXI_PT_awready = 	slave.aw_ready;		// output
	assign slave.w_data = 		S_AXI_PT_wdata;		// input
	assign slave.w_strb = 		S_AXI_PT_wstrb;		// input
	assign slave.w_last = 		S_AXI_PT_wlast;		// input
	assign slave.w_user = 		S_AXI_PT_wuser;		// input
	assign slave.w_valid = 		S_AXI_PT_wvalid;	// input
	assign S_AXI_PT_wready = 	slave.w_ready;		// output
	assign S_AXI_PT_bid = 		slave.b_id;			// output
	assign S_AXI_PT_bresp = 	slave.b_resp;		// output
	assign S_AXI_PT_buser = 	slave.b_user;		// output
	assign S_AXI_PT_bvalid = 	slave.b_valid;		// output
	assign slave.b_ready = 		S_AXI_PT_bready;	// input
	assign slave.ar_id = 		S_AXI_PT_arid;		// input
	assign slave.ar_addr = 		S_AXI_PT_araddr;	// input
	assign slave.ar_len = 		S_AXI_PT_arlen;		// input
	assign slave.ar_size = 		S_AXI_PT_arsize;	// input
	assign slave.ar_burst = 	S_AXI_PT_arburst;	// input
	assign slave.ar_lock = 		S_AXI_PT_arlock;	// input
	assign slave.ar_cache = 	S_AXI_PT_arcache;	// input
	assign slave.ar_prot = 		S_AXI_PT_arprot;	// input
	assign slave.ar_qos = 		S_AXI_PT_arqos;		// input
	assign slave.ar_region = 	S_AXI_PT_arregion;	// input
	assign slave.ar_user = 		S_AXI_PT_aruser;	// input
	assign slave.ar_valid = 	S_AXI_PT_arvalid;	// input
	assign S_AXI_PT_arready = 	slave.ar_ready;		// output
	assign S_AXI_PT_rid = 		slave.r_id;			// output
	assign S_AXI_PT_rdata = 	slave.r_data;		// output
	assign S_AXI_PT_rresp = 	slave.r_resp;		// output
	assign S_AXI_PT_rlast = 	slave.r_last;		// output
	assign S_AXI_PT_ruser = 	slave.r_user;		// output
	assign S_AXI_PT_rvalid = 	slave.r_valid;		// output
	assign slave.r_ready = 		S_AXI_PT_rready;	// input

	// Create and map Axi Master Bus Interface AXI_PT

	AXI_BUS #(
		.AXI_ADDR_WIDTH(AXI_PT_ADDR_WIDTH),
		.AXI_DATA_WIDTH(AXI_PT_DATA_WIDTH)
	) master();

	assign M_AXI_PT_awid = 		master.aw_id;		// output
	assign M_AXI_PT_awaddr = 	master.aw_addr;		// output
	assign M_AXI_PT_awlen = 	master.aw_len;		// output
	assign M_AXI_PT_awsize = 	master.aw_size;		// output
	assign M_AXI_PT_awburst = 	master.aw_burst;	// output
	assign M_AXI_PT_awlock = 	master.aw_lock;		// output
	assign M_AXI_PT_awcache = 	master.aw_cache;	// output
	assign M_AXI_PT_awprot = 	master.aw_prot;		// output
	assign M_AXI_PT_awqos = 	master.aw_qos;		// output
	assign M_AXI_PT_awuser = 	master.aw_user;		// output
	assign M_AXI_PT_awvalid = 	master.aw_valid;	// output
	assign master.aw_ready =	M_AXI_PT_awready; 	// input
	assign M_AXI_PT_wdata = 	master.w_data;		// output
	assign M_AXI_PT_wstrb = 	master.w_strb;		// output
	assign M_AXI_PT_wlast = 	master.w_last;		// output
	assign M_AXI_PT_wuser = 	master.w_user;		// output
	assign M_AXI_PT_wvalid = 	master.w_valid;		// output
	assign master.w_ready = 	M_AXI_PT_wready; 	// input
	assign master.b_id = 		M_AXI_PT_bid; 		// input
	assign master.b_resp = 		M_AXI_PT_bresp; 	// input
	assign master.b_user = 		M_AXI_PT_buser; 	// input
	assign master.b_valid = 	M_AXI_PT_bvalid; 	// input
	assign M_AXI_PT_bready = 	master.b_ready;		// output
	assign M_AXI_PT_arid = 		master.ar_id;		// output
	assign M_AXI_PT_araddr = 	master.ar_addr;		// output
	assign M_AXI_PT_arlen = 	master.ar_len;		// output
	assign M_AXI_PT_arsize = 	master.ar_size;		// output
	assign M_AXI_PT_arburst = 	master.ar_burst;	// output
	assign M_AXI_PT_arlock = 	master.ar_lock;		// output
	assign M_AXI_PT_arcache = 	master.ar_cache;	// output
	assign M_AXI_PT_arprot = 	master.ar_prot;		// output
	assign M_AXI_PT_arqos = 	master.ar_qos;		// output
	assign M_AXI_PT_aruser = 	master.ar_user;		// output
	assign M_AXI_PT_arvalid = 	master.ar_valid;	// output
	assign master.ar_ready = 	M_AXI_PT_arready; 	// input
	assign master.r_id = 		M_AXI_PT_rid; 		// input
	assign master.r_data = 		M_AXI_PT_rdata; 	// input
	assign master.r_resp = 		M_AXI_PT_rresp; 	// input
	assign master.r_last = 		M_AXI_PT_rlast; 	// input
	assign master.r_user = 		M_AXI_PT_ruser; 	// input
	assign master.r_valid = 	M_AXI_PT_rvalid; 	// input
	assign M_AXI_PT_rready = 	master.r_ready;		// output
	
	ProtectionUnit_v1_0 ProtectionUnit_v1_0_inst(
	   .aclk,
	   .aresetn,
	   .conf(conf),
	   .slave(slave),
	   .master(master)
	);

endmodule
