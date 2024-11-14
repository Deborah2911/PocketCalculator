----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Florea Deborah-Ruxandra-Maria
-- 
-- Create Date: 06/03/2024 10:00:03 PM
-- Design Name: 
-- Module Name: test_disp - Behavioral
-- Project Name: Pocket Calculator
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
use ieee.std_logic_unsigned.all;

entity Calculator is
  Port ( clk100: in std_logic;
            
          digit_sute_ctrls: in STD_LOGIC_VECTOR(0 to 2);
          digit_zeci_ctrls: in STD_LOGIC_VECTOR(0 to 2);
          digit_uni_ctrls: in STD_LOGIC_VECTOR(0 to 2);
          
          Ncatod: out STD_LOGIC_VECTOR(6 downto 0);
          Nanod: out STD_LOGIC_VECTOR(7 downto 0);
        
        operation: in std_logic_vector(4 downto 0));
end Calculator;

architecture Behavioral of Calculator is
component display is
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
end component;

component myregister is
  Port ( inputs: in std_logic_vector(7 downto 0);
        outputs: out std_logic_vector(7 downto 0);
        enable: in std_logic;
        clear: in std_logic;
        load: in std_logic;
        clk: in std_logic
        );
end component;

component mux8_2_1 is
generic( n : integer);
    Port ( en: in std_logic;
            input0 : in STD_LOGIC_VECTOR(n DOWNTO 0);
            input1 : in STD_LOGIC_VECTOR(n DOWNTO 0);
           sel : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR(n DOWNTO 0));
end component;

component UC_Calc is
    Port ( clk100 : in STD_LOGIC;
           sum0 : inout STD_LOGIC;
           mult : inout STD_LOGIC;
           ld_reg_q : inout STD_LOGIC;
           ld_reg_b : inout STD_LOGIC;
           en_reg_q : out STD_LOGIC;
           en_reg_b : out STD_LOGIC;
           dc: out STD_LOGIC;
           op_ef: out STD_LOGIC;
           operation : in STD_LOGIC_VECTOR(4 DOWNTO 0);
            nr_ld : out STD_LOGIC_VECTOR(7 DOWNTO 0);
           values_b : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           values_q : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           val_sum : inout STD_LOGIC_VECTOR(8 DOWNTO 0);
           val_subtr : inout STD_LOGIC_VECTOR(8 DOWNTO 0);
           val_mult : inout STD_LOGIC_VECTOR(8 DOWNTO 0)
    );
end component;

signal clr_reg_q: std_logic;
signal ld_reg_q: std_logic;
signal clr_reg_b: std_logic;
signal ld_reg_b: std_logic;

signal values_q,values_b,numar1,nr_ld, inp_q: STD_LOGIC_VECTOR(7 downto 0);
signal val_sum, result, val_subtr,val_mult,afis: STD_LOGIC_VECTOR(8 downto 0);
signal sign_dif,sum0,mult: std_logic;
signal dc,muxy,en_reg_q,en_reg_b: std_logic:='1';
signal op_ef: std_logic:='0';

signal x1,x2: integer:=0;
begin

regQ: myregister port map(inputs=>inp_q, outputs=>values_q, enable=>en_reg_q, clear=>clr_reg_q, load=>ld_reg_q, clk=>clk100);
regB: myregister port map(inputs=>numar1, outputs=>values_b, enable=>en_reg_b, clear=>clr_reg_b, load=>ld_reg_b, clk=>clk100);

mux: mux8_2_1 generic map(n => 8)
 port map( en=>muxy,
            input0=>val_sum,
            input1=>val_subtr,
           sel=>sum0,
           output=>result);
           
mux0: mux8_2_1 generic map(n => 8)
               port map( en=>muxy,
                          input0=>result,
                          input1=>val_mult,
                         sel=>mult,
                         output=>afis);
           
mux2: mux8_2_1 generic map(n => 7)
            port map( en=>muxy,
                       input0=>nr_ld,
                       input1=>numar1,
                      sel=>op_ef,
                      output=>inp_q);

to_display: display port map(clk100=>clk100,
        display_ct=>dc,
        digit_sute_ctrls=>digit_sute_ctrls,
        digit_zeci_ctrls=>digit_zeci_ctrls,
        digit_uni_ctrls=>digit_uni_ctrls,
        Ncatod=>Ncatod,
        Nanod=>Nanod,
        numar=>numar1,
        values_a=>afis
        );
        
uc: UC_Calc port map( clk100=>clk100,
                   sum0=>sum0,
                   mult=>mult,
                   ld_reg_q=>ld_reg_q,
                   ld_reg_b=>ld_reg_b,
                   en_reg_q=>en_reg_q,
                   en_reg_b=>en_reg_b,
                   dc=>dc,
                   op_ef=>op_ef,
                   operation=>operation,
                   nr_ld=>nr_ld,
                   values_b=>values_b,
                   values_q=>values_q,
                   val_sum=>val_sum,
                   val_subtr=>val_subtr,
                   val_mult=>val_mult
            );

end Behavioral;
