library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity booth_multiplier is
	generic (x : integer := 8;
		 y : integer := 8);
	port(m : in std_logic_vector(x - 1 downto 0);
	     r : in std_logic_vector(y - 1 downto 0);
	     result : out std_logic_vector(x + y - 1 downto 0));
end booth_multiplier;

architecture Behavioral of booth_multiplier is

begin
	
	process(m, r)
		constant x_zeros : std_logic_vector(x - 1 downto 0) := (others => '0');
		constant y_zeros : std_logic_vector(y - 1 downto 0) := (others => '0');
		variable a, s, p : std_logic_vector(x + y + 1 downto 0);
		variable mn      : std_logic_vector(x - 1 downto 0);
	begin
		a := (others => '0');
		s := (others => '0');
		p := (others => '0');
		
		if (m /= x_zeros and r /= y_zeros) then
			
			a(x + y downto y + 1) := m;
			a(x + y + 1) := m(x - 1);
			
			mn := (not m) + 1;
			
			s(x + y downto y + 1) := mn;
			s(x + y + 1) := not(m(x - 1));
			
			p(y downto 1) := r;
			
			for i in 1 to y loop
				if (p(1 downto 0) = "01") then
					p := p + a;
				elsif (p(1 downto 0) = "10") then
					p := p + s;
				end if;
				p(x + y downto 0) := p(x + y + 1 downto 1);
			end loop;
			
		end if;
		result <= p(x + y downto 1);
	end process;
end Behavioral;