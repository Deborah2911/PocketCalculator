----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.05.2024 16:50:36
-- Design Name: 
-- Module Name: display - Behavioral
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
use ieee.numeric_std.all;

entity display is
  Port (clk100: in STD_LOGIC;
        display_ct: in std_logic;
        digit_sute_ctrls: in STD_LOGIC_VECTOR(0 to 2); --0 for clr, 1 for en, 2 for hld
        digit_zeci_ctrls: in STD_LOGIC_VECTOR(0 to 2); --0 for clr, 1 for en, 2 for hld
        digit_uni_ctrls: in STD_LOGIC_VECTOR(0 to 2); --0 for clr, 1 for en, 2 for hld
        Ncatod: out STD_LOGIC_VECTOR(6 downto 0);
        Nanod: out STD_LOGIC_VECTOR(7 downto 0);
        numar: out STD_LOGIC_VECTOR(7 downto 0);
        values_a: in STD_LOGIC_VECTOR(8 downto 0)
        );
end display;

architecture Behavioral of display is

component fq_div is
    port(
    clk100: in STD_LOGIC;
    clk0: out STD_LOGIC_VECTOR(2 downto 0));
end component;

component mux4bit is
  Port (input0: in STD_LOGIC_VECTOR(3 downto 0);
        input1: in STD_LOGIC_VECTOR(3 downto 0);
        input2: in STD_LOGIC_VECTOR(3 downto 0);
        input3: in STD_LOGIC_VECTOR(3 downto 0);
        input4: in STD_LOGIC_VECTOR(3 downto 0);
        input5: in STD_LOGIC_VECTOR(3 downto 0);
        input6: in STD_LOGIC_VECTOR(3 downto 0);
        input7: in STD_LOGIC_VECTOR(3 downto 0);
        sel: in STD_LOGIC_VECTOR(2 downto 0);
        output: out STD_LOGIC_VECTOR(3 downto 0));
end component;

component mux8bit is
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
end component;

component segdec is
Port ( input : in STD_LOGIC_VECTOR(3 downto 0);
        segment : out STD_LOGIC_VECTOR(6 downto 0));
end component;

component test_zeci is
  Port ( clk100: in STD_LOGIC;
         outputs: out STD_LOGIC_VECTOR(3 DOWNTO 0);
         clear: in STD_LOGIC;
         hold: in STD_LOGIC;
         doua_sute: in STD_LOGIC;
         enable: in STD_LOGIC);
end component;

component test_sute is
  Port ( clk100: in STD_LOGIC;
         outputs: out STD_LOGIC_VECTOR(3 DOWNTO 0);
         clear: in STD_LOGIC;
         hold: in STD_LOGIC;
         enable: in STD_LOGIC);
end component;

component test_uni is
  Port ( clk100: in STD_LOGIC;
         outputs: out STD_LOGIC_VECTOR(3 DOWNTO 0);
         clear: in STD_LOGIC;
         hold: in STD_LOGIC;
         doua_sute: in STD_LOGIC;
         cinci_zeci: in STD_LOGIC;
         enable: in STD_LOGIC);
end component;

component mux2_1 is
    Port ( en: in std_logic;
            input0 : in STD_LOGIC_VECTOR(3 DOWNTO 0);
            input1 : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           sel : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(3 DOWNTO 0));
end component;

signal sel: STD_LOGIC_VECTOR(2 downto 0);
signal indec: STD_LOGIC_VECTOR(3 downto 0);

signal digit_sute: STD_LOGIC_VECTOR(3 downto 0);
signal digit_zeci: STD_LOGIC_VECTOR(3 downto 0);
signal digit_uni: STD_LOGIC_VECTOR(3 downto 0);

signal values_q: STD_LOGIC_VECTOR(7 downto 0);
signal values_b: STD_LOGIC_VECTOR(7 downto 0);

--signal numar: STD_LOGIC_VECTOR(7 downto 0);
signal nr_interm: integer;
signal nr_out: std_logic_vector(7 downto 0);
signal nr_interm_sute: integer;
signal nr_interm_zeci: integer;
signal nr_interm_uni: integer;

signal val_a_sute: STD_LOGIC_VECTOR(3 downto 0);
signal val_a_zeci: STD_LOGIC_VECTOR(3 downto 0);
signal val_a_uni: STD_LOGIC_VECTOR(3 downto 0);


signal val_display_sute: STD_LOGIC_VECTOR(3 downto 0);
signal val_display_zeci: STD_LOGIC_VECTOR(3 downto 0);
signal val_display_uni: STD_LOGIC_VECTOR(3 downto 0);

signal cinci_zeci: std_logic;

begin
fq: fq_div port map(clk100 => clk100, clk0 => sel);
cinci_zeci<=digit_zeci(2) and digit_zeci(0);
ct_sute: test_sute port map(clk100 => clk100, outputs => digit_sute, clear => digit_sute_ctrls(0), hold => digit_sute_ctrls(2), enable => digit_sute_ctrls(1));
ct_zeci: test_zeci port map(clk100 => clk100, outputs => digit_zeci, clear => digit_zeci_ctrls(0), hold => digit_zeci_ctrls(2), doua_sute=>digit_sute(1), enable => digit_zeci_ctrls(1));
ct_uni: test_uni port map(clk100 => clk100, outputs => digit_uni, clear => digit_uni_ctrls(0), hold => digit_uni_ctrls(2), doua_sute=>digit_sute(1), cinci_zeci=>cinci_zeci, enable => digit_uni_ctrls(1));
m4: mux4bit port map(input0 => val_display_uni, input1 => val_display_zeci, input2 => val_display_sute, input3 => "0000", input4 => "0000", input5 => "0000", input6 => "0000",
 input7 => "0000", sel => sel, output => indec);
sd: segdec port map(input => indec, segment => Ncatod);
m8: mux8bit port map(input0 => "11111110", input1 => "11111101", input2 => "11111011", input3 => "11110111", input4 => "11101111", input5 => "11011111",
 input6 => "10111111", input7 => "01111111", sel => sel, output => Nanod);
 
m2: mux2_1 port map(en=>'1', input0=>val_a_sute, input1=>digit_sute, sel=>display_ct, output=>val_display_sute);
m2_2: mux2_1 port map(en=>'1', input0=>val_a_zeci, input1=>digit_zeci, sel=>display_ct, output=>val_display_zeci);
m2_3: mux2_1 port map(en=>'1', input0=>val_a_uni, input1=>digit_uni, sel=>display_ct, output=>val_display_uni);

--tranform from 8bit nr to 3 4bit digits
nr_interm_sute<=to_integer(unsigned(values_a))/100;
val_a_sute<=std_logic_vector(to_unsigned(nr_interm_sute,4));
nr_interm_zeci<=(to_integer(unsigned(values_a))/10) mod 10;
val_a_zeci<=std_logic_vector(to_unsigned(nr_interm_zeci,4));
nr_interm_uni<=to_integer(unsigned(values_a)) mod 10;
val_a_uni<=std_logic_vector(to_unsigned(nr_interm_uni,4));


--build 8bit nr from 3 4bit digits
process(digit_sute_ctrls(2),digit_zeci_ctrls(2),digit_uni_ctrls(2))
begin
if(digit_sute_ctrls(2)='1' and digit_zeci_ctrls(2)='1' and digit_uni_ctrls(2)='1') then
nr_interm<=to_integer(unsigned(digit_sute))*100+to_integer(unsigned(digit_zeci))*10+to_integer(unsigned(digit_uni));
numar<=std_logic_vector(to_unsigned(nr_interm, 8));
end if;
end process;

end Behavioral;
