----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2024 16:28:29
-- Design Name: 
-- Module Name: 7segdec - Behavioral
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

entity segdec is
Port ( input : in STD_LOGIC_VECTOR(3 downto 0);
        segment : out STD_LOGIC_VECTOR(6 downto 0));
end segdec;

architecture Behavioral of segdec is

begin
process(input)
begin
 
case input is
when "0000" =>
segment <= "0000001"; ---0
when "0001" =>
segment <= "1001111"; ---1
when "0010" =>
segment <= "0010010"; ---2
when "0011" =>
segment <= "0000110"; ---3
when "0100" =>
segment <= "1001100"; ---4
when "0101" =>
segment <= "0100100"; ---5
when "0110" =>
segment <= "0100000"; ---6
when "0111" =>
segment <= "0001111"; ---7
when "1000" =>
segment <= "0000000"; ---8
when "1001" =>
segment <= "0000100"; ---9
when others =>
segment <= "1111111"; ---null
end case;
 
end process;

end Behavioral;
