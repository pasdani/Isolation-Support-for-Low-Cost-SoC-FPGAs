library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;
use work.Common.all;

entity PolicyCheck_tb is
end entity;

architecture rtl of PolicyCheck_tb is
  component PolicyCheck IS
    GENERIC (
        NUM_MEM_REGIONS : INTEGER := 16;
        MAX_NUM_MEM_REGIONS : INTEGER := 16;
        NUM_DOMAINS : INTEGER := 16;
        MAX_NUM_DOMAINS : INTEGER := 16;
        ID_WIDTH : INTEGER := 16;
        ADDR_WIDTH : INTEGER := 32;

        MEM_REGION_0,
        MEM_REGION_1,
        MEM_REGION_2,
        MEM_REGION_3,
        MEM_REGION_4,
        MEM_REGION_5,
        MEM_REGION_6,
        MEM_REGION_7,
        MEM_REGION_8,
        MEM_REGION_9,
        MEM_REGION_10,
        MEM_REGION_11,
        MEM_REGION_12,
        MEM_REGION_13,
        MEM_REGION_14,
        MEM_REGION_15 : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"AC10BF00";

        MEM_REGION_0_LSB,
        MEM_REGION_1_LSB,
        MEM_REGION_2_LSB,
        MEM_REGION_3_LSB,
        MEM_REGION_4_LSB,
        MEM_REGION_5_LSB,
        MEM_REGION_6_LSB,
        MEM_REGION_7_LSB,
        MEM_REGION_8_LSB,
        MEM_REGION_9_LSB,
        MEM_REGION_10_LSB,
        MEM_REGION_11_LSB,
        MEM_REGION_12_LSB,
        MEM_REGION_13_LSB,
        MEM_REGION_14_LSB,
        MEM_REGION_15_LSB : INTEGER RANGE 0 TO 31 := 7;
        
        DOMAIN_0_ID,
        DOMAIN_1_ID,
        DOMAIN_2_ID,
        DOMAIN_3_ID,
        DOMAIN_4_ID,
        DOMAIN_5_ID,
        DOMAIN_6_ID,
        DOMAIN_7_ID,
        DOMAIN_8_ID,
        DOMAIN_9_ID,
        DOMAIN_10_ID,
        DOMAIN_11_ID,
        DOMAIN_12_ID,
        DOMAIN_13_ID,
        DOMAIN_14_ID,
        DOMAIN_15_ID : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"AC10";

        DOMAIN_0_MASK,
        DOMAIN_1_MASK,
        DOMAIN_2_MASK,
        DOMAIN_3_MASK,
        DOMAIN_4_MASK,
        DOMAIN_5_MASK,
        DOMAIN_6_MASK,
        DOMAIN_7_MASK,
        DOMAIN_8_MASK,
        DOMAIN_9_MASK,
        DOMAIN_10_MASK,
        DOMAIN_11_MASK,
        DOMAIN_12_MASK,
        DOMAIN_13_MASK,
        DOMAIN_14_MASK,
        DOMAIN_15_MASK : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"F0F0"

    );
    PORT (
        POLICY : IN POLICY_TYPE(NUM_MEM_REGIONS - 1 DOWNTO 0, NUM_DOMAINS - 1 DOWNTO 0);
        ID : IN STD_LOGIC_VECTOR(ID_WIDTH - 1 DOWNTO 0);
        ADDR : IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
        LEN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        SIZE : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        READ_WRITE : IN STD_LOGIC; -- 0 -> READ, 1 -> WRITE
        GRANTED : OUT STD_LOGIC
    );
END component;

  constant NUM_MEM_REGIONS: integer := 1;
  constant NUM_DOMAINS: integer := 1;
  constant ID_WIDTH : integer := 16;
  constant ADDR_WIDTH : integer := 32;

  constant delay: time := 20 ns;
  
  signal POLICY : POLICY_TYPE(NUM_MEM_REGIONS - 1 DOWNTO 0, NUM_DOMAINS - 1 DOWNTO 0) := (
    others => (others => (READ => '1', WRITE => '1'))
  );
  signal ID : STD_LOGIC_VECTOR(ID_WIDTH - 1 DOWNTO 0) := (others => '0');
  signal ADDR : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0) := (others => '0');
  signal LEN : STD_LOGIC_VECTOR(7 DOWNTO 0) := (others => '0');
  signal SIZE : STD_LOGIC_VECTOR(2 DOWNTO 0) := "101"; -- 32 bit
  signal READ_WRITE : STD_LOGIC := '0'; -- 0 -> READ, 1 -> WRITE
  signal GRANTED : STD_LOGIC;

  type STRING_PTR_TYPE is access string;
  type TEST_CASE_TYPE is record 
    -- Inputs
    ID : STD_LOGIC_VECTOR(ID_WIDTH - 1 DOWNTO 0);
    ADDR : STD_LOGIC_VECTOR(ADDR_WIDTH - 1 DOWNTO 0);
    LEN : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIZE : STD_LOGIC_VECTOR(2 DOWNTO 0);
    READ_WRITE : std_logic;
    -- Expected result
    GRANTED : std_logic;
    -- Debug
    NAME: STRING_PTR_TYPE;
  end record;
  type TEST_CASES_TYPE is array (natural range <>) of TEST_CASE_TYPE;

begin
 policycheck_inst: PolicyCheck
   generic map (
     NUM_MEM_REGIONS     => NUM_MEM_REGIONS,
     NUM_DOMAINS         => NUM_DOMAINS,
     ID_WIDTH            => ID_WIDTH,
     ADDR_WIDTH          => ADDR_WIDTH,

     MEM_REGION_0        => x"00000000",
     MEM_REGION_0_LSB    => 6,

     DOMAIN_0_ID         => b"0000000000000001",
     DOMAIN_0_MASK       => b"0000000000000011"
   )
   port map (
     POLICY     => POLICY,
     ID         => ID,
     ADDR       => ADDR,
     LEN        => LEN,
     SIZE       => SIZE,
     READ_WRITE => READ_WRITE,
     GRANTED    => GRANTED
   );

  main: process is
    variable test_cases : TEST_CASES_TYPE(0 to 2) := (
      -- ID, ADDR, LEN, SIZE, READ_WRITE, GRANTED, NAME
      (b"0000000000000001", x"00000000", x"00", b"010", '0', '1', new string'("simple allowed access")),
      (b"0000000000000000", x"00000000", x"00", b"010", '0', '0', new string'("invalid id")),
      (b"0000000000000001", x"FF000000", x"00", b"010", '0', '0', new string'("invalid address"))
    );
  begin
    for i_test_case in test_cases'range loop
      ID         <= test_cases(i_test_case).ID;
      ADDR       <= test_cases(i_test_case).ADDR;
      LEN        <= test_cases(i_test_case).LEN;
      SIZE       <= test_cases(i_test_case).SIZE;
      READ_WRITE <= test_cases(i_test_case).READ_WRITE;

      wait for delay;
      
      assert  (GRANTED = test_cases(i_test_case).GRANTED)
        report test_cases(i_test_case).NAME.all
        severity failure;

    end loop;
    wait;
  end process;

end architecture;
