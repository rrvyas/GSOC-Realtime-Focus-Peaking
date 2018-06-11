----------------------------------------------------------------------------------
-- Company: APERTUS (GOOGLE SUMMER OF CODE)
-- Engineer: RAHUL VYAS
-- 
-- Create Date:    00:50:43 06/11/2018 
-- Design Name:    
-- Module Name:    Line buffer - Behavioral 
-- Project Name:   REALTIME FOCUS PEAKING
-- Target Devices: ZYNQ(MICROZED)
-- Description : This VHDL module streams in pixel values and stores them in a line buffer
--               parallely the module strems out the coressponding window pixels.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity line_buffer is
generic (  COLUMNS : natural := 720;
	      ROWS : natural := 1024;
	DATA_WIDTH : natural :=64);
			  
Port ( data_in    : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) ;
       data_valid : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
       
		 
		-- type ARRAY_NEIGHBOURS is array (0 to 8) of STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); 
       P_0        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
       P_1        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
       P_2        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
       P_3        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
       P_4        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
       P_5        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
       P_6        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
       P_7        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
       P_8        : out  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0)); -- current neighbour pixel window		 

		 --valid_pr   : out STD_LOGIC); -- valid flag to process the fetched pixel and its neighbours
end line_buffer;

architecture Behavioral of line_buffer is

--type ARRAY_NEIGHBOURS is array (0 to 8) of STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); 

--signal P : ARRAY_NEIGHBOURS; -- current neighbour pixel window
--signal valid_pr: STD_LOGIC := '0'; -- valid flag to process the fetched pixel and its neighbours
signal l_cntr : integer range 0 to ROWS := 0; --line counter
signal c_cntr : integer range 0 to COLUMNS := 0; --column counter

signal cntrl : STD_LOGIC_VECTOR (3 downto 0);

--type ARRAY_2D is array (0 to 2, 0 to COLUMNS-1) of Data_struct; -- line buffer
type ARRAY_struct is array (0 to (COLUMNS*3-1)) of STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
------------------------------------
constant NaN : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (others => '0');

signal A : ARRAY_struct := (others=>(others =>'0'));
begin

process (data_valid, clk)
begin

if rising_edge(clk) then

--------------------------------------- Data Fetch
	if data_valid = '1' then --store
		A(3*COLUMNS-1) <= data_in;
     ---------------------------------- Encode Control 
		if l_cntr = 0  and c_cntr = 0 then -- corner case - px(i)(j =0)
			A(3*COLUMNS-1)(60 downto 63) <= "1000";

		elsif l_cntr = 0  and c_cntr /= 0 and c_cntr /= (COLUMNS-1) then -- corner case - px(i)(j =0)
			A(3*COLUMNS-1)(60 downto 63) <= "1001";

		elsif l_cntr = 0  and c_cntr = (COLUMNS-1) then
			A(3*COLUMNS-1)(60 downto 63) <= "1010";
		
		elsif l_cntr /= 0 and l_cntr /= (ROWS-1) and c_cntr = (COLUMNS-1) then
			A(3*COLUMNS-1)(60 downto 63) <= "1011";
		
		elsif	l_cntr = (ROWS-1) and c_cntr = (COLUMNS-1) then
			A(3*COLUMNS-1)(60 downto 63) <= "1100";
		
		elsif	l_cntr = (ROWS-1) and c_cntr /= 0 and c_cntr /= (COLUMNS-1) then
			A(3*COLUMNS-1)(60 downto 63) <= "1101";
		
		elsif	l_cntr = (ROWS-1) and c_cntr = 0 then
			A(3*COLUMNS-1)(60 downto 63) <= "1110";
		
		elsif l_cntr /= 0 and	l_cntr /= (ROWS-1) and c_cntr = 0 then
			A(3*COLUMNS-1)(60 downto 63) <= "1111";
		
		else
			A(3*COLUMNS-1)(60 downto 63) <= "0001";
		
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
		--A(3*COLUMNS-1)(60 downto 63) <= "0000";
	end if;
	
------shift left------------
for i in 0 to 3*COLUMNS-2 loop
	A(i) <= A(i+1);
end loop;
----------------------------	
end if;
end process;


------------------------------------WINDOW update---------------------------------------------------
P_0 <= A(0) when A(COLUMNS+1)(60 downto 63) = ("1011" or "1100" or "1101" or "0001") else NaN;
P_1 <= A(1) when A(COLUMNS+1)(60 downto 63) = ("1011" or "1100" or "1101" or "1110" or "1111" or "0001") else NaN;
P_2 <= A(2) when  A(COLUMNS+1)(60 downto 63) = ("1101" or "1110" or "1111" or "0001") else NaN;
P_3 <= A(COLUMNS) when  A(COLUMNS+1)(60 downto 63) = ("1001" or "1010" or "1011" or "1100" or "1101" or "0001") else NaN;
P_4 <= A(COLUMNS +1);
P_5 <= A(COLUMNS + 2) when A(COLUMNS+1)(60 downto 63) = ("1000" or "1001" or "1101" or "1110" or "1111" or "0001") else NaN;
P_6 <= A(2*COLUMNS) when A(COLUMNS+1)(60 downto 63) = ("1001" or "1010" or "1011" or "0001") else NaN;
P_7 <= A(2*COLUMNS + 1) when A(COLUMNS+1)(60 downto 63) = ("1000" or "1001" or "1010" or "1011" or "1111" or "0001") else NaN;
P_8 <= A(2*COLUMNS + 2) when A(COLUMNS+1)(60 downto 63) = ("1000" or "1001" or "1111" or "0001") else NaN;
--valid_pr <= '0' when (A(COLUMNS+1)(60 downto 63) = "0000") else '1';
---------------------------------------------------------------------------------------------------
end Behavioral;

