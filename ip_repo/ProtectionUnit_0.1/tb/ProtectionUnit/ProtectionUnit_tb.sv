
`timescale 1ns / 1ps
import axi_vip_pkg::*;

module ProtectionUnit_tb_0(
    );

ProtectionUnit_tb DUT();

`include "axi_transactions.svh"

axi_transaction wr_tran;
bit [32-1:0] data = 0;

initial begin
    config_agent = new("config master vip agent",DUT.axi_vip_config.inst.IF);
    config_agent.start_master();

    write(0, 'hF0F0F0F0);
    read(0, data);

end
      
endmodule
