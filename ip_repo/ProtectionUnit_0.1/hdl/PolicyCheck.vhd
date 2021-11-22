LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.Common.ALL;

ENTITY PolicyCheck IS
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
        MEM_REGION_15_LSB : INTEGER RANGE 0 TO 32 := 7;

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
END ENTITY;

ARCHITECTURE rtl OF PolicyCheck IS
    SIGNAL mem_region_matches : STD_LOGIC_VECTOR(NUM_MEM_REGIONS - 1 DOWNTO 0) := (OTHERS => '0');
    SIGNAL domain_matches : STD_LOGIC_VECTOR(NUM_DOMAINS - 1 DOWNTO 0) := (OTHERS => '0');

BEGIN

    match_mem_regions : PROCESS (ADDR, LEN, SIZE) IS
        TYPE MEM_REGIONS_TYPE IS ARRAY (0 TO MAX_NUM_MEM_REGIONS - 1) OF STD_LOGIC_VECTOR(ADDR'RANGE);
        VARIABLE mem_regions : MEM_REGIONS_TYPE := (
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
            MEM_REGION_15
        );

        TYPE MEM_REGION_LSBS_TYPE IS ARRAY (0 TO MAX_NUM_MEM_REGIONS - 1) OF INTEGER;
        VARIABLE mem_region_lsbs : MEM_REGION_LSBS_TYPE := (
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
            MEM_REGION_15_LSB
        );

        -- numbers of bursts in the transaction
        VARIABLE burst_length : unsigned(ADDR'RANGE);
        -- bits to shift burst_length to the left to account for burst sizes        
        VARIABLE shift : INTEGER RANGE 0 TO 7 := TO_INTEGER(unsigned(SIZE));
        -- offset of the last addressed byte
        VARIABLE offset : unsigned(ADDR'RANGE);
        -- address of the last byte
        VARIABLE addr_last : STD_LOGIC_VECTOR(ADDR'RANGE);
    BEGIN
        burst_length := resize(unsigned(LEN), ADDR'length) + 1;
        shift := TO_INTEGER(unsigned(SIZE));
        offset := shift_left(burst_length, shift) - 1;
        addr_last := STD_LOGIC_VECTOR(unsigned(ADDR) + offset);
        FOR i IN 0 TO NUM_MEM_REGIONS - 1 LOOP
            -- An address matches a region if:
            --  1. The significant bits match and
            --  2. The offset of the last addressed byte doesn't reach into the significant bits
            IF (mem_regions(i)(ADDR_WIDTH - 1 DOWNTO mem_region_lsbs(i)) = ADDR(ADDR_WIDTH - 1 DOWNTO mem_region_lsbs(i))) AND
                (addr_last(ADDR_WIDTH - 1 DOWNTO mem_region_lsbs(i)) = ADDR(ADDR_WIDTH - 1 DOWNTO mem_region_lsbs(i))) THEN
                mem_region_matches(i) <= '1';
            ELSIF mem_region_lsbs(i) = ADDR_WIDTH THEN -- region matches all addresses
                mem_region_matches(i) <= '1';
            ELSE
                mem_region_matches(i) <= '0';
            END IF;
        END LOOP;
    END PROCESS;

    match_domains : PROCESS (ID) IS
        TYPE DOMAIN_IDS_TYPE IS ARRAY (0 TO MAX_NUM_DOMAINS - 1) OF STD_LOGIC_VECTOR(ID'RANGE);
        VARIABLE domain_ids : DOMAIN_IDS_TYPE := (
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
            DOMAIN_15_ID
        );

        TYPE DOMAIN_MASKS_TYPE IS ARRAY (0 TO MAX_NUM_DOMAINS - 1) OF STD_LOGIC_VECTOR(ID'RANGE);
        VARIABLE domain_masks : DOMAIN_IDS_TYPE := (
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
            DOMAIN_15_MASK
        );

        VARIABLE match : BOOLEAN;
    BEGIN
        FOR i_domain IN 0 TO NUM_DOMAINS - 1 LOOP
            match := true;
            FOR i_bit IN domain_ids(i_domain)'RANGE LOOP
                IF domain_masks(i_domain)(i_bit) = '1' THEN
                    match := match AND (domain_ids(i_domain)(i_bit) = ID(i_bit));
                END IF;
            END LOOP;
            IF match THEN
                domain_matches(i_domain) <= '1';
            ELSE
                domain_matches(i_domain) <= '0';
            END IF;
        END LOOP;

    END PROCESS;

    grant_permission : PROCESS (POLICY, READ_WRITE, mem_region_matches, domain_matches) IS
        VARIABLE match : BOOLEAN := false;
    BEGIN
        match := false;
        FOR i_mem IN 0 TO NUM_MEM_REGIONS - 1 LOOP
            FOR i_domain IN 0 TO NUM_DOMAINS - 1 LOOP
                IF mem_region_matches(i_mem) = '1' AND domain_matches(i_domain) = '1' THEN
                    IF READ_WRITE = '0' THEN -- READ
                        match := match OR (POLICY(i_mem, i_domain).READ = '1');
                    ELSE -- WRITE
                        match := match OR (POLICY(i_mem, i_domain).WRITE = '1');
                    END IF;
                END IF;
            END LOOP;
        END LOOP;
        IF match THEN
            GRANTED <= '1';
        ELSE
            GRANTED <= '0';
        END IF;
    END PROCESS;
END ARCHITECTURE;