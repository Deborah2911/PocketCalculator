----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 12:41:39 PM
-- Design Name: 
-- Module Name: freq_div - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fq_div is
    port(
    clk100: in STD_LOGIC;
    clk0: out STD_LOGIC_VECTOR(2 downto 0));
end fq_div;

architecture Behavioral of fq_div is

begin
process(clk100)
variable counter: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
begin
    if clk100'EVENT and clk100 = '1' then
            counter := counter + 1; 
    end if;
   clk0(2) <= counter(15);
   clk0(1) <= counter(14);
   clk0(0) <= counter(13);
end process;
end Behavioral;
