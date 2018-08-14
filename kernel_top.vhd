----------------------------------------------------------------------------------
-- Company: APERTUS (GOOGLE SUMMER OF CODE-2018)
-- Engineer: RAHUL VYAS
-- 
-- Create Date:    00:50:43 06/11/2018 
-- Design Name:    Focus peaking top module 
-- Module Name:    kernel_top - Behavioral 
-- Project Name:   REALTIME FOCUS PEAKING
-- Target Devices: ZYNQ(MICROZED)
-----------------------------------------------------------------------------------
-- This program is free software: you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation, either version
-- 2 of the License, or (at your option) any later version.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kernel_top is
generic (DATA_WIDTH : natural :=64);

    Port ( data_in   : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
           valid_in  : in  STD_LOGIC;
	   clk       : in  STD_LOGIC;
	   valid_out : out STD_LOGIC;
	   data_out  : out STD_LOGIC_VECTOR (DATA_WIDTH DOWNTO 0)); -- Extra bit for peaking 
    end kernel_top;

architecture Behavioral of kernel_top is

	component line_buffer

	Port ( data_in    : in  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) ;
	       data_valid : in  STD_LOGIC;
	       clk        : in  STD_LOGIC;

	       P_0        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_1        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_2        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_3        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_4        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_5        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_6        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_7        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_8        : out  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0)); -- current neighbour pixel window		 

	end component;
	----------------------------------------------------------------
	component sobel_kernel
	Port ( P_0        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_1        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_2        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_3        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_4        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_5        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_6        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_7        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       P_8        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	       clk        : in  std_logic;
	       valid_out  : out STD_LOGIC;
	       data_out   : out STD_LOGIC_VECTOR (DATA_WIDTH DOWNTO 0)); 	 
	end component;
	--------------------------------------------------------------------
	signal P_0_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	signal P_1_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	signal P_2_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	signal P_3_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	signal P_4_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	signal P_5_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	signal P_6_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	signal P_7_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
	signal P_8_i        :   STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 

        begin

	C1:line_buffer port map
	(
	data_in     =>  data_in,
	data_valid  =>  valid_in,
	clk         =>  clk,
	P_0 =>  P_0_i,     		 
	P_1 =>  P_1_i,        	 
	P_2 =>  P_2_i,        		 
	P_3 =>  P_3_i,        	 
	P_4 =>  P_4_i,        	 
	P_5 =>  P_5_i,        		 
	P_6 =>  P_6_i,        		 
	P_7 =>  P_7_i,        	 
	P_8 =>  P_8_i       
	);

	C2: sobel_kernel port map
	(
	 valid_out => valid_out,
	 P_0 =>  P_0_i,     		 
	 P_1 =>  P_1_i,        	 
	 P_2 =>  P_2_i,        		 
	 P_3 =>  P_3_i,        	 
	 P_4 =>  P_4_i,        	 
	 P_5 =>  P_5_i,        		 
	 P_6 =>  P_6_i,        		 
	 P_7 =>  P_7_i,        	 
	 P_8 =>  P_8_i,
	 clk =>  clk,
	 data_out => data_out
	);
end Behavioral;

