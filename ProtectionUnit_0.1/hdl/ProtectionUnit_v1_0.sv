// Copyright (c) 2022 Felix Boehm

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

`timescale 1 ns / 1 ps

`include "axi/typedef.svh"
`include "axi/assign.svh"

	module ProtectionUnit_v1_0 #
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
		parameter  AXI_PT_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer AXI_PT_BURST_LEN	= 16,
		parameter integer AXI_PT_ID_WIDTH		= 2,
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
		.UNIQUE_IDS(1'b1),
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
