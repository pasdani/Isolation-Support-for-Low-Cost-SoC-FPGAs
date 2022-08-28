----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.10.2021 15:34:03
-- Design Name: 
-- Module Name: id_manipulator_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY id_manipulator_tb IS
    --  Port ( );
END id_manipulator_tb;

ARCHITECTURE Behavioral OF id_manipulator_tb IS
    CONSTANT clk_period : time := 20 ns;

    COMPONENT id_manipulator_tb_1 IS
        PORT (
            clk_50Mhz : IN STD_LOGIC;
            done : OUT STD_LOGIC;
            resetn : IN STD_LOGIC;
            status : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL done : STD_LOGIC;
    SIGNAL resetn : STD_LOGIC := '1';
    SIGNAL status : STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN
    uut : id_manipulator_tb_1
    PORT MAP(
        clk_50Mhz => clk,
        done => done,
        resetn => resetn,
        status => status
    );

    clk_proc : PROCESS
    BEGIN
        clk <= NOT clk;
        WAIT FOR clk_period/2;
    END PROCESS clk_proc;

    reset_proc : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        WAIT UNTIL rising_edge(clk);
        WAIT FOR clk_period/10;
        resetn <= '0';
        WAIT FOR clk_period;
        resetn <= '1';
        WAIT;
    END PROCESS reset_proc;

END Behavioral;