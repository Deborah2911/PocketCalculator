library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8_2_1 is
    generic(
            n : integer);
    Port ( en: in std_logic;
            input0 : in STD_LOGIC_VECTOR(n DOWNTO 0);
            input1 : in STD_LOGIC_VECTOR(n DOWNTO 0);
           sel : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(n DOWNTO 0));
end mux8_2_1;

architecture Behavioral of mux8_2_1 is

begin

process(sel)
begin
if(en='1') then
if(sel='0') then
output<=input0;
else output<=input1;
end if;
end if;
end process;

end Behavioral;
