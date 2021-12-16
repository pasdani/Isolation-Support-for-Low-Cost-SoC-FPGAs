`timescale 1 ns / 1 ps

`include "common_cells/registers.svh"
`include "axi/typedef.svh"

// Configuration register for the Protection Unit
//
// The register can be read and written through AXI Lite.
// It features a control register and multiple policyregisters, that forward bits to the rest of the implementation.
// It features a status register, that make bits from the rest of the implementation readable.
//
// Implementation based on https://github.com/pulp-platform/axi/blob/master/src/axi_lite_regs.sv


module ProtectionUnit_v1_0_AXI_CONFIG #(
    /// Number of configurable memory regions
    parameter int unsigned NumMemRegions  = 32'd2,
    /// Number of configurable domains (max. 16)
    parameter int unsigned NumDomains = 32'd2,
    /// Address width of the AXI4-Lite port.
    ///
    /// The minimum value of this parameter is 7.
    /// Higher bits are ignored.
    parameter int unsigned AxiAddrWidth = 32'd7,
    /// Data width of the AXI4-Lite port.
    /// Should be 32.
    parameter int unsigned AxiDataWidth = 32'd32,
    /// Only allow *privileged* accesses on the AXI4-Lite port.
    ///
    /// If this parameter is set to `1`, this module only allows reads and writes that have the
    /// `AxProt[0]` bit set.  If a transaction does not have the `AxProt[0]` bit set, this module
    /// replies with `SLVERR` and does not read or write register data.
    parameter bit PrivProtOnly = 1'b0,
    /// Only allow *secure* accesses on the AXI4-Lite port.
    ///
    /// If this parameter is set to `1`, this module only allows reads and writes that have the
    /// `AxProt[1]` bit set.  If a transaction does not have the `AxProt[1]` bit set, this module
    /// replies with `SLVERR` and does not read or write register data.
    parameter bit SecuProtOnly = 1'b0,
    /// Request struct of the AXI4-Lite port.
    parameter type req_lite_t = logic,
    /// Response struct of the AXI4-Lite port.
    parameter type resp_lite_t = logic
  ) (
    /// Rising-edge clock of all ports
    input  logic clk_i,
    /// Asynchronous reset, active low
    input  logic rst_ni,
    /// AXI4-Lite slave request
    input  req_lite_t axi_req_i,
    /// AXI4-Lite slave response
    output resp_lite_t axi_resp_o,
    // Configured policy
    output pu_pkg::policy_entry_t [NumMemRegions-1 :0][NumDomains-1 :0] policy_o
    /// TODO: add various ctrl outputs
    /// TODO: add various status inputs
  );


  // Define the number of register chunks needed to map all `RegNumBytes` to the AXI channel.
  // Eg: `AxiDataWidth == 32'd32`
  // AXI strb:                       3 2 1 0
  //                                 | | | |
  //             *---------*---------* | | |
  //             | *-------|-*-------|-* | |
  //             | | *-----|-|-*-----|-|-* |
  //             | | | *---|-|-|-*---|-|-|-*
  //             | | | |   | | | |   | | | |
  // Reg byte:   B A 9 8   7 6 5 4   3 2 1 0
  //           | chunk_2 | chunk_1 | chunk_0 |
  localparam int unsigned AxiStrbWidth  = AxiDataWidth / 32'd8;

  // Width of each register
  localparam int unsigned RegisterWidth = 32'd32;
  localparam int unsigned BytesPerRegister = RegisterWidth / 32'd8;
  localparam int unsigned AddrWidth = 7;
  localparam int unsigned AddrLsb = (BytesPerRegister > 32'd1) ? $clog2(BytesPerRegister) : 32'd1;
  typedef logic [AddrWidth-1:0] addr_t;

  // initial begin
  //   assert (AxiAddrWidth >= AddrWidth)
  //          else
  //            $error("AxiAddrWidth bust be at least %d", AddrWidth);
  //   assert (AxiDataWidth == RegisterWidth)
  //          else
  //            $error("AxiDataWidth must equal the RegisterWidth of %d", RegisterWidth);
  // end

  // Type of the index to identify a specific memory region chunk.
  localparam int unsigned MemRegionWidth = (NumMemRegions > 32'd1) ? $clog2(NumMemRegions) : 32'd1;
  typedef logic [MemRegionWidth-1 : 0] mem_region_idx_t;

  // Define the register types

  // Control Register
  typedef struct packed {
    logic [31:0] reserved;
  } ctrl_reg_t;
  localparam ctrl_reg_t CTRL_REG_RST = '0;

  typedef union packed { 
    ctrl_reg_t register;
    logic [BytesPerRegister-1:0][7:0] bytes;
    logic [RegisterWidth-1:0] bits;
  } ctrl_reg_union_t;

  // Status Register
  typedef struct packed {
    logic [31:0] reserved;
  } status_reg_t;
  localparam status_reg_t STATUS_REG_RST = '0;

  typedef union packed { 
    status_reg_t register;
    logic [BytesPerRegister-1:0][7:0] bytes;
    logic [RegisterWidth-1:0] bits;
  } status_reg_union_t;
  
  // Policy Register
  typedef struct packed {
    logic read;
    logic write;
  } policy_entry_t;
  
  // policy_reg_t and policy_reg_union_t are declare one byte wider than RegisterWidth.
  // This is done to account for the case when NumDomains = 16.
  // In this case the reserved meber should have a width of 0. This is not possible. 
  typedef struct packed {
    policy_entry_t [19:NumDomains] reserved;
    policy_entry_t [NumDomains-1:0] entry;
  } policy_reg_t;  
  localparam policy_reg_t POLICY_REG_RST = '0;

  typedef union packed { 
    policy_reg_t register;
    logic [BytesPerRegister:0][7:0] bytes;
    logic [RegisterWidth+7:0] bits;
  } policy_reg_union_t;
  
  // Enum that indexes register type/region
  typedef enum logic[1:0] {
            ctrl,
            status,
            policy
          } register_type_t;
  localparam int unsigned NumRegisterTypes = 3;

  // Define the address map which maps each register chunk onto an AXI address.
  typedef struct packed {
            int unsigned idx;
            addr_t       start_addr;  // inclusive
            addr_t       end_addr;    // exclusive
          } axi_rule_t;

  axi_rule_t [NumRegisterTypes-1:0] addr_map;
  assign addr_map[ctrl] = axi_rule_t'{
           idx:        ctrl,
           start_addr: addr_t'('h00),
           end_addr:   addr_t'('h00 + BytesPerRegister)
         };

  assign addr_map[status] = axi_rule_t'{
           idx:        status,
           start_addr: addr_t'('h04),
           end_addr:   addr_t'('h04 + BytesPerRegister)
         };

  assign addr_map[policy] = axi_rule_t'{
           idx:        policy,
           start_addr: addr_t'('h40),
           end_addr:   addr_t'('h40 + (NumMemRegions * BytesPerRegister))
         };

  // Channel definitions for spill register
  typedef logic [AxiDataWidth-1:0] axi_data_t;
  `AXI_LITE_TYPEDEF_B_CHAN_T(b_chan_lite_t)
  `AXI_LITE_TYPEDEF_R_CHAN_T(r_chan_lite_t, axi_data_t)

  // Register array declarations
  ctrl_reg_union_t                        ctrl_reg_q;
  status_reg_union_t                      status_reg_q;
  policy_reg_union_t [NumMemRegions-1:0]  policy_reg_q;

  // Update signals for writeable registers
  logic  [AxiStrbWidth-1:0]                     ctrl_reg_update;
  logic  [NumMemRegions-1:0][AxiStrbWidth-1:0]  policy_reg_update;


  // Write logic
  // TODO: consider strobe
  logic[1:0]        aw_reg_type;
  mem_region_idx_t  aw_mem_region_idx;
  logic             aw_dec_valid;
  b_chan_lite_t     b_chan;
  logic             b_valid,      b_ready;
  logic             aw_prot_ok;

  // Flag for telling that the protection level is the right one.
  assign aw_prot_ok = (PrivProtOnly ? axi_req_i.aw.prot[0] : 1'b1) &
                      (SecuProtOnly ? axi_req_i.aw.prot[1] : 1'b1);

  // As register values are 32-bit width, bit 2 is the leat significant one
  assign aw_mem_region_idx = axi_req_i.aw.addr[AddrLsb+:MemRegionWidth];

  // Register write logic.
  always_comb
  begin
    // default assignments
    ctrl_reg_update     = '0;
    policy_reg_update   = {NumMemRegions{'0}};
    // Channel handshake
    axi_resp_o.aw_ready = 1'b0;
    axi_resp_o.w_ready  = 1'b0;
    // Response
    b_chan              = b_chan_lite_t'{resp: axi_pkg::RESP_SLVERR, default: '0};
    b_valid             = 1'b0;

    // Handle load from AXI write.
    // `b_ready` is allowed to be a condition as it comes from a spill register.
    if (axi_req_i.aw_valid && axi_req_i.w_valid && b_ready)
    begin
      // The write can be performed when these conditions are true:
      // - AW decode is valid.
      // - `axi_req_i.aw.prot` has the right value.
      if (aw_dec_valid && aw_prot_ok)
      begin
        // Select register for writing
        case (aw_reg_type)
          ctrl:
          begin
            ctrl_reg_update = axi_req_i.w.strb;
            b_chan.resp     = axi_pkg::RESP_OKAY;
          end
          policy:
          begin
            // TODO: consider this
            //policy_reg_q[aw_mem_region_idx].reserved  = '0;
            policy_reg_update[aw_mem_region_idx]      = axi_req_i.w.strb;
            b_chan.resp                               = axi_pkg::RESP_OKAY;
          end
        endcase
      end
      b_valid             = 1'b1;
      axi_resp_o.aw_ready = 1'b1;
      axi_resp_o.w_ready  = 1'b1;
    end
  end


  // Read logic
  logic[1:0]        ar_reg_type;
  mem_region_idx_t  ar_mem_region_idx;
  logic             ar_dec_valid;
  r_chan_lite_t     r_chan;
  logic             r_valid,      r_ready;
  logic             ar_prot_ok;
  assign ar_prot_ok = (PrivProtOnly ? axi_req_i.ar.prot[0] : 1'b1) &
         (SecuProtOnly ? axi_req_i.ar.prot[1] : 1'b1);
  assign ar_mem_region_idx = axi_req_i.ar.addr[AddrLsb+:MemRegionWidth];

  // Multiplexer to determine R channel
  always_comb
  begin
    automatic int unsigned reg_byte_idx = '0;
    // Default R channel throws an error.
    r_chan = r_chan_lite_t'{
             data: axi_data_t'(32'hBA5E1E55),
             resp: axi_pkg::RESP_SLVERR,
             default: '0
           };
    // Read is valid on a chunk
    if (ar_dec_valid && ar_prot_ok)
    begin
      case (ar_reg_type)
        ctrl:
          r_chan.data = ctrl_reg_q;
        status:
          r_chan.data = status_reg_q;
        policy:
          r_chan.data = policy_reg_q[ar_mem_region_idx];
      endcase
      r_chan.resp = axi_pkg::RESP_OKAY;
    end
  end

  assign r_valid             = axi_req_i.ar_valid; // to spill register
  assign axi_resp_o.ar_ready = r_ready;            // from spill register


  // Mask unused bits for writing to policy registers
  policy_reg_t policy_reg_w_data;
  always_comb begin
    policy_reg_w_data = axi_req_i.w.data;
    policy_reg_w_data.reserved = '0;
  end

  // Create registers
  for (genvar i = 0; i < AxiStrbWidth; i++) begin: gen_ctrl_reg
    `FFL(ctrl_reg_q.bytes[i], axi_req_i.w.data[i*8+:8], ctrl_reg_update[i], CTRL_REG_RST[i*8+:8], clk_i, rst_ni)
  end
  for (genvar j = 0; j < NumMemRegions; j++) begin: gen_policy_reg
    for (genvar i = 0; i < AxiStrbWidth; i++) begin
     `FFL(policy_reg_q[j].bytes[i], policy_reg_w_data[i*8+:8], policy_reg_update[j][i], POLICY_REG_RST[i*8+:8], clk_i, rst_ni)
   end
  end
  
  // Assign outputs
  for (genvar i = 0; i < NumMemRegions; i++) begin
    assign policy_o[i] = policy_reg_q[i].register.entry;
  end

  addr_decode #(
    .NoIndices ( NumRegisterTypes        ),
    .NoRules   ( NumRegisterTypes        ),
    .addr_t    ( addr_t                  ),
    .rule_t    ( axi_rule_t              )
  ) i_aw_decode (
    .addr_i           ( addr_t'(axi_req_i.aw.addr) ), // Only look at the significant bits.
    .addr_map_i       ( addr_map                   ),
    .idx_o            ( aw_reg_type                ),
    .dec_valid_o      ( aw_dec_valid               ),
    .dec_error_o      ( /*not used*/               ),
    .en_default_idx_i ( '0                         ),
    .default_idx_i    ( '0                         )
  );

  addr_decode #(
    .NoIndices ( NumRegisterTypes  ),
    .NoRules   ( NumRegisterTypes  ),
    .addr_t    ( addr_t            ),
    .rule_t    ( axi_rule_t        )
  ) i_ar_decode (
    .addr_i           ( addr_t'(axi_req_i.ar.addr) ), // Only look at the significant bits.
    .addr_map_i       ( addr_map                   ),
    .idx_o            ( ar_reg_type                ),
    .dec_valid_o      ( ar_dec_valid               ),
    .dec_error_o      ( /*not used*/               ),
    .en_default_idx_i ( '0                         ),
    .default_idx_i    ( '0                         )
  );

  // Add a cycle delay on AXI response, cut all comb paths between slave port inputs and outputs.
  spill_register #(
    .T      ( b_chan_lite_t ),
    .Bypass ( 1'b0          )
  ) i_b_spill_register (
    .clk_i,
    .rst_ni,
    .valid_i ( b_valid            ),
    .ready_o ( b_ready            ),
    .data_i  ( b_chan             ),
    .valid_o ( axi_resp_o.b_valid ),
    .ready_i ( axi_req_i.b_ready  ),
    .data_o  ( axi_resp_o.b       )
  );

  // Add a cycle delay on AXI response, cut all comb paths between slave port inputs and outputs.
  spill_register #(
    .T      ( r_chan_lite_t ),
    .Bypass ( 1'b0          )
  ) i_r_spill_register (
    .clk_i,
    .rst_ni,
    .valid_i ( r_valid            ),
    .ready_o ( r_ready            ),
    .data_i  ( r_chan             ),
    .valid_o ( axi_resp_o.r_valid ),
    .ready_i ( axi_req_i.r_ready  ),
    .data_o  ( axi_resp_o.r       )
  );

//   // Validate parameters.
//   // pragma translate_off
//   `ifndef VERILATOR
//   initial begin: p_assertions
//     assert (AxiAddrWidth >= AddrWidth) else
//         $fatal(1, "AxiAddrWidth is not wide enough, has to be at least %0d-bit wide!", AddrWidth);
//     assert ($bits(axi_req_i.aw.addr) == AxiAddrWidth) else
//         $fatal(1, "AddrWidth does not match req_i.aw.addr!");
//     assert ($bits(axi_req_i.ar.addr) == AxiAddrWidth) else
//         $fatal(1, "AddrWidth does not match req_i.ar.addr!");
//     assert (AxiDataWidth == $bits(axi_req_i.w.data)) else
//         $fatal(1, "AxiDataWidth has to be: AxiDataWidth == $bits(axi_req_i.w.data)!");
//     assert (AxiDataWidth == $bits(axi_resp_o.r.data)) else
//         $fatal(1, "AxiDataWidth has to be: AxiDataWidth == $bits(axi_resp_o.r.data)!");
//   end
// `endif
// // pragma translate_on
endmodule


`include "axi/assign.svh"
/// Interface variant of [`axi_lite_regs`](module.axi_lite_regs).
///
/// See the documentation of the main module for the definition of ports and parameters.
module ProtectionUnit_v1_0_AXI_CONFIG_intf #(
  parameter int unsigned NumMemRegions  = 32'd2,
  parameter int unsigned NumDomains     = 32'd2,
  parameter int unsigned AXI_ADDR_WIDTH = 32'd7,
  parameter int unsigned AXI_DATA_WIDTH = 32'd32,
  parameter bit          PRIV_PROT_ONLY = 1'd0,
  parameter bit          SECU_PROT_ONLY = 1'd0
) (
  input  logic                                                        clk_i,
  input  logic                                                        rst_ni,
  AXI_LITE.Slave                                                      slv,  
  output pu_pkg::policy_entry_t [NumMemRegions-1 :0][NumDomains-1 :0] policy_o
);

  typedef logic [AXI_ADDR_WIDTH-1:0]   addr_t;
  typedef logic [AXI_DATA_WIDTH-1:0]   data_t;
  typedef logic [AXI_DATA_WIDTH/8-1:0] strb_t;
  `AXI_LITE_TYPEDEF_AW_CHAN_T(aw_chan_lite_t, addr_t)
  `AXI_LITE_TYPEDEF_W_CHAN_T(w_chan_lite_t, data_t, strb_t)
  `AXI_LITE_TYPEDEF_B_CHAN_T(b_chan_lite_t)
  `AXI_LITE_TYPEDEF_AR_CHAN_T(ar_chan_lite_t, addr_t)
  `AXI_LITE_TYPEDEF_R_CHAN_T(r_chan_lite_t, data_t)
  `AXI_LITE_TYPEDEF_REQ_T(req_lite_t, aw_chan_lite_t, w_chan_lite_t, ar_chan_lite_t)
  `AXI_LITE_TYPEDEF_RESP_T(resp_lite_t, b_chan_lite_t, r_chan_lite_t)

  req_lite_t  axi_lite_req;
  resp_lite_t axi_lite_resp;

  `AXI_LITE_ASSIGN_TO_REQ(axi_lite_req, slv)
  `AXI_LITE_ASSIGN_FROM_RESP(slv, axi_lite_resp)

  ProtectionUnit_v1_0_AXI_CONFIG #(
    .NumMemRegions( NumMemRegions  ),
    .NumDomains   ( NumDomains     ),
    .AxiAddrWidth ( AXI_ADDR_WIDTH ),
    .AxiDataWidth ( AXI_DATA_WIDTH ),
    .PrivProtOnly ( PRIV_PROT_ONLY ),
    .SecuProtOnly ( SECU_PROT_ONLY ),
    .req_lite_t   ( req_lite_t     ),
    .resp_lite_t  ( resp_lite_t    )
  ) i_ProtectionUnit_v1_0_AXI_CONFIG (
    .clk_i,
    .rst_ni,
    .axi_req_i   ( axi_lite_req  ),
    .axi_resp_o  ( axi_lite_resp ),
    .policy_o
  );

  // // Validate parameters.
  // // pragma translate_off
  // `ifndef VERILATOR
  //   initial begin: p_assertions
  //     assert (AXI_ADDR_WIDTH == $bits(slv.aw_addr))
  //         else $fatal(1, "AXI_ADDR_WIDTH does not match slv interface!");
  //     assert (AXI_DATA_WIDTH == $bits(slv.w_data))
  //         else $fatal(1, "AXI_DATA_WIDTH does not match slv interface!");
  //   end
  // `endif
  // // pragma translate_on

	endmodule
