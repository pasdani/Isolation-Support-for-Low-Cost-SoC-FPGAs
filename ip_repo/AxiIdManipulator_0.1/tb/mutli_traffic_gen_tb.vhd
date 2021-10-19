----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.10.2021 10:25:30
-- Design Name: 
-- Module Name: mutli_traffic_gen_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mutli_traffic_gen_tb is
--  Port ( );
end mutli_traffic_gen_tb;

architecture Behavioral of mutli_traffic_gen_tb is

component multi_traffic_gen_tb_1 is
  port (
    clk_50Mhz : in STD_LOGIC;
    resetn : in STD_LOGIC;
    start0 : in STD_LOGIC;
    start1 : in STD_LOGIC
  );
end component;

constant clk_period: time := 20 ns;

signal clk : STD_LOGIC := '0';
signal resetn : STD_LOGIC := '1';
signal start0 : STD_LOGIC := '0';
signal start1 : STD_LOGIC := '0';

begin

uut: multi_traffic_gen_tb_1
  port map (
    clk_50Mhz => clk,
    resetn     => resetn,
    start0     => start0,
    start1     => start1
  );

clk_proc: process
begin
    wait for clk_period/2;
    clk <= not clk;
end process;

stim_proc: process
begin
  wait for 200 ns;
  wait until falling_edge(clk);
  resetn <= '0';
  wait for clk_period;
  resetn <= '1';
  wait for clk_period;
  start0 <= '1';
  start1 <= '1';
  wait;
end process;


end Behavioral;
