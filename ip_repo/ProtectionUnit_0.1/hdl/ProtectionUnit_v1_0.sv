
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
		parameter integer AXI_PT_BUSER_WIDTH	= 0,

		// Memory Regions and Domain Declarations
		parameter logic [AXI_PT_ADDR_WIDTH-1 : 0] 	MEM_REGIONS [0 : NUM_MEM_REGIONS-1]    	= '{default: 32'h00000000   },
    	parameter int unsigned              		MEM_REGION_LSBS [0 : NUM_MEM_REGIONS-1]	= '{default: 32'd0          },
    	parameter logic [AXI_PT_ID_WIDTH-1 : 0]    	DOMAIN_IDS [0 : NUM_DOMAINS-1]         	= '{default: 16'h0000       },
    	parameter logic [AXI_PT_ID_WIDTH-1 : 0]    	DOMAIN_MASKS [0 : NUM_DOMAINS-1]       	= '{default: 16'hFFFF       }
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

	logic aw_granted;
	logic ar_granted;

	PolicyCheck #(
		.NUM_MEM_REGIONS	( NUM_MEM_REGIONS	 ),
    	.NUM_DOMAINS		( NUM_DOMAINS		 ),
    	.ID_WIDTH			( AXI_PT_ID_WIDTH	 ),
    	.ADDR_WIDTH			( AXI_PT_ADDR_WIDTH  ),
		.MEM_REGIONS		( MEM_REGIONS		 ),	
		.MEM_REGION_LSBS	( MEM_REGION_LSBS	 ),		
		.DOMAIN_IDS			( DOMAIN_IDS		 ),
		.DOMAIN_MASKS		( DOMAIN_MASKS		 )	
	) PolicyCheck_aw_inst (
		.POLICY		( policy			),	
		.ID			( slave.aw_id 		),
		.ADDR		( slave.aw_addr 	),	
		.LEN		( slave.aw_len 		),	
		.SIZE		( slave.aw_size 	),	
		.READ_WRITE	( 1'b1 				),		
		.GRANTED	( aw_granted		)
	);

	PolicyCheck #(
		.NUM_MEM_REGIONS	( NUM_MEM_REGIONS	 ),
    	.NUM_DOMAINS		( NUM_DOMAINS		 ),
    	.ID_WIDTH			( AXI_PT_ID_WIDTH	 ),
    	.ADDR_WIDTH			( AXI_PT_ADDR_WIDTH  ),
		.MEM_REGIONS		( MEM_REGIONS		 ),	
		.MEM_REGION_LSBS	( MEM_REGION_LSBS	 ),		
		.DOMAIN_IDS			( DOMAIN_IDS		 ),
		.DOMAIN_MASKS		( DOMAIN_MASKS		 )	
	) PolicyCheck_ar_inst (
		.POLICY		( policy			),	
		.ID			( slave.ar_id 		),
		.ADDR		( slave.ar_addr 	),	
		.LEN		( slave.ar_len 		),	
		.SIZE		( slave.ar_size 	),	
		.READ_WRITE	( 1'b0 				),		
		.GRANTED	( ar_granted		)
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
		.SPILL_AW(1'b0),
		.SPILL_W(1'b0),
		.SPILL_B(1'b0),
		.SPILL_AR(1'b0),
		.SPILL_R(1'b0)		 
	) axi_demux_inst (
		.slv_aw_select_i(aw_granted),
		.slv_ar_select_i(ar_granted),
		.slv(slave),
		.mst('{master, err_path}),
		.clk_i(aclk),
		.rst_ni(aresetn),
		.test_i(1'b0)
	);

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
		.rst_ni(aresetn),
		.test_i(1'b0)
	);

	endmodule


	module ProtectionUnit_v1_0_verilog #
	(		
		parameter integer NUM_MEM_REGIONS	= 2,
		parameter integer NUM_DOMAINS		= 2,

		// Parameters of Axi Slave Bus Interface AXI_CONFIG
		parameter integer AXI_CONFIG_DATA_WIDTH	= 32,
		parameter integer AXI_CONFIG_ADDR_WIDTH	= 8,

		// Parameters of Axi Pass Through AXI_PT
		parameter  AXI_PT_TARGET_SLAVE_BASE_ADDR	= 32'h40000000, // TODO: what does this do?
		parameter integer AXI_PT_BURST_LEN	= 16, // TODO: what does this do?
		parameter integer AXI_PT_ID_WIDTH	= 2,
		parameter integer AXI_PT_DATA_WIDTH	= 32,
		parameter integer AXI_PT_ADDR_WIDTH	= 6,
		parameter integer AXI_PT_AWUSER_WIDTH	= 0,
		parameter integer AXI_PT_ARUSER_WIDTH	= 0,
		parameter integer AXI_PT_WUSER_WIDTH	= 0,
		parameter integer AXI_PT_RUSER_WIDTH	= 0,
		parameter integer AXI_PT_BUSER_WIDTH	= 0,

		// Memory Regions and Domain Declarations
		parameter logic [AXI_PT_ADDR_WIDTH-1 : 0]	MEM_REGION_0 =      32'h00000000,
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
                                            
        parameter int unsigned        	            MEM_REGION_0_LSB =  32'd0,
                                            		MEM_REGION_1_LSB =  32'd0,
                                            		MEM_REGION_2_LSB =  32'd0,
                                            		MEM_REGION_3_LSB =  32'd0,
                                            		MEM_REGION_4_LSB =  32'd0,
                                            		MEM_REGION_5_LSB =  32'd0,
                                            		MEM_REGION_6_LSB =  32'd0,
                                            		MEM_REGION_7_LSB =  32'd0,
                                            		MEM_REGION_8_LSB =  32'd0,
                                            		MEM_REGION_9_LSB =  32'd0,
                                            		MEM_REGION_10_LSB = 32'd0,
                                            		MEM_REGION_11_LSB = 32'd0,
                                            		MEM_REGION_12_LSB = 32'd0,
                                            		MEM_REGION_13_LSB = 32'd0,
                                            		MEM_REGION_14_LSB = 32'd0,
                                            		MEM_REGION_15_LSB = 32'd0,

        parameter logic [AXI_PT_ID_WIDTH-1 : 0]   	DOMAIN_0_ID =       16'h0000,
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

		parameter logic [AXI_PT_ID_WIDTH-1 : 0]   	DOMAIN_0_MASK =     16'hFFFF,
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
		.AXI_DATA_WIDTH(AXI_PT_DATA_WIDTH),
		.AXI_ID_WIDTH(AXI_PT_ID_WIDTH),
		.AXI_USER_WIDTH(AXI_PT_AWUSER_WIDTH)
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
	assign slave.aw_atop =		'0;					// unused
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
		.AXI_DATA_WIDTH(AXI_PT_DATA_WIDTH),
		.AXI_ID_WIDTH(AXI_PT_ID_WIDTH),
		.AXI_USER_WIDTH(AXI_PT_AWUSER_WIDTH)
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
	
	// Group memory regions and domain parameters	
	localparam logic [AXI_PT_ADDR_WIDTH-1 : 0] MEM_REGIONS [0 : 15] = '{
		MEM_REGION_0,
		MEM_REGION_1,
		MEM_REGION_2,
		MEM_REGION_3,
		MEM_REGION_4,
		MEM_REGION_5,
		MEM_REGION_6,
		MEM_REGION_7,
		MEM_REGION_8,
		MEM_REGION_9,
		MEM_REGION_10,
		MEM_REGION_11,
		MEM_REGION_12,
		MEM_REGION_13,
		MEM_REGION_14,
		MEM_REGION_15
	};
	localparam int unsigned MEM_REGION_LSBS [0 : 15] = '{
		MEM_REGION_0_LSB,
		MEM_REGION_1_LSB,
		MEM_REGION_2_LSB,
		MEM_REGION_3_LSB,
		MEM_REGION_4_LSB,
		MEM_REGION_5_LSB,
		MEM_REGION_6_LSB,
		MEM_REGION_7_LSB,
		MEM_REGION_8_LSB,
		MEM_REGION_9_LSB,
		MEM_REGION_10_LSB,
		MEM_REGION_11_LSB,
		MEM_REGION_12_LSB,
		MEM_REGION_13_LSB,
		MEM_REGION_14_LSB,
		MEM_REGION_15_LSB
	};
	localparam logic [AXI_PT_ID_WIDTH-1 : 0]	DOMAIN_IDS [0 : 15] = '{
		DOMAIN_0_ID,
		DOMAIN_1_ID,
		DOMAIN_2_ID,
		DOMAIN_3_ID,
		DOMAIN_4_ID,
		DOMAIN_5_ID,
		DOMAIN_6_ID,
		DOMAIN_7_ID,
		DOMAIN_8_ID,
		DOMAIN_9_ID,
		DOMAIN_10_ID,
		DOMAIN_11_ID,
		DOMAIN_12_ID,
		DOMAIN_13_ID,
		DOMAIN_14_ID,
		DOMAIN_15_ID
	};
	localparam logic [AXI_PT_ID_WIDTH-1 : 0] DOMAIN_MASKS [0 : 15] = '{
		DOMAIN_0_MASK,
		DOMAIN_1_MASK,
		DOMAIN_2_MASK,
		DOMAIN_3_MASK,
		DOMAIN_4_MASK,
		DOMAIN_5_MASK,
		DOMAIN_6_MASK,
		DOMAIN_7_MASK,
		DOMAIN_8_MASK,
		DOMAIN_9_MASK,
		DOMAIN_10_MASK,
		DOMAIN_11_MASK,
		DOMAIN_12_MASK,
		DOMAIN_13_MASK,
		DOMAIN_14_MASK,
		DOMAIN_15_MASK
	};
	
	ProtectionUnit_v1_0 #(
		.NUM_MEM_REGIONS(NUM_MEM_REGIONS),
		.NUM_DOMAINS(NUM_DOMAINS),
		.MEM_REGIONS(MEM_REGIONS[0:NUM_MEM_REGIONS-1]),
		.MEM_REGION_LSBS(MEM_REGION_LSBS[0:NUM_MEM_REGIONS-1]),
		.DOMAIN_IDS(DOMAIN_IDS[0:NUM_DOMAINS-1]),
		.DOMAIN_MASKS(DOMAIN_MASKS[0:NUM_DOMAINS-1])
	) ProtectionUnit_v1_0_inst(
	   .aclk,
	   .aresetn,
	   .conf(conf),
	   .slave(slave),
	   .master(master)
	);

endmodule
