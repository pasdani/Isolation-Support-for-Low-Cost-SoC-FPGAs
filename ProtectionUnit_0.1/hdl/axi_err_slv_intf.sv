// interface wrapper for axi_err_slv
`include "axi/assign.svh"
`include "axi/typedef.svh"

module axi_err_slv_intf #(
    parameter int unsigned          AxiIdWidth   = 0,                    // AXI ID Width
    parameter int unsigned          AxiAddrWidth = 0,                    // AXI Address Width
    parameter int unsigned          AxiUserWidth = 0,                    // AXI User Width
    parameter axi_pkg::resp_t       Resp         = axi_pkg::RESP_DECERR, // Error generated by this slave.
    parameter int unsigned          RespWidth    = 32'd64,               // Data response width, gets zero extended or truncated to r.data.
    parameter logic [RespWidth-1:0] RespData     = 64'hCA11AB1EBADCAB1E, // Hexvalue for data return value
    parameter bit                   ATOPs        = 1'b1,                 // Activate support for ATOPs.  Set to 1 if this slave could ever get an atomic AXI transaction.
    parameter int unsigned          MaxTrans     = 1                     // Maximum # of accepted transactions before stalling
  ) (
    input  logic  clk_i,   // Clock
    input  logic  rst_ni,  // Asynchronous reset active low
    input  logic  test_i,  // Testmode enable
    // slave port
    AXI_BUS.Slave slv
  );

  typedef logic [AxiIdWidth-1:0]       id_t;
  typedef logic [AxiAddrWidth-1:0]   addr_t;
  typedef logic [RespWidth-1:0]   data_t;
  typedef logic [RespWidth/8-1:0] strb_t;
  typedef logic [AxiUserWidth-1:0]   user_t;
  `AXI_TYPEDEF_AW_CHAN_T(aw_chan_t, addr_t, id_t, user_t)
  `AXI_TYPEDEF_W_CHAN_T(w_chan_t, data_t, strb_t, user_t)
  `AXI_TYPEDEF_B_CHAN_T(b_chan_t, id_t, user_t)
  `AXI_TYPEDEF_AR_CHAN_T(ar_chan_t, addr_t, id_t, user_t)
  `AXI_TYPEDEF_R_CHAN_T(r_chan_t, data_t, id_t, user_t)
  `AXI_TYPEDEF_REQ_T(req_t, aw_chan_t, w_chan_t, ar_chan_t)
  `AXI_TYPEDEF_RESP_T(resp_t, b_chan_t, r_chan_t)

  req_t                     slv_req;
  resp_t                    slv_resp;

  `AXI_ASSIGN_TO_REQ(slv_req, slv)
  `AXI_ASSIGN_FROM_RESP(slv, slv_resp)

  axi_err_slv #(
    .AxiIdWidth(AxiIdWidth),
    .axi_req_t(req_t),
    .axi_resp_t(resp_t),
    .Resp(Resp),
    .RespWidth(RespWidth),
    .RespData(RespData),
    .ATOPs(ATOPs),
    .MaxTrans(MaxTrans)
    ) inst (
      .slv_req_i(slv_req),
      .slv_resp_o(slv_resp),
      .*
    );

endmodule
