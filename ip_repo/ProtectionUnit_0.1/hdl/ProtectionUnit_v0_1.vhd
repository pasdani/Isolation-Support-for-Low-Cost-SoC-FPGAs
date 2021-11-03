library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProtectionUnit_v0_1 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S_AXI_CONFIG
		C_S_AXI_CONFIG_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_CONFIG_ADDR_WIDTH	: integer	:= 4;

		-- Parameters of Axi Slave Bus Interface S_AXI
		C_S_AXI_ID_WIDTH	: integer	:= 1;
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 6;
		C_S_AXI_AWUSER_WIDTH	: integer	:= 0;
		C_S_AXI_ARUSER_WIDTH	: integer	:= 0;
		C_S_AXI_WUSER_WIDTH	: integer	:= 0;
		C_S_AXI_RUSER_WIDTH	: integer	:= 0;
		C_S_AXI_BUSER_WIDTH	: integer	:= 0;

		-- Parameters of Axi Master Bus Interface M_AXI
		C_M_AXI_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M_AXI_BURST_LEN	: integer	:= 16;
		C_M_AXI_ID_WIDTH	: integer	:= 1;
		C_M_AXI_ADDR_WIDTH	: integer	:= 32;
		C_M_AXI_DATA_WIDTH	: integer	:= 32;
		C_M_AXI_AWUSER_WIDTH	: integer	:= 0;
		C_M_AXI_ARUSER_WIDTH	: integer	:= 0;
		C_M_AXI_WUSER_WIDTH	: integer	:= 0;
		C_M_AXI_RUSER_WIDTH	: integer	:= 0;
		C_M_AXI_BUSER_WIDTH	: integer	:= 0
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S_AXI_CONFIG
		s_axi_config_aclk	: in std_logic;
		s_axi_config_aresetn	: in std_logic;
		s_axi_config_awaddr	: in std_logic_vector(C_S_AXI_CONFIG_ADDR_WIDTH-1 downto 0);
		s_axi_config_awprot	: in std_logic_vector(2 downto 0);
		s_axi_config_awvalid	: in std_logic;
		s_axi_config_awready	: out std_logic;
		s_axi_config_wdata	: in std_logic_vector(C_S_AXI_CONFIG_DATA_WIDTH-1 downto 0);
		s_axi_config_wstrb	: in std_logic_vector((C_S_AXI_CONFIG_DATA_WIDTH/8)-1 downto 0);
		s_axi_config_wvalid	: in std_logic;
		s_axi_config_wready	: out std_logic;
		s_axi_config_bresp	: out std_logic_vector(1 downto 0);
		s_axi_config_bvalid	: out std_logic;
		s_axi_config_bready	: in std_logic;
		s_axi_config_araddr	: in std_logic_vector(C_S_AXI_CONFIG_ADDR_WIDTH-1 downto 0);
		s_axi_config_arprot	: in std_logic_vector(2 downto 0);
		s_axi_config_arvalid	: in std_logic;
		s_axi_config_arready	: out std_logic;
		s_axi_config_rdata	: out std_logic_vector(C_S_AXI_CONFIG_DATA_WIDTH-1 downto 0);
		s_axi_config_rresp	: out std_logic_vector(1 downto 0);
		s_axi_config_rvalid	: out std_logic;
		s_axi_config_rready	: in std_logic;

		-- Ports of Axi Slave Bus Interface S_AXI
		s_axi_aclk	: in std_logic;
		s_axi_aresetn	: in std_logic;
		s_axi_awid	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		s_axi_awaddr	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_awlen	: in std_logic_vector(7 downto 0);
		s_axi_awsize	: in std_logic_vector(2 downto 0);
		s_axi_awburst	: in std_logic_vector(1 downto 0);
		s_axi_awlock	: in std_logic;
		s_axi_awcache	: in std_logic_vector(3 downto 0);
		s_axi_awprot	: in std_logic_vector(2 downto 0);
		s_axi_awqos	: in std_logic_vector(3 downto 0);
		s_axi_awregion	: in std_logic_vector(3 downto 0);
		s_axi_awuser	: in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		s_axi_awvalid	: in std_logic;
		s_axi_awready	: out std_logic;
		s_axi_wdata	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_wstrb	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		s_axi_wlast	: in std_logic;
		s_axi_wuser	: in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		s_axi_wvalid	: in std_logic;
		s_axi_wready	: out std_logic;
		s_axi_bid	: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		s_axi_bresp	: out std_logic_vector(1 downto 0);
		s_axi_buser	: out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		s_axi_bvalid	: out std_logic;
		s_axi_bready	: in std_logic;
		s_axi_arid	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		s_axi_araddr	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_arlen	: in std_logic_vector(7 downto 0);
		s_axi_arsize	: in std_logic_vector(2 downto 0);
		s_axi_arburst	: in std_logic_vector(1 downto 0);
		s_axi_arlock	: in std_logic;
		s_axi_arcache	: in std_logic_vector(3 downto 0);
		s_axi_arprot	: in std_logic_vector(2 downto 0);
		s_axi_arqos	: in std_logic_vector(3 downto 0);
		s_axi_arregion	: in std_logic_vector(3 downto 0);
		s_axi_aruser	: in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		s_axi_arvalid	: in std_logic;
		s_axi_arready	: out std_logic;
		s_axi_rid	: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		s_axi_rdata	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_rresp	: out std_logic_vector(1 downto 0);
		s_axi_rlast	: out std_logic;
		s_axi_ruser	: out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		s_axi_rvalid	: out std_logic;
		s_axi_rready	: in std_logic;

		-- Ports of Axi Master Bus Interface M_AXI
		m_axi_init_axi_txn	: in std_logic;
		m_axi_txn_done	: out std_logic;
		m_axi_error	: out std_logic;
		m_axi_aclk	: in std_logic;
		m_axi_aresetn	: in std_logic;
		m_axi_awid	: out std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		m_axi_awaddr	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		m_axi_awlen	: out std_logic_vector(7 downto 0);
		m_axi_awsize	: out std_logic_vector(2 downto 0);
		m_axi_awburst	: out std_logic_vector(1 downto 0);
		m_axi_awlock	: out std_logic;
		m_axi_awcache	: out std_logic_vector(3 downto 0);
		m_axi_awprot	: out std_logic_vector(2 downto 0);
		m_axi_awqos	: out std_logic_vector(3 downto 0);
		m_axi_awuser	: out std_logic_vector(C_M_AXI_AWUSER_WIDTH-1 downto 0);
		m_axi_awvalid	: out std_logic;
		m_axi_awready	: in std_logic;
		m_axi_wdata	: out std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		m_axi_wstrb	: out std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
		m_axi_wlast	: out std_logic;
		m_axi_wuser	: out std_logic_vector(C_M_AXI_WUSER_WIDTH-1 downto 0);
		m_axi_wvalid	: out std_logic;
		m_axi_wready	: in std_logic;
		m_axi_bid	: in std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		m_axi_bresp	: in std_logic_vector(1 downto 0);
		m_axi_buser	: in std_logic_vector(C_M_AXI_BUSER_WIDTH-1 downto 0);
		m_axi_bvalid	: in std_logic;
		m_axi_bready	: out std_logic;
		m_axi_arid	: out std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		m_axi_araddr	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		m_axi_arlen	: out std_logic_vector(7 downto 0);
		m_axi_arsize	: out std_logic_vector(2 downto 0);
		m_axi_arburst	: out std_logic_vector(1 downto 0);
		m_axi_arlock	: out std_logic;
		m_axi_arcache	: out std_logic_vector(3 downto 0);
		m_axi_arprot	: out std_logic_vector(2 downto 0);
		m_axi_arqos	: out std_logic_vector(3 downto 0);
		m_axi_aruser	: out std_logic_vector(C_M_AXI_ARUSER_WIDTH-1 downto 0);
		m_axi_arvalid	: out std_logic;
		m_axi_arready	: in std_logic;
		m_axi_rid	: in std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		m_axi_rdata	: in std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		m_axi_rresp	: in std_logic_vector(1 downto 0);
		m_axi_rlast	: in std_logic;
		m_axi_ruser	: in std_logic_vector(C_M_AXI_RUSER_WIDTH-1 downto 0);
		m_axi_rvalid	: in std_logic;
		m_axi_rready	: out std_logic
	);
