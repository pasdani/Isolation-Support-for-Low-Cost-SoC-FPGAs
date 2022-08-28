
`timescale 1ns / 1ps
import axi_vip_pkg::*;

module ProtectionUnit_tb_0(
    );

ProtectionUnit_tb DUT();

`include "axi_transactions.svh"
`include "axi_vip_master_stimulus.svh"
`include "axi_vip_slave_basic_stimulus.svh"

axi_transaction wr_tran;
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
    write('h40, 32'hFFFFFFFF);
    read('h40, data);
   
    fork
      mst_start_stimulus();
      slv_start_stimulus();
    join;

end
      
endmodule
