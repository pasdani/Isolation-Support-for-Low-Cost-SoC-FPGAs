import axi_vip_pkg::*;
import config_reg_tb_axi_vip_config_0_pkg::*;

config_reg_tb_axi_vip_config_0_mst_t mst_agent;

task automatic write( // blocking
    input xil_axi_ulong     addr,
    input bit [32767:0]     data);

  axi_transaction trans;
  trans = mst_agent.wr_driver.create_transaction();

  trans.set_write_cmd(addr);
  trans.set_data_block(data);

  trans.set_driver_return_item_policy(XIL_AXI_PAYLOAD_RETURN);
  mst_agent.wr_driver.send(trans);
  mst_agent.wr_driver.wait_rsp(trans);
endtask //automatic


task automatic read(
    input xil_axi_ulong     addr,
    output bit [32-1:0]     data);

  axi_transaction trans;
  trans = mst_agent.rd_driver.create_transaction();

  trans.set_read_cmd(addr);

  trans.set_driver_return_item_policy(XIL_AXI_PAYLOAD_RETURN);
  mst_agent.rd_driver.send(trans);
  mst_agent.rd_driver.wait_rsp(trans);

  data = trans.get_data_block();
  $display("Read data from Driver: Block Data %h ", data);
endtask //automatic
