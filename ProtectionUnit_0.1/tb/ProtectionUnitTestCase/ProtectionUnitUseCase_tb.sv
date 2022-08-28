
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


import ProtectionUnitTestCase_tb_axi_vip_config_0_pkg::*;
ProtectionUnitTestCase_tb_axi_vip_config_0_mst_t config_agent;
import ProtectionUnitTestCase_tb_axi_vip_master_0_pkg::*;
ProtectionUnitTestCase_tb_axi_vip_master_0_mst_t mst_0_agent;
import ProtectionUnitTestCase_tb_axi_vip_master_1_pkg::*;
ProtectionUnitTestCase_tb_axi_vip_master_1_mst_t mst_1_agent;
import ProtectionUnitTestCase_tb_axi_vip_slave_0_pkg::*;
ProtectionUnitTestCase_tb_axi_vip_slave_0_slv_t slv_0_agent;
import ProtectionUnitTestCase_tb_axi_vip_slave_1_pkg::*;
ProtectionUnitTestCase_tb_axi_vip_slave_1_slv_t slv_1_agent;

bit [32-1:0] data = 0;

initial begin
    config_agent = new("config master vip agent",DUT.axi_vip_config.inst.IF);
    config_agent.start_master();

    // Write some stuff to config register
    write('0, 32'hF0F0F0F0);
    read('0, data);
    
    // Write to policy of Protection Unit 0 register
    write('h40, 32'h0000002C); // ID 0 is r/w, ID is ro  
    read('h40, data);

    // Write to policy of Protection Unit 1 register
    write('h10040, 32'h00000038); // ID 0 is ro, ID is r/w  
    read('h10040, data);
   
    fork
      mst_0_start_stimulus();
      mst_1_start_stimulus();
      slv_0_start_stimulus();
      slv_1_start_stimulus();
    join;
    $finish;

end
      
endmodule
