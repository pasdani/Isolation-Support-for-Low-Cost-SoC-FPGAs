LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY AxiIdManipulator_v0_1 IS
	GENERIC (
		-- Users to add parameters here
		C_AXI_ID : STD_LOGIC_VECTOR(16 - 1 DOWNTO 0) := "1010100000000000"; -- TODO: 0000000000000000
		C_AXI_ID_MASK : STD_LOGIC_VECTOR(16 - 1 DOWNTO 0) := "1111100000000000"; -- TODO: 0000000000000000
		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Parameters of both Axi Slave Bus Interface S_AXI and Axi Master Bus Interface M_AXI
		C_S_AXI_ID_WIDTH : INTEGER := 16; -- TODO: 1
		C_M_AXI_ID_WIDTH : INTEGER := 16; -- TODO: 1
		C_S_AXI_DATA_WIDTH : INTEGER := 32;
		C_M_AXI_DATA_WIDTH : INTEGER := 32;
		C_S_AXI_ADDR_WIDTH : INTEGER := 32;
		C_M_AXI_ADDR_WIDTH : INTEGER := 32;
		
		C_S_AXI_AWUSER_WIDTH : INTEGER := 0;
		C_M_AXI_AWUSER_WIDTH : INTEGER := 0;
		C_S_AXI_ARUSER_WIDTH : INTEGER := 0;
		C_M_AXI_ARUSER_WIDTH : INTEGER := 0;
		C_S_AXI_WUSER_WIDTH : INTEGER := 0;
		C_M_AXI_WUSER_WIDTH : INTEGER := 0;
		C_S_AXI_RUSER_WIDTH : INTEGER := 0;
		C_M_AXI_RUSER_WIDTH : INTEGER := 0;
		C_S_AXI_BUSER_WIDTH : INTEGER := 0;
		C_M_AXI_BUSER_WIDTH : INTEGER := 0;

		-- Parameters of Axi Master Bus Interface M_AXI
		C_M_AXI_TARGET_SLAVE_BASE_ADDR : STD_LOGIC_VECTOR := x"40000000";
		C_M_AXI_BURST_LEN : INTEGER := 16
	);
	PORT (
		-- Users to add ports here
		axi_aclk : IN STD_LOGIC;

		-- User ports ends
		-- Do not modify the ports beyond this line
		-- Ports of Axi Slave Bus Interface S_AXI
		s_axi_awid : IN STD_LOGIC_VECTOR(C_S_AXI_ID_WIDTH - 1 DOWNTO 0);
		s_axi_awaddr : IN STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
		s_axi_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		s_axi_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi_awlock : IN STD_LOGIC;
		s_axi_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi_awuser : IN STD_LOGIC_VECTOR(C_S_AXI_AWUSER_WIDTH - 1 DOWNTO 0);
		s_axi_awvalid : IN STD_LOGIC;
		s_axi_awready : OUT STD_LOGIC;
		s_axi_wdata : IN STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
		s_axi_wstrb : IN STD_LOGIC_VECTOR((C_S_AXI_DATA_WIDTH/8) - 1 DOWNTO 0);
		s_axi_wlast : IN STD_LOGIC;
		s_axi_wuser : IN STD_LOGIC_VECTOR(C_S_AXI_WUSER_WIDTH - 1 DOWNTO 0);
		s_axi_wvalid : IN STD_LOGIC;
		s_axi_wready : OUT STD_LOGIC;
		s_axi_bid : OUT STD_LOGIC_VECTOR(C_S_AXI_ID_WIDTH - 1 DOWNTO 0);
		s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi_buser : OUT STD_LOGIC_VECTOR(C_S_AXI_BUSER_WIDTH - 1 DOWNTO 0);
		s_axi_bvalid : OUT STD_LOGIC;
		s_axi_bready : IN STD_LOGIC;
		s_axi_arid : IN STD_LOGIC_VECTOR(C_S_AXI_ID_WIDTH - 1 DOWNTO 0);
		s_axi_araddr : IN STD_LOGIC_VECTOR(C_S_AXI_ADDR_WIDTH - 1 DOWNTO 0);
		s_axi_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		s_axi_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi_arlock : IN STD_LOGIC;
		s_axi_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		s_axi_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		s_axi_aruser : IN STD_LOGIC_VECTOR(C_S_AXI_ARUSER_WIDTH - 1 DOWNTO 0);
		s_axi_arvalid : IN STD_LOGIC;
		s_axi_arready : OUT STD_LOGIC;
		s_axi_rid : OUT STD_LOGIC_VECTOR(C_S_AXI_ID_WIDTH - 1 DOWNTO 0);
		s_axi_rdata : OUT STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
		s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		s_axi_rlast : OUT STD_LOGIC;
		s_axi_ruser : OUT STD_LOGIC_VECTOR(C_S_AXI_RUSER_WIDTH - 1 DOWNTO 0);
		s_axi_rvalid : OUT STD_LOGIC;
		s_axi_rready : IN STD_LOGIC;
		-- removed
		-- s_axi_aclk	: in std_logic;
		-- s_axi_aresetn	: in std_logic;

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
		-- m_axi_init_axi_txn	: in std_logic;
		-- m_axi_txn_done	: out std_logic;
		-- m_axi_error	: out std_logic;
		-- m_axi_aclk	: in std_logic;
		-- m_axi_aresetn	: in std_logic;
	);
