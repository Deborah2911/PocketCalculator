----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/21/2024 08:49:04 PM
-- Design Name: 
-- Module Name: test - Behavioral
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

entity test_sute is
  Port ( clk100: in STD_LOGIC;
         outputs: out STD_LOGIC_VECTOR(3 DOWNTO 0);
         clear: in STD_LOGIC;
         hold: in STD_LOGIC;
         enable: in STD_LOGIC);
end test_sute;

architecture Behavioral of test_sute is

signal small_freq_clk: STD_LOGIC;

component freq_div2 is
    port(
        clk100: in std_logic;
        clk1: out std_logic
    );
end component;

component counter_sute is
  Port ( 
      clk      : IN  std_logic;       
      clear     : in  std_logic;            
      enable     : in  std_logic;            
      hold     : in  std_logic;            
      --inputs        : IN  std_logic_vector(3 DOWNTO 0);
      outputs       : OUT std_logic_vector(3 DOWNTO 0)  
  );
end component;

begin
comp1: freq_div2 port map (clk100, small_freq_clk);
comp2: counter_sute port map(clk => small_freq_clk, clear => clear, enable => enable, hold => hold, outputs =>outputs);
end Behavioral;
