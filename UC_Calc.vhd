----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/14/2024 05:47:05 PM
-- Design Name: 
-- Module Name: UC_Calc - Behavioral
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
use ieee.std_logic_unsigned.all;

entity UC_Calc is
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
end UC_Calc;

architecture Behavioral of UC_Calc is

component booth_multiplier is

	GENERIC (x : INTEGER := 8;
		 y : INTEGER := 8);
	
	PORT(m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
	     r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
	     result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0));
		  
END component;

signal curr_st0, last_st0,curr_st1, last_st1,curr_st2, last_st2,curr_st4, last_st4: std_logic:='0';
signal en_sum, en_subtr, sign_dif, en_mult: std_logic;
signal val_mult2 : STD_LOGIC_VECTOR(15 DOWNTO 0);

signal x1,x2,x3: integer:=0;

begin

multy: booth_multiplier
	GENERIC MAP(x=>8,y=>8)
	PORT MAP(m=>values_q,r=>values_b,result=>val_mult2);

process(clk100, operation)
begin
if rising_edge(clk100) then
ld_reg_q<='0';
ld_reg_b<='0';
op_ef<='1';
en_sum<='0';
en_subtr<='0';
en_mult<='0';
if operation(4)='1' then
    last_st4<=curr_st4;
    curr_st4<='1';
    if last_st4=not(curr_st4) then
            en_sum<='1';
            dc<='0';
            en_subtr<='1';
            en_mult<='1';
            en_reg_q<='1';
            ld_reg_q<='1';
            en_reg_b<='0';
            ld_reg_b<='0';
            op_ef<='0';            
    end if;
else
    last_st4<=curr_st4;
    curr_st4<='0';
    if last_st4=not(curr_st4) then
         if val_sum(8)='0' and en_sum='1' and x1>0 then
               op_ef<='0';
               en_reg_q<='1';
               ld_reg_q<='1';
               en_reg_b<='0';
               ld_reg_b<='0';
         end if;
         if val_subtr(8)='0' and en_subtr='1' and x2>0 then
                op_ef<='0';
                en_reg_q<='1';
                ld_reg_q<='1';
                en_reg_b<='0';
                ld_reg_b<='0';
          end if;
          if val_mult(8)='0' and en_mult='1' and x3>0 then
              op_ef<='0';
              en_reg_q<='1';
              ld_reg_q<='1';
              en_reg_b<='0';
              ld_reg_b<='0';
          end if;
          en_sum<='0';
          en_subtr<='0';
          en_mult<='0';
    end if;
    dc<='1';
end if;
    
if operation(0)='1' then
    last_st0<=curr_st0;
    curr_st0<='1';
    if last_st0=not(curr_st0) then
        if x1=0 then
        en_reg_q<='1';
        ld_reg_q<='1';
        en_reg_b<='0';
        ld_reg_b<='0';
        x2<=x2+1;
        x3<=x3+1;
        elsif x1>=1 then
        sum0<='0';
        mult<='0';
        en_reg_q<='0';
        ld_reg_q<='0';
        en_reg_b<='1';
        ld_reg_b<='1';
        end if;
        x1<=x1+1;
    end if;
else
    last_st0<=curr_st0;
    curr_st0<='0';
end if;

if operation(1)='1' then
        last_st1<=curr_st1;
        curr_st1<='1';
        if last_st1=not(curr_st1) then
            if x2=0 then
            en_reg_q<='1';
            ld_reg_q<='1';
            en_reg_b<='0';
            ld_reg_b<='0';
            x1<=x1+1;
            x3<=x3+1;
            elsif x2>=1 then
            sum0<='1';
            mult<='0';
            en_reg_q<='0';
            ld_reg_q<='0';
            en_reg_b<='1';
            ld_reg_b<='1';
            end if;
            x2<=x2+1;
        end if;
    else
        last_st1<=curr_st1;
        curr_st1<='0';
    end if;
    
if operation(2)='1' then
    last_st2<=curr_st2;
    curr_st2<='1';
    if last_st2=not(curr_st2) then
        if x3=0 then
        en_reg_q<='1';
        ld_reg_q<='1';
        en_reg_b<='0';
        ld_reg_b<='0';
        x1<=x1+1;
        x2<=x2+1;
        elsif x3>=1 then
        mult<='1';
        en_reg_q<='0';
        ld_reg_q<='0';
        en_reg_b<='1';
        ld_reg_b<='1';
        end if;
        x3<=x3+1;
    end if;
else
    last_st2<=curr_st2;
    curr_st2<='0';
end if;

    
end if;

end process;        

process(ld_reg_q,ld_reg_b,en_sum,en_subtr, en_mult)
begin
if en_sum='1' and x1>0 then
val_sum<=('0'& values_b)+('0'& values_q);
end if;
if en_subtr='1' and x2>0 then
val_subtr<=('0'& values_q)-('0'& values_b);
end if;
if en_mult='1' and x3>0 then
    val_mult<= '0' & val_mult2(7 downto 0);
end if;
if mult='1' then
        nr_ld<=val_mult(7 downto 0);
else
        if sum0='0' then
            nr_ld<=val_sum(7 downto 0);
        else nr_ld<=val_subtr(7 downto 0);
        end if;
end if;
end process;

end Behavioral;
