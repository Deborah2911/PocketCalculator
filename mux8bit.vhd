----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2024 16:20:15
-- Design Name: 
-- Module Name: mux3in - Behavioral
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

entity mux8bit is
  Port (input0: in STD_LOGIC_VECTOR(7 downto 0);
        input1: in STD_LOGIC_VECTOR(7 downto 0);
        input2: in STD_LOGIC_VECTOR(7 downto 0);
        input3: in STD_LOGIC_VECTOR(7 downto 0);
        input4: in STD_LOGIC_VECTOR(7 downto 0);
        input5: in STD_LOGIC_VECTOR(7 downto 0);
        input6: in STD_LOGIC_VECTOR(7 downto 0);
        input7: in STD_LOGIC_VECTOR(7 downto 0);
        sel: in STD_LOGIC_VECTOR(2 downto 0);
        output: out STD_LOGIC_VECTOR(7 downto 0));
end mux8bit;

architecture Behavioral of mux8bit is

begin
    process(sel)
    begin
    case sel is
        when "000" => output <= input0;
        when "001" => output <= input1;
        when "010" => output <= input2;
        when "011" => output <= input3;
        when "100" => output <= input4;
        when "101" => output <= input5;
        when "110" => output <= input6;
        when "111" => output <= input7;
        when others=>
    end case;
end process;
end Behavioral;
