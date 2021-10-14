--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
--Date        : Wed Oct 13 15:01:48 2021
--Host        : DESKTOP-18HSEJI running 64-bit major release  (build 9200)
--Command     : generate_target id_manipulator_tb_1.bd
--Design      : id_manipulator_tb_1
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity id_manipulator_tb_1 is
  port (
    clk : in STD_LOGIC;
    done : out STD_LOGIC;
    resetn : in STD_LOGIC;
    status : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of id_manipulator_tb_1 : entity is "id_manipulator_tb_1,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=id_manipulator_tb_1,x_ipVersion=1.00.a,x_ipLanguage=VHDL,numBlks=4,numReposBlks=4,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,da_bram_cntlr_cnt=1,synth_mode=OOC_per_IP}";
  attribute HW_HANDOFF : string;
  attribute HW_HANDOFF of id_manipulator_tb_1 : entity is "id_manipulator_tb_1.hwdef";
end id_manipulator_tb_1;

architecture STRUCTURE of id_manipulator_tb_1 is
  component id_manipulator_tb_1_axi_traffic_gen_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    m_axi_lite_ch1_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_lite_ch1_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_lite_ch1_awvalid : out STD_LOGIC;
    m_axi_lite_ch1_awready : in STD_LOGIC;
    m_axi_lite_ch1_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_lite_ch1_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_lite_ch1_wvalid : out STD_LOGIC;
    m_axi_lite_ch1_wready : in STD_LOGIC;
    m_axi_lite_ch1_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_lite_ch1_bvalid : in STD_LOGIC;
    m_axi_lite_ch1_bready : out STD_LOGIC;
    m_axi_lite_ch1_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_lite_ch1_arvalid : out STD_LOGIC;
    m_axi_lite_ch1_arready : in STD_LOGIC;
    m_axi_lite_ch1_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_lite_ch1_rvalid : in STD_LOGIC;
    m_axi_lite_ch1_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_lite_ch1_rready : out STD_LOGIC;
    done : out STD_LOGIC;
    status : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component id_manipulator_tb_1_axi_traffic_gen_0_0;
  component id_manipulator_tb_1_axi_bram_ctrl_0_0 is
  port (
    s_axi_aclk : in STD_LOGIC;
    s_axi_aresetn : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awlock : in STD_LOGIC;
    s_axi_awcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 12 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arlock : in STD_LOGIC;
    s_axi_arcache : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    bram_rst_a : out STD_LOGIC;
    bram_clk_a : out STD_LOGIC;
    bram_en_a : out STD_LOGIC;
    bram_we_a : out STD_LOGIC_VECTOR ( 3 downto 0 );
    bram_addr_a : out STD_LOGIC_VECTOR ( 12 downto 0 );
    bram_wrdata_a : out STD_LOGIC_VECTOR ( 31 downto 0 );
    bram_rddata_a : in STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component id_manipulator_tb_1_axi_bram_ctrl_0_0;
  component id_manipulator_tb_1_axi_bram_ctrl_0_bram_0 is
  port (
    clka : in STD_LOGIC;
    rsta : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 31 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 );
    rsta_busy : out STD_LOGIC
  );
  end component id_manipulator_tb_1_axi_bram_ctrl_0_bram_0;
  component id_manipulator_tb_1_AxiLiteIdManipulator_0_0 is
  port (
    axi_aclk : in STD_LOGIC;
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arprot : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    m_axi_awid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awaddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_awlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_awsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_awlock : out STD_LOGIC;
    m_axi_awcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_awqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_awuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_awvalid : out STD_LOGIC;
    m_axi_awready : in STD_LOGIC;
    m_axi_wdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_wstrb : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_wlast : out STD_LOGIC;
    m_axi_wuser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_wvalid : out STD_LOGIC;
    m_axi_wready : in STD_LOGIC;
    m_axi_bid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_buser : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_bvalid : in STD_LOGIC;
    m_axi_bready : out STD_LOGIC;
    m_axi_arid : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_araddr : out STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_arlen : out STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axi_arsize : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arburst : out STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_arlock : out STD_LOGIC;
    m_axi_arcache : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_arprot : out STD_LOGIC_VECTOR ( 2 downto 0 );
    m_axi_arqos : out STD_LOGIC_VECTOR ( 3 downto 0 );
    m_axi_aruser : out STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_arvalid : out STD_LOGIC;
    m_axi_arready : in STD_LOGIC;
    m_axi_rid : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    m_axi_rresp : in STD_LOGIC_VECTOR ( 1 downto 0 );
    m_axi_rlast : in STD_LOGIC;
    m_axi_ruser : in STD_LOGIC_VECTOR ( 0 to 0 );
    m_axi_rvalid : in STD_LOGIC;
    m_axi_rready : out STD_LOGIC
  );
  end component id_manipulator_tb_1_AxiLiteIdManipulator_0_0;
  signal AxiLiteIdManipulator_0_M_AXI_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_ARBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_ARCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_ARID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal AxiLiteIdManipulator_0_M_AXI_ARLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_ARLOCK : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_ARPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_ARREADY : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_ARSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_ARVALID : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_AWBURST : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_AWCACHE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_AWID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal AxiLiteIdManipulator_0_M_AXI_AWLEN : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_AWLOCK : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_AWREADY : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_AWSIZE : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_AWVALID : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_BID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal AxiLiteIdManipulator_0_M_AXI_BREADY : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_BVALID : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_RID : STD_LOGIC_VECTOR ( 0 to 0 );
  signal AxiLiteIdManipulator_0_M_AXI_RLAST : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_RREADY : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_RVALID : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_WLAST : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_WREADY : STD_LOGIC;
  signal AxiLiteIdManipulator_0_M_AXI_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal AxiLiteIdManipulator_0_M_AXI_WVALID : STD_LOGIC;
  signal axi_bram_ctrl_0_BRAM_PORTA_ADDR : STD_LOGIC_VECTOR ( 12 downto 0 );
  signal axi_bram_ctrl_0_BRAM_PORTA_CLK : STD_LOGIC;
  signal axi_bram_ctrl_0_BRAM_PORTA_DIN : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_bram_ctrl_0_BRAM_PORTA_DOUT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_bram_ctrl_0_BRAM_PORTA_EN : STD_LOGIC;
  signal axi_bram_ctrl_0_BRAM_PORTA_RST : STD_LOGIC;
  signal axi_bram_ctrl_0_BRAM_PORTA_WE : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_ARADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_ARREADY : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_ARVALID : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_AWADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_AWPROT : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_AWREADY : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_AWVALID : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_BREADY : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_BRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_BVALID : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_RDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_RREADY : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_RRESP : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_RVALID : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_WDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_WREADY : STD_LOGIC;
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_WSTRB : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal axi_traffic_gen_0_M_AXI_LITE_CH1_WVALID : STD_LOGIC;
  signal axi_traffic_gen_0_done : STD_LOGIC;
  signal axi_traffic_gen_0_status : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal clk_1 : STD_LOGIC;
  signal resetn_1 : STD_LOGIC;
  signal NLW_AxiLiteIdManipulator_0_m_axi_arqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_AxiLiteIdManipulator_0_m_axi_aruser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_AxiLiteIdManipulator_0_m_axi_awqos_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_AxiLiteIdManipulator_0_m_axi_awuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_AxiLiteIdManipulator_0_m_axi_wuser_UNCONNECTED : STD_LOGIC_VECTOR ( 0 to 0 );
  signal NLW_axi_bram_ctrl_0_bram_rsta_busy_UNCONNECTED : STD_LOGIC;
begin
  clk_1 <= clk;
  done <= axi_traffic_gen_0_done;
  resetn_1 <= resetn;
  status(31 downto 0) <= axi_traffic_gen_0_status(31 downto 0);
AxiLiteIdManipulator_0: component id_manipulator_tb_1_AxiLiteIdManipulator_0_0
     port map (
      axi_aclk => clk_1,
      m_axi_araddr(31 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARADDR(31 downto 0),
      m_axi_arburst(1 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARBURST(1 downto 0),
      m_axi_arcache(3 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARCACHE(3 downto 0),
      m_axi_arid(0) => AxiLiteIdManipulator_0_M_AXI_ARID(0),
      m_axi_arlen(7 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARLEN(7 downto 0),
      m_axi_arlock => AxiLiteIdManipulator_0_M_AXI_ARLOCK,
      m_axi_arprot(2 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARPROT(2 downto 0),
      m_axi_arqos(3 downto 0) => NLW_AxiLiteIdManipulator_0_m_axi_arqos_UNCONNECTED(3 downto 0),
      m_axi_arready => AxiLiteIdManipulator_0_M_AXI_ARREADY,
      m_axi_arsize(2 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARSIZE(2 downto 0),
      m_axi_aruser(0) => NLW_AxiLiteIdManipulator_0_m_axi_aruser_UNCONNECTED(0),
      m_axi_arvalid => AxiLiteIdManipulator_0_M_AXI_ARVALID,
      m_axi_awaddr(31 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWADDR(31 downto 0),
      m_axi_awburst(1 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWBURST(1 downto 0),
      m_axi_awcache(3 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWCACHE(3 downto 0),
      m_axi_awid(0) => AxiLiteIdManipulator_0_M_AXI_AWID(0),
      m_axi_awlen(7 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWLEN(7 downto 0),
      m_axi_awlock => AxiLiteIdManipulator_0_M_AXI_AWLOCK,
      m_axi_awprot(2 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWPROT(2 downto 0),
      m_axi_awqos(3 downto 0) => NLW_AxiLiteIdManipulator_0_m_axi_awqos_UNCONNECTED(3 downto 0),
      m_axi_awready => AxiLiteIdManipulator_0_M_AXI_AWREADY,
      m_axi_awsize(2 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWSIZE(2 downto 0),
      m_axi_awuser(0) => NLW_AxiLiteIdManipulator_0_m_axi_awuser_UNCONNECTED(0),
      m_axi_awvalid => AxiLiteIdManipulator_0_M_AXI_AWVALID,
      m_axi_bid(0) => AxiLiteIdManipulator_0_M_AXI_BID(0),
      m_axi_bready => AxiLiteIdManipulator_0_M_AXI_BREADY,
      m_axi_bresp(1 downto 0) => AxiLiteIdManipulator_0_M_AXI_BRESP(1 downto 0),
      m_axi_buser(0) => '0',
      m_axi_bvalid => AxiLiteIdManipulator_0_M_AXI_BVALID,
      m_axi_rdata(31 downto 0) => AxiLiteIdManipulator_0_M_AXI_RDATA(31 downto 0),
      m_axi_rid(0) => AxiLiteIdManipulator_0_M_AXI_RID(0),
      m_axi_rlast => AxiLiteIdManipulator_0_M_AXI_RLAST,
      m_axi_rready => AxiLiteIdManipulator_0_M_AXI_RREADY,
      m_axi_rresp(1 downto 0) => AxiLiteIdManipulator_0_M_AXI_RRESP(1 downto 0),
      m_axi_ruser(0) => '0',
      m_axi_rvalid => AxiLiteIdManipulator_0_M_AXI_RVALID,
      m_axi_wdata(31 downto 0) => AxiLiteIdManipulator_0_M_AXI_WDATA(31 downto 0),
      m_axi_wlast => AxiLiteIdManipulator_0_M_AXI_WLAST,
      m_axi_wready => AxiLiteIdManipulator_0_M_AXI_WREADY,
      m_axi_wstrb(3 downto 0) => AxiLiteIdManipulator_0_M_AXI_WSTRB(3 downto 0),
      m_axi_wuser(0) => NLW_AxiLiteIdManipulator_0_m_axi_wuser_UNCONNECTED(0),
      m_axi_wvalid => AxiLiteIdManipulator_0_M_AXI_WVALID,
      s_axi_araddr(31 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_ARADDR(31 downto 0),
      s_axi_arprot(2 downto 0) => B"000",
      s_axi_arready => axi_traffic_gen_0_M_AXI_LITE_CH1_ARREADY,
      s_axi_arvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_ARVALID,
      s_axi_awaddr(31 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_AWADDR(31 downto 0),
      s_axi_awprot(2 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_AWPROT(2 downto 0),
      s_axi_awready => axi_traffic_gen_0_M_AXI_LITE_CH1_AWREADY,
      s_axi_awvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_AWVALID,
      s_axi_bready => axi_traffic_gen_0_M_AXI_LITE_CH1_BREADY,
      s_axi_bresp(1 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_BRESP(1 downto 0),
      s_axi_bvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_BVALID,
      s_axi_rdata(31 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_RDATA(31 downto 0),
      s_axi_rready => axi_traffic_gen_0_M_AXI_LITE_CH1_RREADY,
      s_axi_rresp(1 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_RRESP(1 downto 0),
      s_axi_rvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_RVALID,
      s_axi_wdata(31 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_WDATA(31 downto 0),
      s_axi_wready => axi_traffic_gen_0_M_AXI_LITE_CH1_WREADY,
      s_axi_wstrb(3 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_WSTRB(3 downto 0),
      s_axi_wvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_WVALID
    );
axi_bram_ctrl_0: component id_manipulator_tb_1_axi_bram_ctrl_0_0
     port map (
      bram_addr_a(12 downto 0) => axi_bram_ctrl_0_BRAM_PORTA_ADDR(12 downto 0),
      bram_clk_a => axi_bram_ctrl_0_BRAM_PORTA_CLK,
      bram_en_a => axi_bram_ctrl_0_BRAM_PORTA_EN,
      bram_rddata_a(31 downto 0) => axi_bram_ctrl_0_BRAM_PORTA_DOUT(31 downto 0),
      bram_rst_a => axi_bram_ctrl_0_BRAM_PORTA_RST,
      bram_we_a(3 downto 0) => axi_bram_ctrl_0_BRAM_PORTA_WE(3 downto 0),
      bram_wrdata_a(31 downto 0) => axi_bram_ctrl_0_BRAM_PORTA_DIN(31 downto 0),
      s_axi_aclk => clk_1,
      s_axi_araddr(12 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARADDR(12 downto 0),
      s_axi_arburst(1 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARBURST(1 downto 0),
      s_axi_arcache(3 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARCACHE(3 downto 0),
      s_axi_aresetn => resetn_1,
      s_axi_arid(0) => AxiLiteIdManipulator_0_M_AXI_ARID(0),
      s_axi_arlen(7 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARLEN(7 downto 0),
      s_axi_arlock => AxiLiteIdManipulator_0_M_AXI_ARLOCK,
      s_axi_arprot(2 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARPROT(2 downto 0),
      s_axi_arready => AxiLiteIdManipulator_0_M_AXI_ARREADY,
      s_axi_arsize(2 downto 0) => AxiLiteIdManipulator_0_M_AXI_ARSIZE(2 downto 0),
      s_axi_arvalid => AxiLiteIdManipulator_0_M_AXI_ARVALID,
      s_axi_awaddr(12 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWADDR(12 downto 0),
      s_axi_awburst(1 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWBURST(1 downto 0),
      s_axi_awcache(3 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWCACHE(3 downto 0),
      s_axi_awid(0) => AxiLiteIdManipulator_0_M_AXI_AWID(0),
      s_axi_awlen(7 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWLEN(7 downto 0),
      s_axi_awlock => AxiLiteIdManipulator_0_M_AXI_AWLOCK,
      s_axi_awprot(2 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWPROT(2 downto 0),
      s_axi_awready => AxiLiteIdManipulator_0_M_AXI_AWREADY,
      s_axi_awsize(2 downto 0) => AxiLiteIdManipulator_0_M_AXI_AWSIZE(2 downto 0),
      s_axi_awvalid => AxiLiteIdManipulator_0_M_AXI_AWVALID,
      s_axi_bid(0) => AxiLiteIdManipulator_0_M_AXI_BID(0),
      s_axi_bready => AxiLiteIdManipulator_0_M_AXI_BREADY,
      s_axi_bresp(1 downto 0) => AxiLiteIdManipulator_0_M_AXI_BRESP(1 downto 0),
      s_axi_bvalid => AxiLiteIdManipulator_0_M_AXI_BVALID,
      s_axi_rdata(31 downto 0) => AxiLiteIdManipulator_0_M_AXI_RDATA(31 downto 0),
      s_axi_rid(0) => AxiLiteIdManipulator_0_M_AXI_RID(0),
      s_axi_rlast => AxiLiteIdManipulator_0_M_AXI_RLAST,
      s_axi_rready => AxiLiteIdManipulator_0_M_AXI_RREADY,
      s_axi_rresp(1 downto 0) => AxiLiteIdManipulator_0_M_AXI_RRESP(1 downto 0),
      s_axi_rvalid => AxiLiteIdManipulator_0_M_AXI_RVALID,
      s_axi_wdata(31 downto 0) => AxiLiteIdManipulator_0_M_AXI_WDATA(31 downto 0),
      s_axi_wlast => AxiLiteIdManipulator_0_M_AXI_WLAST,
      s_axi_wready => AxiLiteIdManipulator_0_M_AXI_WREADY,
      s_axi_wstrb(3 downto 0) => AxiLiteIdManipulator_0_M_AXI_WSTRB(3 downto 0),
      s_axi_wvalid => AxiLiteIdManipulator_0_M_AXI_WVALID
    );
axi_bram_ctrl_0_bram: component id_manipulator_tb_1_axi_bram_ctrl_0_bram_0
     port map (
      addra(31 downto 13) => B"0000000000000000000",
      addra(12 downto 0) => axi_bram_ctrl_0_BRAM_PORTA_ADDR(12 downto 0),
      clka => axi_bram_ctrl_0_BRAM_PORTA_CLK,
      dina(31 downto 0) => axi_bram_ctrl_0_BRAM_PORTA_DIN(31 downto 0),
      douta(31 downto 0) => axi_bram_ctrl_0_BRAM_PORTA_DOUT(31 downto 0),
      ena => axi_bram_ctrl_0_BRAM_PORTA_EN,
      rsta => axi_bram_ctrl_0_BRAM_PORTA_RST,
      rsta_busy => NLW_axi_bram_ctrl_0_bram_rsta_busy_UNCONNECTED,
      wea(3 downto 0) => axi_bram_ctrl_0_BRAM_PORTA_WE(3 downto 0)
    );
axi_traffic_gen_0: component id_manipulator_tb_1_axi_traffic_gen_0_0
     port map (
      done => axi_traffic_gen_0_done,
      m_axi_lite_ch1_araddr(31 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_ARADDR(31 downto 0),
      m_axi_lite_ch1_arready => axi_traffic_gen_0_M_AXI_LITE_CH1_ARREADY,
      m_axi_lite_ch1_arvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_ARVALID,
      m_axi_lite_ch1_awaddr(31 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_AWADDR(31 downto 0),
      m_axi_lite_ch1_awprot(2 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_AWPROT(2 downto 0),
      m_axi_lite_ch1_awready => axi_traffic_gen_0_M_AXI_LITE_CH1_AWREADY,
      m_axi_lite_ch1_awvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_AWVALID,
      m_axi_lite_ch1_bready => axi_traffic_gen_0_M_AXI_LITE_CH1_BREADY,
      m_axi_lite_ch1_bresp(1 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_BRESP(1 downto 0),
      m_axi_lite_ch1_bvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_BVALID,
      m_axi_lite_ch1_rdata(31 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_RDATA(31 downto 0),
      m_axi_lite_ch1_rready => axi_traffic_gen_0_M_AXI_LITE_CH1_RREADY,
      m_axi_lite_ch1_rresp(1 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_RRESP(1 downto 0),
      m_axi_lite_ch1_rvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_RVALID,
      m_axi_lite_ch1_wdata(31 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_WDATA(31 downto 0),
      m_axi_lite_ch1_wready => axi_traffic_gen_0_M_AXI_LITE_CH1_WREADY,
      m_axi_lite_ch1_wstrb(3 downto 0) => axi_traffic_gen_0_M_AXI_LITE_CH1_WSTRB(3 downto 0),
      m_axi_lite_ch1_wvalid => axi_traffic_gen_0_M_AXI_LITE_CH1_WVALID,
      s_axi_aclk => clk_1,
      s_axi_aresetn => resetn_1,
      status(31 downto 0) => axi_traffic_gen_0_status(31 downto 0)
    );
end STRUCTURE;