END AxiIdManipulator_v0_1;

ARCHITECTURE arch_imp OF AxiIdManipulator_v0_1 IS

	SIGNAL last_axi_write_id : STD_LOGIC_VECTOR(16 - 1 DOWNTO 0) := "0000000000000000";
	SIGNAL last_axi_read_id : STD_LOGIC_VECTOR(16 - 1 DOWNTO 0) := "0000000000000000";

	-- Forwards old bits, if they aren't set in mask.
	-- Forwards new bits, if they are set in mask.
	-- The returned vector has always the size of the new_bits vector.
	-- If the the new vector is larger than the old one, bits uneffected by the mask are set to 0.
	-- If the the new vector is smaller than the old one, the result is truncated.
	FUNCTION set_masked_bits(
		old_bits : STD_LOGIC_VECTOR;
		new_bits : STD_LOGIC_VECTOR;
		mask : STD_LOGIC_VECTOR)
		RETURN STD_LOGIC_VECTOR IS
	BEGIN
		RETURN ((old_bits(new_bits'range) AND NOT mask(new_bits'range)) OR 
		  (new_bits AND mask(new_bits'range)));
	END FUNCTION set_masked_bits;

BEGIN
	-- Store most recent ID
	store_id : PROCESS (axi_aclk)
	BEGIN
		IF rising_edge(axi_aclk) THEN
			-- store AWID on address write transfer
			IF s_axi_awvalid = '1' AND m_axi_awready = '1' THEN
				last_axi_write_id(C_S_AXI_ID_WIDTH - 1 DOWNTO 0) <=  s_axi_awid;
			END IF;
			-- store ArID on address read transfer
			IF s_axi_arvalid = '1' AND m_axi_arready = '1' THEN
				last_axi_read_id(C_S_AXI_ID_WIDTH - 1 DOWNTO 0) <= s_axi_arid;
			END IF;
		END IF;
	END PROCESS store_id;

	-- Manipulate IDs
	m_axi_awid <= set_masked_bits(s_axi_awid, C_AXI_ID, C_AXI_ID_MASK);
	s_axi_bid <= set_masked_bits(m_axi_bid, last_axi_write_id, C_AXI_ID_MASK);
	m_axi_arid <= set_masked_bits(s_axi_arid, C_AXI_ID, C_AXI_ID_MASK);
	s_axi_rid <= set_masked_bits(m_axi_rid, last_axi_read_id, C_AXI_ID_MASK);

	-- Forward signals
	m_axi_awaddr <= s_axi_awaddr;
	m_axi_awlen <= s_axi_awlen;
	m_axi_awsize <= s_axi_awsize;
	m_axi_awburst <= s_axi_awburst;
	m_axi_awlock <= s_axi_awlock;
	m_axi_awcache <= s_axi_awcache;
	m_axi_awprot <= s_axi_awprot;
	m_axi_awqos <= s_axi_awqos;
	m_axi_awuser <= s_axi_awuser;
	m_axi_awvalid <= s_axi_awvalid;
	s_axi_awready <= m_axi_awready;
	m_axi_wdata <= s_axi_wdata;
	m_axi_wstrb <= s_axi_wstrb;
	m_axi_wlast <= s_axi_wlast;
	m_axi_wuser <= s_axi_wuser;
	m_axi_wvalid <= s_axi_wvalid;
	s_axi_wready <= m_axi_wready;
	s_axi_bresp <= m_axi_bresp;
	s_axi_buser <= m_axi_buser;
	s_axi_bvalid <= m_axi_bvalid;
	m_axi_bready <= s_axi_bready;
	m_axi_araddr <= s_axi_araddr;
	m_axi_arlen <= s_axi_arlen;
	m_axi_arsize <= s_axi_arsize;
	m_axi_arburst <= s_axi_arburst;
	m_axi_arlock <= s_axi_arlock;
	m_axi_arcache <= s_axi_arcache;
	m_axi_arprot <= s_axi_arprot;
	m_axi_arqos <= s_axi_arqos;
	m_axi_aruser <= s_axi_aruser;
	m_axi_arvalid <= s_axi_arvalid;
	s_axi_arready <= m_axi_arready;
	s_axi_rdata <= m_axi_rdata;
	s_axi_rresp <= m_axi_rresp;
	s_axi_rlast <= m_axi_rlast;
	s_axi_ruser <= m_axi_ruser;
	s_axi_rvalid <= m_axi_rvalid;
	m_axi_rready <= s_axi_rready;

	-- Unused signal
	-- s_axi_awregion : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
	-- s_axi_arregion : IN STD_LOGIC_VECTOR(3 DOWNTO 0)

END arch_imp;