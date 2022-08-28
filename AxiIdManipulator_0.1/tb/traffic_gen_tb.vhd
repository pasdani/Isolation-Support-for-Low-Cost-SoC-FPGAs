----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.10.2021 11:20:51
-- Design Name: 
-- Module Name: traffic_gen_tb - Behavioral
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

ENTITY traffic_gen_tb IS
    --  Port ( );
END traffic_gen_tb;

ARCHITECTURE Behavioral OF traffic_gen_tb IS

    COMPONENT traffic_gen_tb_1 IS
        PORT (
            clk : IN STD_LOGIC;
            resetn : IN STD_LOGIC;
            start : IN STD_LOGIC
        );
    END COMPONENT;

    CONSTANT clk_period : TIME := 20 ns;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL resetn : STD_LOGIC := '1';
    SIGNAL start : STD_LOGIC := '0';

BEGIN
    uut : traffic_gen_tb_1
    PORT MAP(
        clk => clk,
        resetn => resetn,
        start => start
    );

    clk_proc : PROCESS
    BEGIN
        clk <= NOT clk;
        WAIT FOR clk_period/2;
    END PROCESS clk_proc;

    reset_proc : PROCESS
    BEGIN
        WAIT FOR 100 ns;
        resetn <= '0';
        WAIT FOR clk_period;
        resetn <= '1';
        start <= '1';
        WAIT FOR clk_period;
        start <= '0';
        WAIT;
    END PROCESS reset_proc;
END Behavioral;