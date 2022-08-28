LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY AxiIdManipulator_v0_1_tb IS
END AxiIdManipulator_v0_1_tb;

ARCHITECTURE Behavioral OF AxiIdManipulator_v0_1_tb IS

    COMPONENT AxiIdManipulator_v0_1
        GENERIC (
            -- Users to add parameters here
            C_AXI_ID : STD_LOGIC_VECTOR(16 - 1 DOWNTO 0) := "0000000000000000";
            C_AXI_ID_MASK : STD_LOGIC_VECTOR(16 - 1 DOWNTO 0) := "0000000000000000";
            -- User parameters ends
            -- Do not modify the parameters beyond this line

            -- Parameters of both Axi Slave Bus Interface S_AXI and Axi Master Bus Interface M_AXI
            C_S_AXI_ID_WIDTH : INTEGER := 1;
            C_M_AXI_ID_WIDTH : INTEGER := 1;
            C_S_AXI_DATA_WIDTH : INTEGER := 32;
            C_M_AXI_DATA_WIDTH : INTEGER := 32;
            C_S_AXI_ADDR_WIDTH : INTEGER := 32;
            C_M_AXI_ADDR_WIDTH : INTEGER := 32;

            -- Parameters of Axi Master Bus Interface M_AXI
            C_M_AXI_TARGET_SLAVE_BASE_ADDR : STD_LOGIC_VECTOR := x"40000000";
            C_M_AXI_BURST_LEN : INTEGER := 16
        );
        PORT (
            axi_aclk : IN STD_LOGIC;

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
            s_axi_awvalid : IN STD_LOGIC;
            s_axi_awready : OUT STD_LOGIC;
            s_axi_wdata : IN STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
            s_axi_wstrb : IN STD_LOGIC_VECTOR((C_S_AXI_DATA_WIDTH/8) - 1 DOWNTO 0);
            s_axi_wlast : IN STD_LOGIC;
            s_axi_wvalid : IN STD_LOGIC;
            s_axi_wready : OUT STD_LOGIC;
            s_axi_bid : OUT STD_LOGIC_VECTOR(C_S_AXI_ID_WIDTH - 1 DOWNTO 0);
            s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
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
            s_axi_arvalid : IN STD_LOGIC;
            s_axi_arready : OUT STD_LOGIC;
            s_axi_rid : OUT STD_LOGIC_VECTOR(C_S_AXI_ID_WIDTH - 1 DOWNTO 0);
            s_axi_rdata : OUT STD_LOGIC_VECTOR(C_S_AXI_DATA_WIDTH - 1 DOWNTO 0);
            s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            s_axi_rlast : OUT STD_LOGIC;
            s_axi_rvalid : OUT STD_LOGIC;
            s_axi_rready : IN STD_LOGIC;

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
            m_axi_awvalid : OUT STD_LOGIC;
            m_axi_awready : IN STD_LOGIC;
            m_axi_wdata : OUT STD_LOGIC_VECTOR(C_M_AXI_DATA_WIDTH - 1 DOWNTO 0);
            m_axi_wstrb : OUT STD_LOGIC_VECTOR(C_M_AXI_DATA_WIDTH/8 - 1 DOWNTO 0);
            m_axi_wlast : OUT STD_LOGIC;
            m_axi_wvalid : OUT STD_LOGIC;
            m_axi_wready : IN STD_LOGIC;
            m_axi_bid : IN STD_LOGIC_VECTOR(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
            m_axi_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
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
            m_axi_arvalid : OUT STD_LOGIC;
            m_axi_arready : IN STD_LOGIC;
            m_axi_rid : IN STD_LOGIC_VECTOR(C_M_AXI_ID_WIDTH - 1 DOWNTO 0);
            m_axi_rdata : IN STD_LOGIC_VECTOR(C_M_AXI_DATA_WIDTH - 1 DOWNTO 0);
            m_axi_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
            m_axi_rlast : IN STD_LOGIC;
            m_axi_rvalid : IN STD_LOGIC;
            m_axi_rready : OUT STD_LOGIC
        );
    END COMPONENT;

    CONSTANT clk_period : TIME := 10 ns;
    CONSTANT AXI_ID_WIDTH : INTEGER := 16;
    CONSTANT AXI_ID : STD_LOGIC_VECTOR := "1111111111111111";
    CONSTANT AXI_ID_MASK : STD_LOGIC_VECTOR := "1010101010101010";

    -- Inputs 
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL w_id_in : STD_LOGIC_VECTOR(AXI_ID_WIDTH - 1 DOWNTO 0);
    SIGNAL awvalid : STD_LOGIC := '0';
    SIGNAL awready : STD_LOGIC := '0';
    SIGNAL bvalid : STD_LOGIC := '0';
    SIGNAL bready : STD_LOGIC := '0';

    SIGNAL r_id_in : STD_LOGIC_VECTOR(AXI_ID_WIDTH - 1 DOWNTO 0);
    SIGNAL arvalid : STD_LOGIC := '0';
    SIGNAL arready : STD_LOGIC := '0';
    SIGNAL rvalid : STD_LOGIC := '0';
    SIGNAL rready : STD_LOGIC := '0';
    -- Outputs
    SIGNAL w_id_out : STD_LOGIC_VECTOR(AXI_ID_WIDTH - 1 DOWNTO 0);
    SIGNAL r_id_out : STD_LOGIC_VECTOR(AXI_ID_WIDTH - 1 DOWNTO 0);

    -- In-/Outputs
    SIGNAL w_id_forward : STD_LOGIC_VECTOR(AXI_ID_WIDTH - 1 DOWNTO 0);
    SIGNAL r_id_forward : STD_LOGIC_VECTOR(AXI_ID_WIDTH - 1 DOWNTO 0);
BEGIN
    uut : AxiIdManipulator_v0_1
    GENERIC MAP(
        C_AXI_ID => AXI_ID,
        C_AXI_ID_MASK => AXI_ID_MASK,
        C_S_AXI_ID_WIDTH => AXI_ID_WIDTH,
        C_M_AXI_ID_WIDTH => AXI_ID_WIDTH
    )
    PORT MAP(
        axi_aclk => clk,
        s_axi_awid => w_id_in,
        s_axi_awvalid => awvalid,
        m_axi_awready => awready,
        m_axi_wready => '0',
        m_axi_bvalid => bvalid,
        s_axi_bready => bready,
        s_axi_arid => r_id_in,
        s_axi_arvalid => arvalid,
        m_axi_arready => arready,
        m_axi_rvalid => rvalid,
        s_axi_rready => rready,

        s_axi_bid => w_id_out,
        s_axi_rid => r_id_out,

        m_axi_awid => w_id_forward,
        m_axi_bid => w_id_forward,
        m_axi_arid => r_id_forward,
        m_axi_rid => r_id_forward,

        --unused
        s_axi_awaddr => (OTHERS => '0'),
        s_axi_awlen => (OTHERS => '0'),
        s_axi_awsize => (OTHERS => '0'),
        s_axi_awburst => (OTHERS => '0'),
        s_axi_awlock => '0',
        s_axi_awcache => (OTHERS => '0'),
        s_axi_awprot => (OTHERS => '0'),
        s_axi_awqos => (OTHERS => '0'),
        s_axi_wdata => (OTHERS => '0'),
        s_axi_wstrb => (OTHERS => '0'),
        s_axi_wlast => '0',
        s_axi_wvalid => '0',
        s_axi_araddr => (OTHERS => '0'),
        s_axi_arlen => (OTHERS => '0'),
        s_axi_arsize => (OTHERS => '0'),
        s_axi_arburst => (OTHERS => '0'),
        s_axi_arlock => '0',
        s_axi_arcache => (OTHERS => '0'),
        s_axi_arprot => (OTHERS => '0'),
        s_axi_arqos => (OTHERS => '0'),
        m_axi_bresp => (OTHERS => '0'),
        m_axi_rdata => (OTHERS => '0'),
        m_axi_rresp => (OTHERS => '0'),
        m_axi_rlast => '0'
    );

    clk_proc : PROCESS
    BEGIN
        clk <= '1';
        WAIT FOR clk_period/2;
        clk <= '0';
        WAIT FOR clk_period/2;
    END PROCESS clk_proc;

    stim_proc : PROCESS
        CONSTANT AXI_ID_1 : STD_LOGIC_VECTOR := "1111111100000000";
    BEGIN
        WAIT FOR 100 ns;
        WAIT FOR clk_period/10;

        -- transfer setting id of write channel to AXI_ID
        w_id_in <= AXI_ID_1;
        awvalid <= '1';
        awready <= '1';
        ASSERT w_id_forward /= ((AXI_ID_1 AND NOT AXI_ID_MASK) OR (AXI_ID AND AXI_ID_MASK))
        REPORT "ID is not manipulated properly"
            SEVERITY error;
        ASSERT w_id_out /= AXI_ID_1
        REPORT "ID is not restored"
            SEVERITY error;
        WAIT FOR clk_period;

        awvalid <= '0';
        awready <= '0';
        WAIT FOR clk_period;

        WAIT;

    END PROCESS stim_proc;
END Behavioral;