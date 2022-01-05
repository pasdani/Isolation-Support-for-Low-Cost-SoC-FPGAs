
`timescale 1ns / 1ps
import axi_vip_pkg::*;

module ProtectionUnitUseCase_tb_0(
    );

ProtectionUnitTestCase_tb DUT();

`include "axi_transactions_.svh"
`include "axi_vip_master_0_stimulus.svh"
`include "axi_vip_master_1_stimulus.svh"
`include "axi_vip_slave_0_basic_stimulus.svh"
`include "axi_vip_slave_1_basic_stimulus.svh"

bit [32-1:0] data = 0;

initial begin
    config_agent = new("config master vip agent",DUT.axi_vip_config.inst.IF);
    config_agent.start_master();

    // Write some stuff to config register
    write('0, 32'hF0F0F0F0);
    read('0, data);

    // // Read status register
    // read('h04, data);
    
    // Write to policy register
    write('h40, 32'h0000002C);
    read('h40, data);
   
    fork
      mst_0_start_stimulus();
      mst_1_start_stimulus();
      slv_0_start_stimulus();
      slv_1_start_stimulus();
    join;
    $finish;

end
      
endmodule
