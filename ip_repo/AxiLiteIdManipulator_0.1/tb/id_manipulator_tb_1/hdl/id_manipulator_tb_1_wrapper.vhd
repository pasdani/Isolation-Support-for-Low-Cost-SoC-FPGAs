--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
--Date        : Wed Oct 13 15:01:48 2021
--Host        : DESKTOP-18HSEJI running 64-bit major release  (build 9200)
--Command     : generate_target id_manipulator_tb_1_wrapper.bd
--Design      : id_manipulator_tb_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity id_manipulator_tb_1_wrapper is
  port (
    clk : in STD_LOGIC;
    done : out STD_LOGIC;
    resetn : in STD_LOGIC;
    status : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end id_manipulator_tb_1_wrapper;

architecture STRUCTURE of id_manipulator_tb_1_wrapper is
  component id_manipulator_tb_1 is
  port (
    clk : in STD_LOGIC;
    resetn : in STD_LOGIC;
    done : out STD_LOGIC;
    status : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component id_manipulator_tb_1;
begin
id_manipulator_tb_1_i: component id_manipulator_tb_1
     port map (
      clk => clk,
      done => done,
      resetn => resetn,
      status(31 downto 0) => status(31 downto 0)
    );
end STRUCTURE;
