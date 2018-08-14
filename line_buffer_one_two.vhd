----------------------------------------------------------------------------------
-- Company: APERTUS (GOOGLE SUMMER OF CODE - 2018)
-- Engineer: RAHUL VYAS
-- 
-- Create Date:    00:50:43 06/11/2018 
-- Design Name:    Line buffer - final code
-- Module Name:    Line buffer - Behavioral 
-- Project Name:   REALTIME FOCUS PEAKING
-- Target Devices: ZYNQ(MICROZED)
-- Description : This VHDL module streams in pixel values and stores them in a line buffer
--               parallely the module streams out the coressponding window pixels.
-----------------------------------------------------------------------------------
-- This program is free software: you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation, either version
-- 2 of the License, or (at your option) any later version.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity line_buffer is
generic (  COLUMNS : natural := 1920;
	   ROWS    : natural := 1080;
	   DATA_WIDTH : natural :=64);
			  
Port ( data_in    : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) ;
       data_valid : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
       P_0        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
       P_1        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
       P_2        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
       P_3        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
       P_4        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current target pixel in window		 
       P_5        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
       P_6        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
       P_7        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
       P_8        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0)); -- current neighbour pixel window		 
end line_buffer;

architecture Behavioral of line_buffer is

	signal l_cntr : integer range 0 to ROWS := 0; --line counter
	signal c_cntr : integer range 0 to COLUMNS := 0; --column counter
	signal code : std_logic_vector(3 downto 0) :="0000"; -- code to determine boundary conditions
	type ARRAY_struct is array (0 to (COLUMNS*3-1)) of STD_LOGIC_VECTOR(DATA_WIDTH+3 DOWNTO 0);
	------------------------------------
	constant NaN : STD_LOGIC_VECTOR (DATA_WIDTH+3 downto 0) := (others => '0');
	signal A : ARRAY_struct := (others=>(others =>'0'));
	begin

	process (data_valid, clk)
	begin
	if rising_edge(clk) then

	--------------------------------------- Data Fetch
		if data_valid = '1' then --store
	--------------------------------------- Encode Control 
			if l_cntr = 0  and c_cntr = 0 then -- corner case - px(i)(j =0)
			   A(3*COLUMNS-1) <= data_in & "1000";

			elsif l_cntr = 0  and c_cntr /= 0 and c_cntr /= (COLUMNS-1) then -- corner case - px(i)(j =0)
				A(3*COLUMNS-1) <= data_in & "1001";

			elsif l_cntr = 0  and c_cntr = (COLUMNS-1) then
				A(3*COLUMNS-1) <= data_in & "1010";

			elsif l_cntr /= 0 and l_cntr /= (ROWS-1) and c_cntr = (COLUMNS-1) then
				A(3*COLUMNS-1) <= data_in & "1011";

			elsif	l_cntr = (ROWS-1) and c_cntr = (COLUMNS-1) then
				A(3*COLUMNS-1) <= data_in & "1100";

			elsif	l_cntr = (ROWS-1) and c_cntr /= 0 and c_cntr /= (COLUMNS-1) then
				A(3*COLUMNS-1) <= data_in & "1101";

			elsif	l_cntr = (ROWS-1) and c_cntr = 0 then
				A(3*COLUMNS-1) <= data_in & "1110";

			elsif l_cntr /= 0 and	l_cntr /= (ROWS-1) and c_cntr = 0 then
				A(3*COLUMNS-1) <= data_in & "1111";

			else
				A(3*COLUMNS-1) <= data_in & "0001";

			end if;

	---------------------------------------------------------	
			if	c_cntr = (COLUMNS - 1) then -- End of line	
				c_cntr <= 0;-- reset the column counter
				if l_cntr = (ROWS - 1) then -- End of Frame
				   l_cntr <= 0;
				else
				   l_cntr <= l_cntr+1; --increment the line counter
				end if;	
			else
				c_cntr <= c_cntr +1; --increment the line counter
			end if;	
		else
		   A(3*COLUMNS-1) <= (others => '0');
		end if;

	------shift left------------
	for i in 0 to 3*COLUMNS-2 loop
		A(i) <= A(i+1);
	end loop;
	----------------------------	
	end if;
	end process;

	------------------------------------WINDOW update---------------------------------------------------
	code <= A(COLUMNS+1)(3 downto 0);
	P_0 <= A(0) when ((code = "1011") or (code = "1100") or (code = "1101") or (code = "0001")) else NaN;
	P_1 <= A(1) when ((code = "1011") or (code = "1100") or (code = "1101") or (code = "1110") or (code = "1111") or (code = "0001")) else NaN;
	P_2 <= A(2) when ((code = "1101") or (code = "1110") or (code = "1111") or (code = "0001")) else NaN;
	P_3 <= A(COLUMNS) when  ((code = "1001") or (code = "1010") or (code = "1011") or (code = "1100") or (code = "1101") or (code = "0001")) else NaN;
	P_4 <= A(COLUMNS +1);
	P_5 <= A(COLUMNS + 2) when ((code = "1000") or (code = "1001") or (code = "1101") or (code = "1110") or (code = "1111") or (code = "0001")) else NaN;
	P_6 <= A(2*COLUMNS) when ((code = "1001") or (code = "1010") or (code = "1011") or (code = "0001")) else NaN;
	P_7 <= A(2*COLUMNS + 1) when ((code = "1000") or (code = "1001") or (code = "1010") or (code = "1011") or (code = "1111") or (code = "0001")) else NaN;
	P_8 <= A(2*COLUMNS + 2) when  ((code = "1000") or (code = "1001") or (code = "1111") or (code = "0001")) else NaN;
---------------------------------------------------------------------------------------------------
end Behavioral;


