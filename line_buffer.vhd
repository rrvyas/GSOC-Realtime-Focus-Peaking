----------------------------------------------------------------------------------
-- Company: Apertus Organisation (Gpogle Summer of Code)
-- Engineer: Rahul R. Vyas
-- 
-- Create Date:    20:35:42 05/24/2018 
-- Design Name: 
-- Module Name:    line_buffer - Behavioral 
-- Project Name:   Realtime focus peaking
-- Target Devices: ZYNQ (MicroZed)
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity line_buffer is
generic (  COLUMNS : natural := 720;
			  ROWS : natural := 1024;
			  DATA_WIDTH : natural :=64);
			  
Port ( data_in    : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) ;
       data_valid : in  STD_LOGIC;
       clk        : in  STD_LOGIC;
		 read_en    : out STD_LOGIC; -- enable/valid data for the kernel
		-- l_cntr     : out integer range 0 to ROWS; --line counter
       data_out   : out  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0));
end line_buffer;

architecture Behavioral of line_buffer is
type ARRAY_2D is array (0 to 2, 0 to COLUMNS-1) of STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
type ARRAY_1D is array (0 to COLUMNS-1) of STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); 
type ARRAY_NEIGHBOURS is array (0 to 8) of STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); 

signal A : ARRAY_2D;-- buffer (2D)
signal B : ARRAY_1D;-- input pixel line buffer
signal P : ARRAY_NEIGHBOURS; -- current neighbour pixel window
signal j : integer range 0 to 1024; 
signal rd_ptr, wr_ptr : integer range 0 to 3;
signal l_cntr : integer range 0 to ROWS; --line counter
signal c_cntr : integer range 0 to COLUMNS; --column counter
signal result : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); --processed pixel array from the kernel
signal init   : STD_LOGIC; -- indicates when should the buffer alow kernel to start processing
begin

process (data_valid, clk)
begin

if data_valid = '1' then
	if rising_edge(clk) then
			
		if init_cntr = 2 then
			B(j) <= data_in; -- store the incoming pixel vector in line buffer B
		
			if j=0 then -- corner case {first pixel of a line}
				P(0) <= (others => '0');
				P(3) <= (others => '0');
				P(6) <= (others => '0');
				P(1) <= A(0,j); P(2) <= A(0,j+1); P(4) <= A(1,j);
				P(5) <= A(1,j+1); P(7) <= A(2,j); P(8) <= A(2,j+1);	
			
			elsif j= COLUMNS then -- corner case {last pixel of a line}
				P(2) <= (others => '0');
				P(5) <= (others => '0');
				P(8) <= (others => '0');
				P(0) <= A(0,j-1); P(1) <= A(0,j); P(3) <= A(1,j-1);
				P(4) <= A(1,j); P(6) <= A(2,j-1); P(7) <= A(2,j);	
			
			else -- normal case
				P(0) <= A(0,j-1); P(1) <= A(0,j); P(2) <= A(0,j+1);
				P(3) <= A(1,j-1); P(4) <= A(1,j); P(5) <= A(1,j+1);
				P(6) <= A(2,j-1); P(7) <= A(2,j); P(8) <= A(2,j+1);
				
			end if;	
			read_en <='1'; -- valid data for the kernel
			-- kernel_structure();
			--data_out <= result;
		
			if j = COLUMNS then -- End of line
				A(0) <= A(1); A(1) <= A(2); A(2) <= B; -- shift upwards
				j <= 0; -- reset the column counter
				if l_cntr = ROWS then -- end of frame
					l_cntr <= 0;
				else
					l_cntr <= l_cntr+1; --increment the line counter
				end if;
			else
				j <= j+1; -- increment the column counter	
			end if;
		else -- for initial two lines
			B(j) <= data_in; -- store the incoming pixel vector in line buffer B
			if j = COLUMNS then -- End of line
				j <= 0;
				init_cntr <= init_cntr + 1;
				A(0) <= A(1); A(1) <= A(2); A(2) <= B; -- shift upwards
			else
				j <= j+1;
			end if;
		end if;
	end if;
else
	read_en <= '0'; -- the data reaching kernel input port is not valid	
end if;	

end process;

end Behavioral;

