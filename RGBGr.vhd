----------------------------------------------------------------------------------
-- Company: APERTUS (GOOGLE SUMMER OF CODE)
-- Engineer: RAHUL VYAS
-- 
-- Create Date:    00:50:43 06/11/2018 
-- Design Name:    
-- Module Name:    RGBGr - Behavioral 
-- Project Name:   REALTIME FOCUS PEAKING
-- Target Devices: ZYNQ(MICROZED)
-- Description : The VHDL code takes raw RGGB values and converts them to
--               RGBGr foramat where Gr is the coressponding greyscale value
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--use IEEE.NUMERIC_BIT.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;

entity RGBGr is

generic (  TWO         : STD_LOGIC_VECTOR:= "000000000010";
           SEVEN       : STD_LOGIC_VECTOR:= "000000000111";
	   SEVENTY_TWO : STD_LOGIC_VECTOR:= "000001001000";
	   TWENTY_ONE  : STD_LOGIC_VECTOR:= "000000010101";
	   HUNDRED     : STD_LOGIC_VECTOR:= "000001100100";
	   COLUMNS     : natural := 720;
	   ROWS        : natural := 1024;
	   DATA_WIDTH  : natural :=64);
    Port ( data_in   : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           valid_in  : in  STD_LOGIC;
	   clk       : in  STD_LOGIC;
           data_out  : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           valid_out : out  STD_LOGIC);
end RGBGr;

architecture Behavioral of RGBGr is

signal RED     : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE    : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY    : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN   : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');

signal RED_int     : integer range 0 to 4095 := 0;
signal GREEN_int_1 : integer range 0 to 4095 := 0;
signal GREEN_int_2 : integer range 0 to 4095 := 0;
signal GREEN_int   : integer range 0 to 4095 := 0;
signal BLUE_int    : integer range 0 to 4095 := 0;
signal GREY_int    : integer range 0 to 4095 := 0;

begin

--RED <= data_in(11 downto 0) when valid_in='1' else (others=>'0');
--RED_int <= to_integer(unsigned(RED));
--GREEN_1 <= data_in(23 downto 12);
--GREEN_int_1 <= to_integer(unsigned(GREEN_1));
--GREEN_2 <= data_in(35 downto 24); 
--GREEN_int_2 <= to_integer(unsigned(GREEN_2));
--BLUE <= data_in(47 downto 36); 
--BLUE_int <= to_integer(unsigned(BLUE));

--GREEN_int <= (GREEN_int_1+ GREEN_int_2)/2;
--GREEN <= STD_LOGIC_VECTOR(to_unsigned(GREEN_int,GREEN'length));

--GREY_int <= ((BLUE_int*7) + (GREEN_int*72) + (RED_int*21))/100;
--GREY <= STD_LOGIC_VECTOR(to_unsigned(GREY_int,GREY'length));
--valid_out <= valid_in;

process(clk, valid_in)
begin
	if rising_edge(clk) then
		if valid_in = '1' then
			RED <= data_in(11 downto 0);
			RED_int <= to_integer(unsigned(RED));
			GREEN_1 <= data_in(23 downto 12); 
	                GREEN_int_1 <= to_integer(unsigned(GREEN_1));
			GREEN_2 <= data_in(35 downto 24); 
                        GREEN_int_2 <= to_integer(unsigned(GREEN_2));
			BLUE <= data_in(47 downto 36); 
                        BLUE_int <= to_integer(unsigned(BLUE));
			GREEN_int <= (GREEN_int_1 + GREEN_int_2)/2;
			GREEN <= STD_LOGIC_VECTOR(to_unsigned(GREEN_int, GREEN'length));
			GREY_int <= ((BLUE_int * 7) + (GREEN_int * 72) + (RED_int * 21))/100;
			GREY <= STD_LOGIC_VECTOR(to_unsigned(GREY_int, GREY'length));
			
			Data_out <= Data_in;
			Data_out(23 downto 12) <= GREEN;
			Data_out(35 downto 24) <= BLUE;
			Data_out(47 downto 36) <= GREY;
			valid_out <= '1';
        else
		        RED <= (others=>'0');
			GREEN_1 <= (others=>'0');
			GREEN_2 <= (others=>'0');
			BLUE <= (others=>'0');
			RED_int <= 0;
			GREEN_int_1 <= 0;
			GREEN_int_2 <= 0;
			BLUE_int <= 0;
			GREY_int <= 0;
			GREEN <= (others=>('0'));
			GREY <= (others=>('0'));
			Data_out <= (others=>'0');
			valid_out <= '0';
		end if;	
	end if;
end process;
end Behavioral;

