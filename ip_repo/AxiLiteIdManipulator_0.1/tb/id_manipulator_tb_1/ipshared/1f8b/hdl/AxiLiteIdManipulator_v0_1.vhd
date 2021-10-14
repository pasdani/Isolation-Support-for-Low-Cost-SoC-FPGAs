LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY AxiLiteIdManipulator_v0_1 IS
	GENERIC (
		-- Users to add parameters here
		C_AXI_ID : STD_LOGIC_VECTOR(16-1 DOWNTO 0)  := "0000000000000000";
		-- User parameters ends

		-- Parameters of both Axi Slave Bus Interface S_AXI and Axi Master Bus Interface M_AXI
		C_S_AXI_DATA_WIDTH : INTEGER := 32;
		C_S_AXI_ADDR_WIDTH : INTEGER := 32;
		C_M_AXI_DATA_WIDTH : INTEGER := 32;
		C_M_AXI_ADDR_WIDTH : INTEGER := 32;

		-- Parameters of Axi Master Bus Interface M_AXI
		C_M_AXI_TARGET_SLAVE_BASE_ADDR : STD_LOGIC_VECTOR := x"40000000";
		C_M_AXI_ID_WIDTH : INTEGER := 1;
		C_M_AXI_AWUSER_WIDTH : INTEGER := 0;
		C_M_AXI_ARUSER_WIDTH : INTEGER := 0;
		C_M_AXI_WUSER_WIDTH : INTEGER := 0;
		C_M_AXI_RUSER_WIDTH : INTEGER := 0;
		C_M_AXI_BUSER_WIDTH : INTEGER := 0

	);
	PORT (
		-- Users to add ports here
		axi_aclk : IN STD_LOGIC;
		
		-- User ports ends
		-- Do not modify the ports beyond this line
		-- Ports of Axi Slave Bus Interface S_AXI
		s_axi_awaddr : IN STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
		s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi_awvalid : IN STD_LOGIC;
		s_axi_awready : OUT STD_LOGIC;
		s_axi_wdata : IN STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
		s_axi_wstrb : IN STD_LOGIC_VECTOR((C_S_AXI_DATA_WIDTH/8) - 1 DOWNTO 0);
		s_axi_wvalid : IN STD_LOGIC;
		s_axi_wready : OUT STD_LOGIC;
		s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi_bvalid : OUT STD_LOGIC;
		s_axi_bready : IN STD_LOGIC;
		s_axi_araddr : IN STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
		s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi_arvalid : IN STD_LOGIC;
		s_axi_arready : OUT STD_LOGIC;
		s_axi_rdata : OUT STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
		s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi_rvalid : OUT STD_LOGIC;
		s_axi_rready : IN STD_LOGIC;
		-- removed		
		  -- s_axi_aclk : IN STD_LOGIC;
		  -- s_axi_aresetn : IN STD_LOGIC;

		-- Ports of Axi Master Bus Interface M_AXI
		m_axi_awid : OUT STD_LOGIC_VECTOR(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
		m_axi_awaddr : OUT STD_LOGIC_VECTOR(C_M_AXI_ADDR_WIDTH - 1 DOWNTO 0);
		m_axi_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		m_axi_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		m_axi_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		m_axi_awlock : OUT STD_LOGIC;
		m_axi_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		m_axi_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		m_axi_awqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		m_axi_awuser : OUT STD_LOGIC_VECTOR(C_M_AXI_AWUSER_WIDTH - 1 DOWNTO 0);
		m_axi_awvalid : OUT STD_LOGIC;
		m_axi_awready : IN STD_LOGIC;
		m_axi_wdata : OUT STD_LOGIC_VECTOR(C_M_AXI_DATA_WIDTH - 1 DOWNTO 0);
		m_axi_wstrb : OUT STD_LOGIC_VECTOR(C_M_AXI_DATA_WIDTH/8 - 1 DOWNTO 0);
		m_axi_wlast : OUT STD_LOGIC;
		m_axi_wuser : OUT STD_LOGIC_VECTOR(C_M_AXI_WUSER_WIDTH - 1 DOWNTO 0);
		m_axi_wvalid : OUT STD_LOGIC;
		m_axi_wready : IN STD_LOGIC;
		m_axi_bid : IN STD_LOGIC_VECTOR(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
		m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		m_axi_buser : IN STD_LOGIC_VECTOR(C_M_AXI_BUSER_WIDTH - 1 DOWNTO 0);
		m_axi_bvalid : IN STD_LOGIC;
		m_axi_bready : OUT STD_LOGIC;
		m_axi_arid : OUT STD_LOGIC_VECTOR(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
		m_axi_araddr : OUT STD_LOGIC_VECTOR(C_M_AXI_ADDR_WIDTH - 1 DOWNTO 0);
		m_axi_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		m_axi_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		m_axi_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		m_axi_arlock : OUT STD_LOGIC;
		m_axi_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		m_axi_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		m_axi_arqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		m_axi_aruser : OUT STD_LOGIC_VECTOR(C_M_AXI_ARUSER_WIDTH - 1 DOWNTO 0);
		m_axi_arvalid : OUT STD_LOGIC;
		m_axi_arready : IN STD_LOGIC;
		m_axi_rid : IN STD_LOGIC_VECTOR(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
		m_axi_rdata : IN STD_LOGIC_VECTOR(C_M_AXI_DATA_WIDTH - 1 DOWNTO 0);
		m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		m_axi_rlast : IN STD_LOGIC;
		m_axi_ruser : IN STD_LOGIC_VECTOR(C_M_AXI_RUSER_WIDTH - 1 DOWNTO 0);
		m_axi_rvalid : IN STD_LOGIC;
		m_axi_rready : OUT STD_LOGIC
		-- removed
		  -- m_axi_txn_done : OUT STD_LOGIC;
		  -- m_axi_error : OUT STD_LOGIC;
		  -- m_axi_init_axi_txn : IN STD_LOGIC;
		  -- m_axi_aclk : IN STD_LOGIC;
		  -- m_axi_aresetn : IN STD_LOGIC;
		
	);
END AxiLiteIdManipulator_v0_1;

ARCHITECTURE arch_imp OF AxiLiteIdManipulator_v0_1 IS
BEGIN
	-- Set AXI ID
	m_axi_awid <= C_AXI_ID(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
	m_axi_arid <= C_AXI_ID(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);

	-- Forwarding of the AXI Lite signals
	m_axi_awaddr <= s_axi_awaddr;
	m_axi_awprot <= s_axi_awprot;
	m_axi_awvalid <= s_axi_awvalid;
	s_axi_awready <= m_axi_awready;
	m_axi_wdata <= s_axi_wdata;
	m_axi_wstrb <= s_axi_wstrb;
	m_axi_wvalid <= s_axi_wvalid;
	s_axi_wready <= m_axi_wready;
	s_axi_bresp <= m_axi_bresp;
	s_axi_bvalid <= m_axi_bvalid;
	m_axi_bready <= s_axi_bready;
	m_axi_araddr <= s_axi_araddr;
	m_axi_arprot <= s_axi_arprot;
	m_axi_arvalid <= s_axi_arvalid;
	s_axi_arready <= m_axi_arready;
	s_axi_rdata <= m_axi_rdata;
	s_axi_rresp <= m_axi_rresp;
	s_axi_rvalid <= m_axi_rvalid;
	m_axi_rready <= s_axi_rready;

	-- Setting default values for signal not used by Axi Lite
	-- Explanations are taken from Section B1.1 of the AMBA AXI and ACE Protocol (22 February 2013)
	m_axi_awlen <= (OTHERS => '0'); -- The burst length is defined to be 1, equivalent to an AxLEN value of zero.
	m_axi_arlen <= (OTHERS => '0');
	m_axi_awsize <= "101" WHEN C_M_AXI_DATA_WIDTH = 32 ELSE
		"110"; -- AWSIZE, ARSIZE All accesses are defined to be the width of the data bus. 
	-- AXI4-Lite requires a fixed data bus width of either 32-bit or 64-bit.	
	-- 0b101 -> 32-bit, 0b110 -> 64-bit
	m_axi_arsize <= "101" WHEN C_M_AXI_DATA_WIDTH = 32 ELSE 
		"110";
	m_axi_awburst <= (OTHERS => '0'); -- The burst type has no meaning because the burst length is 1.
	m_axi_arburst <= (OTHERS => '0');
	m_axi_awlock <= '0'; -- All accesses are defined as Normal accesses, equivalent to an AxLOCK value of zero.
	m_axi_arlock <= '0';
	m_axi_awcache <= "0000"; --All accesses are defined as Non-modifiable, Non-bufferable, equivalent to an AxCACHE value of 0b0000.
	m_axi_arcache <= "0000";
	m_axi_awqos <= "0000"; -- A default value of 0b0000 indicates that the interface is not participating in any QoS scheme.
	m_axi_arqos <= "0000";
	m_axi_wlast <= '1'; --All bursts are defined to be of length 1, equivalent to a WLAST or RLAST value of 1.

	-- Unused signals
	-- s_axi_aclk : IN STD_LOGIC;
	-- s_axi_aresetn : IN STD_LOGIC;
	-- m_axi_init_axi_txn : IN STD_LOGIC;
	-- m_axi_txn_done : OUT STD_LOGIC;
	-- m_axi_error : OUT STD_LOGIC;
	-- m_axi_aclk : IN STD_LOGIC;
	-- m_axi_aresetn : IN STD_LOGIC;
	-- m_axi_bid : IN STD_LOGIC_VECTOR(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
	-- m_axi_rid : IN STD_LOGIC_VECTOR(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
	-- m_axi_awuser : OUT STD_LOGIC_VECTOR(C_M_AXI_AWUSER_WIDTH - 1 DOWNTO 0);
	-- m_axi_wuser : OUT STD_LOGIC_VECTOR(C_M_AXI_WUSER_WIDTH - 1 DOWNTO 0);
	-- m_axi_buser : IN STD_LOGIC_VECTOR(C_M_AXI_BUSER_WIDTH - 1 DOWNTO 0);
	-- m_axi_aruser : OUT STD_LOGIC_VECTOR(C_M_AXI_ARUSER_WIDTH - 1 DOWNTO 0);
	-- m_axi_ruser : IN STD_LOGIC_VECTOR(C_M_AXI_RUSER_WIDTH - 1 DOWNTO 0);
	-- m_axi_rlast : IN STD_LOGIC;
END arch_imp;