end ProtectionUnit_v0_1;

architecture arch_imp of ProtectionUnit_v0_1 is

	-- component declaration
	component ProtectionUnit_v0_1_S_AXI_CONFIG is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component ProtectionUnit_v0_1_S_AXI_CONFIG;

	component ProtectionUnit_v0_1_S_AXI is
		generic (
		C_S_AXI_ID_WIDTH	: integer	:= 1;
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 6;
		C_S_AXI_AWUSER_WIDTH	: integer	:= 0;
		C_S_AXI_ARUSER_WIDTH	: integer	:= 0;
		C_S_AXI_WUSER_WIDTH	: integer	:= 0;
		C_S_AXI_RUSER_WIDTH	: integer	:= 0;
		C_S_AXI_BUSER_WIDTH	: integer	:= 0
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWID	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWLEN	: in std_logic_vector(7 downto 0);
		S_AXI_AWSIZE	: in std_logic_vector(2 downto 0);
		S_AXI_AWBURST	: in std_logic_vector(1 downto 0);
		S_AXI_AWLOCK	: in std_logic;
		S_AXI_AWCACHE	: in std_logic_vector(3 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWQOS	: in std_logic_vector(3 downto 0);
		S_AXI_AWREGION	: in std_logic_vector(3 downto 0);
		S_AXI_AWUSER	: in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WLAST	: in std_logic;
		S_AXI_WUSER	: in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BID	: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BUSER	: out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARID	: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARLEN	: in std_logic_vector(7 downto 0);
		S_AXI_ARSIZE	: in std_logic_vector(2 downto 0);
		S_AXI_ARBURST	: in std_logic_vector(1 downto 0);
		S_AXI_ARLOCK	: in std_logic;
		S_AXI_ARCACHE	: in std_logic_vector(3 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARQOS	: in std_logic_vector(3 downto 0);
		S_AXI_ARREGION	: in std_logic_vector(3 downto 0);
		S_AXI_ARUSER	: in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RID	: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RLAST	: out std_logic;
		S_AXI_RUSER	: out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component ProtectionUnit_v0_1_S_AXI;

	component ProtectionUnit_v0_1_M_AXI is
		generic (
		C_M_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_M_AXI_BURST_LEN	: integer	:= 16;
		C_M_AXI_ID_WIDTH	: integer	:= 1;
		C_M_AXI_ADDR_WIDTH	: integer	:= 32;
		C_M_AXI_DATA_WIDTH	: integer	:= 32;
		C_M_AXI_AWUSER_WIDTH	: integer	:= 0;
		C_M_AXI_ARUSER_WIDTH	: integer	:= 0;
		C_M_AXI_WUSER_WIDTH	: integer	:= 0;
		C_M_AXI_RUSER_WIDTH	: integer	:= 0;
		C_M_AXI_BUSER_WIDTH	: integer	:= 0
		);
		port (
		INIT_AXI_TXN	: in std_logic;
		TXN_DONE	: out std_logic;
		ERROR	: out std_logic;
		M_AXI_ACLK	: in std_logic;
		M_AXI_ARESETN	: in std_logic;
		M_AXI_AWID	: out std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		M_AXI_AWADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_AWLEN	: out std_logic_vector(7 downto 0);
		M_AXI_AWSIZE	: out std_logic_vector(2 downto 0);
		M_AXI_AWBURST	: out std_logic_vector(1 downto 0);
		M_AXI_AWLOCK	: out std_logic;
		M_AXI_AWCACHE	: out std_logic_vector(3 downto 0);
		M_AXI_AWPROT	: out std_logic_vector(2 downto 0);
		M_AXI_AWQOS	: out std_logic_vector(3 downto 0);
		M_AXI_AWUSER	: out std_logic_vector(C_M_AXI_AWUSER_WIDTH-1 downto 0);
		M_AXI_AWVALID	: out std_logic;
		M_AXI_AWREADY	: in std_logic;
		M_AXI_WDATA	: out std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_WSTRB	: out std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
		M_AXI_WLAST	: out std_logic;
		M_AXI_WUSER	: out std_logic_vector(C_M_AXI_WUSER_WIDTH-1 downto 0);
		M_AXI_WVALID	: out std_logic;
		M_AXI_WREADY	: in std_logic;
		M_AXI_BID	: in std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		M_AXI_BRESP	: in std_logic_vector(1 downto 0);
		M_AXI_BUSER	: in std_logic_vector(C_M_AXI_BUSER_WIDTH-1 downto 0);
		M_AXI_BVALID	: in std_logic;
		M_AXI_BREADY	: out std_logic;
		M_AXI_ARID	: out std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		M_AXI_ARADDR	: out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_ARLEN	: out std_logic_vector(7 downto 0);
		M_AXI_ARSIZE	: out std_logic_vector(2 downto 0);
		M_AXI_ARBURST	: out std_logic_vector(1 downto 0);
		M_AXI_ARLOCK	: out std_logic;
		M_AXI_ARCACHE	: out std_logic_vector(3 downto 0);
		M_AXI_ARPROT	: out std_logic_vector(2 downto 0);
		M_AXI_ARQOS	: out std_logic_vector(3 downto 0);
		M_AXI_ARUSER	: out std_logic_vector(C_M_AXI_ARUSER_WIDTH-1 downto 0);
		M_AXI_ARVALID	: out std_logic;
		M_AXI_ARREADY	: in std_logic;
		M_AXI_RID	: in std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
		M_AXI_RDATA	: in std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_RRESP	: in std_logic_vector(1 downto 0);
		M_AXI_RLAST	: in std_logic;
		M_AXI_RUSER	: in std_logic_vector(C_M_AXI_RUSER_WIDTH-1 downto 0);
		M_AXI_RVALID	: in std_logic;
		M_AXI_RREADY	: out std_logic
		);
	end component ProtectionUnit_v0_1_M_AXI;

begin

-- Instantiation of Axi Bus Interface S_AXI_CONFIG
ProtectionUnit_v0_1_S_AXI_CONFIG_inst : ProtectionUnit_v0_1_S_AXI_CONFIG
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S_AXI_CONFIG_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S_AXI_CONFIG_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> s_axi_config_aclk,
		S_AXI_ARESETN	=> s_axi_config_aresetn,
		S_AXI_AWADDR	=> s_axi_config_awaddr,
		S_AXI_AWPROT	=> s_axi_config_awprot,
		S_AXI_AWVALID	=> s_axi_config_awvalid,
		S_AXI_AWREADY	=> s_axi_config_awready,
		S_AXI_WDATA	=> s_axi_config_wdata,
		S_AXI_WSTRB	=> s_axi_config_wstrb,
		S_AXI_WVALID	=> s_axi_config_wvalid,
		S_AXI_WREADY	=> s_axi_config_wready,
		S_AXI_BRESP	=> s_axi_config_bresp,
		S_AXI_BVALID	=> s_axi_config_bvalid,
		S_AXI_BREADY	=> s_axi_config_bready,
		S_AXI_ARADDR	=> s_axi_config_araddr,
		S_AXI_ARPROT	=> s_axi_config_arprot,
		S_AXI_ARVALID	=> s_axi_config_arvalid,
		S_AXI_ARREADY	=> s_axi_config_arready,
		S_AXI_RDATA	=> s_axi_config_rdata,
		S_AXI_RRESP	=> s_axi_config_rresp,
		S_AXI_RVALID	=> s_axi_config_rvalid,
		S_AXI_RREADY	=> s_axi_config_rready
	);

-- Instantiation of Axi Bus Interface S_AXI
ProtectionUnit_v0_1_S_AXI_inst : ProtectionUnit_v0_1_S_AXI
	generic map (
		C_S_AXI_ID_WIDTH	=> C_S_AXI_ID_WIDTH,
		C_S_AXI_DATA_WIDTH	=> C_S_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S_AXI_ADDR_WIDTH,
		C_S_AXI_AWUSER_WIDTH	=> C_S_AXI_AWUSER_WIDTH,
		C_S_AXI_ARUSER_WIDTH	=> C_S_AXI_ARUSER_WIDTH,
		C_S_AXI_WUSER_WIDTH	=> C_S_AXI_WUSER_WIDTH,
		C_S_AXI_RUSER_WIDTH	=> C_S_AXI_RUSER_WIDTH,
		C_S_AXI_BUSER_WIDTH	=> C_S_AXI_BUSER_WIDTH
	)
	port map (
		S_AXI_ACLK	=> s_axi_aclk,
		S_AXI_ARESETN	=> s_axi_aresetn,
		S_AXI_AWID	=> s_axi_awid,
		S_AXI_AWADDR	=> s_axi_awaddr,
		S_AXI_AWLEN	=> s_axi_awlen,
		S_AXI_AWSIZE	=> s_axi_awsize,
		S_AXI_AWBURST	=> s_axi_awburst,
		S_AXI_AWLOCK	=> s_axi_awlock,
		S_AXI_AWCACHE	=> s_axi_awcache,
		S_AXI_AWPROT	=> s_axi_awprot,
		S_AXI_AWQOS	=> s_axi_awqos,
		S_AXI_AWREGION	=> s_axi_awregion,
		S_AXI_AWUSER	=> s_axi_awuser,
		S_AXI_AWVALID	=> s_axi_awvalid,
		S_AXI_AWREADY	=> s_axi_awready,
		S_AXI_WDATA	=> s_axi_wdata,
		S_AXI_WSTRB	=> s_axi_wstrb,
		S_AXI_WLAST	=> s_axi_wlast,
		S_AXI_WUSER	=> s_axi_wuser,
		S_AXI_WVALID	=> s_axi_wvalid,
		S_AXI_WREADY	=> s_axi_wready,
		S_AXI_BID	=> s_axi_bid,
		S_AXI_BRESP	=> s_axi_bresp,
		S_AXI_BUSER	=> s_axi_buser,
		S_AXI_BVALID	=> s_axi_bvalid,
		S_AXI_BREADY	=> s_axi_bready,
		S_AXI_ARID	=> s_axi_arid,
		S_AXI_ARADDR	=> s_axi_araddr,
		S_AXI_ARLEN	=> s_axi_arlen,
		S_AXI_ARSIZE	=> s_axi_arsize,
		S_AXI_ARBURST	=> s_axi_arburst,
		S_AXI_ARLOCK	=> s_axi_arlock,
		S_AXI_ARCACHE	=> s_axi_arcache,
		S_AXI_ARPROT	=> s_axi_arprot,
		S_AXI_ARQOS	=> s_axi_arqos,
		S_AXI_ARREGION	=> s_axi_arregion,
		S_AXI_ARUSER	=> s_axi_aruser,
		S_AXI_ARVALID	=> s_axi_arvalid,
		S_AXI_ARREADY	=> s_axi_arready,
		S_AXI_RID	=> s_axi_rid,
		S_AXI_RDATA	=> s_axi_rdata,
		S_AXI_RRESP	=> s_axi_rresp,
		S_AXI_RLAST	=> s_axi_rlast,
		S_AXI_RUSER	=> s_axi_ruser,
		S_AXI_RVALID	=> s_axi_rvalid,
		S_AXI_RREADY	=> s_axi_rready
	);

-- Instantiation of Axi Bus Interface M_AXI
ProtectionUnit_v0_1_M_AXI_inst : ProtectionUnit_v0_1_M_AXI
	generic map (
		C_M_TARGET_SLAVE_BASE_ADDR	=> C_M_AXI_TARGET_SLAVE_BASE_ADDR,
		C_M_AXI_BURST_LEN	=> C_M_AXI_BURST_LEN,
		C_M_AXI_ID_WIDTH	=> C_M_AXI_ID_WIDTH,
		C_M_AXI_ADDR_WIDTH	=> C_M_AXI_ADDR_WIDTH,
		C_M_AXI_DATA_WIDTH	=> C_M_AXI_DATA_WIDTH,
		C_M_AXI_AWUSER_WIDTH	=> C_M_AXI_AWUSER_WIDTH,
		C_M_AXI_ARUSER_WIDTH	=> C_M_AXI_ARUSER_WIDTH,
		C_M_AXI_WUSER_WIDTH	=> C_M_AXI_WUSER_WIDTH,
		C_M_AXI_RUSER_WIDTH	=> C_M_AXI_RUSER_WIDTH,
		C_M_AXI_BUSER_WIDTH	=> C_M_AXI_BUSER_WIDTH
	)
	port map (
		INIT_AXI_TXN	=> m_axi_init_axi_txn,
		TXN_DONE	=> m_axi_txn_done,
		ERROR	=> m_axi_error,
		M_AXI_ACLK	=> m_axi_aclk,
		M_AXI_ARESETN	=> m_axi_aresetn,
		M_AXI_AWID	=> m_axi_awid,
		M_AXI_AWADDR	=> m_axi_awaddr,
		M_AXI_AWLEN	=> m_axi_awlen,
		M_AXI_AWSIZE	=> m_axi_awsize,
		M_AXI_AWBURST	=> m_axi_awburst,
		M_AXI_AWLOCK	=> m_axi_awlock,
		M_AXI_AWCACHE	=> m_axi_awcache,
		M_AXI_AWPROT	=> m_axi_awprot,
		M_AXI_AWQOS	=> m_axi_awqos,
		M_AXI_AWUSER	=> m_axi_awuser,
		M_AXI_AWVALID	=> m_axi_awvalid,
		M_AXI_AWREADY	=> m_axi_awready,
		M_AXI_WDATA	=> m_axi_wdata,
		M_AXI_WSTRB	=> m_axi_wstrb,
		M_AXI_WLAST	=> m_axi_wlast,
		M_AXI_WUSER	=> m_axi_wuser,
		M_AXI_WVALID	=> m_axi_wvalid,
		M_AXI_WREADY	=> m_axi_wready,
		M_AXI_BID	=> m_axi_bid,
		M_AXI_BRESP	=> m_axi_bresp,
		M_AXI_BUSER	=> m_axi_buser,
		M_AXI_BVALID	=> m_axi_bvalid,
		M_AXI_BREADY	=> m_axi_bready,
		M_AXI_ARID	=> m_axi_arid,
		M_AXI_ARADDR	=> m_axi_araddr,
		M_AXI_ARLEN	=> m_axi_arlen,
		M_AXI_ARSIZE	=> m_axi_arsize,
		M_AXI_ARBURST	=> m_axi_arburst,
		M_AXI_ARLOCK	=> m_axi_arlock,
		M_AXI_ARCACHE	=> m_axi_arcache,
		M_AXI_ARPROT	=> m_axi_arprot,
		M_AXI_ARQOS	=> m_axi_arqos,
		M_AXI_ARUSER	=> m_axi_aruser,
		M_AXI_ARVALID	=> m_axi_arvalid,
		M_AXI_ARREADY	=> m_axi_arready,
		M_AXI_RID	=> m_axi_rid,
		M_AXI_RDATA	=> m_axi_rdata,
		M_AXI_RRESP	=> m_axi_rresp,
		M_AXI_RLAST	=> m_axi_rlast,
		M_AXI_RUSER	=> m_axi_ruser,
		M_AXI_RVALID	=> m_axi_rvalid,
		M_AXI_RREADY	=> m_axi_rready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
