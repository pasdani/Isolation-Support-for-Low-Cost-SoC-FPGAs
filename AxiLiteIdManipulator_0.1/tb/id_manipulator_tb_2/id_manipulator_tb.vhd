----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2021 11:54:28
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

    COMPONENT id_manipulator_tb_2 IS
        PORT (
            clk_50Mhz : IN STD_LOGIC;
            resetn : IN STD_LOGIC
        );
    END COMPONENT;

    CONSTANT clk_period : TIME := 20 ns;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL resetn : STD_LOGIC := '1';

BEGIN

    uut : id_manipulator_tb_2
    PORT MAP(
        clk_50Mhz => clk,
        resetn => resetn
    );

    clk_proc : PROCESS
    BEGIN
        WAIT FOR clk_period/2;
        clk <= NOT clk;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        WAIT FOR 200 ns;
        WAIT UNTIL falling_edge(clk);
        resetn <= '0';
        WAIT FOR clk_period;
        resetn <= '1';
        WAIT;
    END PROCESS;
END Behavioral;