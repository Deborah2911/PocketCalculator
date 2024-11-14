----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2024 05:42:20 PM
-- Design Name: 
-- Module Name: counter_sute - Behavioral
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
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_sute is
Port ( clk      : IN  std_logic;       
      clear     : in  std_logic;            
      enable     : in  std_logic;            
      hold     : in  std_logic;            
      outputs       : OUT std_logic_vector(3 DOWNTO 0)  );
end counter_sute;

architecture Behavioral of counter_sute is

begin
process(clk)
variable count:  std_logic_vector(3 DOWNTO 0):= "0000";
begin
if rising_edge(clk) then
    if(enable='1') then
        if(clear='1' or count="0011") then
            count:= (others => '0');
        elsif(hold='0') then
            count := count+1;
	    end if;
	else
	   count:= (others => '0');
	end if;
	outputs<=count;
end if;
end process;
end Behavioral;
