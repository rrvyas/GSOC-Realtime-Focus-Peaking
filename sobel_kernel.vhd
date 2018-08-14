----------------------------------------------------------------------------------
-- Company: APERTUS (GOOGLE SUMMER OF CODE)
-- Engineer: RAHUL VYAS
-- 
-- Create Date:    00:50:43 06/11/2018 
-- Design Name:    Sobel kernel - final code
-- Module Name:    Sobel kerenel - Behavioral 
-- Project Name:   REALTIME FOCUS PEAKING
-- Target Devices: ZYNQ(MICROZED)
-- Description : This VHDL module applies sobel filter on the incoming pixel 
--               window and streams out peaking pixel based on threshold
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--use IEEE.STD_LOGIC_ARITH.ALL;


entity sobel_kernel is
generic (  COLUMNS : natural := 1920;
			  ROWS : natural := 1080;

			  THRESHOLD : natural := 200;
			  ONE : std_logic_vector := "000000000001";
			  DATA_WIDTH : natural :=64);
    Port ( P_0        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
			  P_1        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
			  P_2        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
           P_3        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
           P_4        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
           P_5        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
           P_6        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
           P_7        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 
           P_8        : in  STD_LOGIC_VECTOR (DATA_WIDTH+3 DOWNTO 0); -- current neighbour pixel window		 

           clk : in  STD_LOGIC;
           --valid_in : in  STD_LOGIC;
			  
           data_out : out STD_LOGIC_VECTOR (DATA_WIDTH DOWNTO 0); --65 Bits - LAST BIT IS PEAKING BIT	 
           valid_out : out  STD_LOGIC);
end sobel_kernel;

architecture Behavioral of sobel_kernel is
--function bv_negate(a : in std_logic_vector) return std_logic_vector;

--signal greyscale : std_logic_vector (11 downto 0) := "000000000000";
signal peaking_flag : std_logic := '0';
signal RED_0 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_0 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_0 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_0 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_0 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_0 : integer range 0 to 4095 := 0;
signal GREEN_int_1_0 : integer range 0 to 4095 := 0;
signal GREEN_int_2_0 : integer range 0 to 4095 := 0;
signal GREEN_int_0 : integer range 0 to 4095 := 0;
signal BLUE_int_0 : integer range 0 to 4095 := 0;
signal GREY_int_0 : integer range 0 to 4095 := 0;

signal RED_1 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_1 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_1 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_1 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_1 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_1 : integer range 0 to 4095 := 0;
signal GREEN_int_1_1 : integer range 0 to 4095 := 0;
signal GREEN_int_2_1 : integer range 0 to 4095 := 0;
signal GREEN_int_1 : integer range 0 to 4095 := 0;
signal BLUE_int_1 : integer range 0 to 4095 := 0;
signal GREY_int_1 : integer range 0 to 4095 := 0;

signal RED_2 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_2 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_2 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_2 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_2 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_2 : integer range 0 to 4095 := 0;
signal GREEN_int_1_2 : integer range 0 to 4095 := 0;
signal GREEN_int_2_2 : integer range 0 to 4095 := 0;
signal GREEN_int_2 : integer range 0 to 4095 := 0;
signal BLUE_int_2 : integer range 0 to 4095 := 0;
signal GREY_int_2 : integer range 0 to 4095 := 0;

signal RED_3 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_3 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_3 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_3 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_3 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_3 : integer range 0 to 4095 := 0;
signal GREEN_int_1_3 : integer range 0 to 4095 := 0;
signal GREEN_int_2_3 : integer range 0 to 4095 := 0;
signal GREEN_int_3 : integer range 0 to 4095 := 0;
signal BLUE_int_3 : integer range 0 to 4095 := 0;
signal GREY_int_3 : integer range 0 to 4095 := 0;

signal RED_4 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_4 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_4 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_4 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_4 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_4 : integer range 0 to 4095 := 0;
signal GREEN_int_1_4 : integer range 0 to 4095 := 0;
signal GREEN_int_2_4 : integer range 0 to 4095 := 0;
signal GREEN_int_4 : integer range 0 to 4095 := 0;
signal BLUE_int_4 : integer range 0 to 4095 := 0;
signal GREY_int_4 : integer range 0 to 4095 := 0;

signal RED_5 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_5 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_5 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_5 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_5 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_5 : integer range 0 to 4095 := 0;
signal GREEN_int_1_5 : integer range 0 to 4095 := 0;
signal GREEN_int_2_5 : integer range 0 to 4095 := 0;
signal GREEN_int_5 : integer range 0 to 4095 := 0;
signal BLUE_int_5 : integer range 0 to 4095 := 0;
signal GREY_int_5 : integer range 0 to 4095 := 0;

signal RED_6 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_6 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_6 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_6 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_6 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_6 : integer range 0 to 4095 := 0;
signal GREEN_int_1_6 : integer range 0 to 4095 := 0;
signal GREEN_int_2_6 : integer range 0 to 4095 := 0;
signal GREEN_int_6 : integer range 0 to 4095 := 0;
signal BLUE_int_6 : integer range 0 to 4095 := 0;
signal GREY_int_6 : integer range 0 to 4095 := 0;

signal RED_7 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_7 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_7 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_7 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_7 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_7 : integer range 0 to 4095 := 0;
signal GREEN_int_1_7 : integer range 0 to 4095 := 0;
signal GREEN_int_2_7 : integer range 0 to 4095 := 0;
signal GREEN_int_7 : integer range 0 to 4095 := 0;
signal BLUE_int_7 : integer range 0 to 4095 := 0;
signal GREY_int_7 : integer range 0 to 4095 := 0;

signal RED_8 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_1_8 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREEN_2_8 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal BLUE_8 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal GREY_8 : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
signal RED_int_8 : integer range 0 to 4095 := 0;
signal GREEN_int_1_8 : integer range 0 to 4095 := 0;
signal GREEN_int_2_8 : integer range 0 to 4095 := 0;
signal GREEN_int_8 : integer range 0 to 4095 := 0;
signal BLUE_int_8 : integer range 0 to 4095 := 0;
signal GREY_int_8 : integer range 0 to 4095 := 0;

--signal valid_out_a : std_logic := '0';
--signal valid_out_b : std_logic := '0';

----------------------------------------------------------------

signal P_0_0 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_1_0 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_2_0 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_3_0 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_4_0 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_5_0 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_6_0 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_7_0 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_8_0 : std_logic_vector (12 downto 0) :="0000000000000";

signal P_0_1 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_1_1 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_2_1 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_3_1 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_4_1 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_5_1 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_6_1 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_7_1 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_8_1 : std_logic_vector (12 downto 0) :="0000000000000";

signal P_0_2 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_1_2 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_2_2 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_3_2 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_4_2 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_5_2 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_6_2 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_7_2 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_8_2 : std_logic_vector (12 downto 0) :="0000000000000";

signal P_0_3 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_1_3 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_2_3 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_3_3 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_4_3 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_5_3 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_6_3 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_7_3 : std_logic_vector (12 downto 0) :="0000000000000";
signal P_8_3 : std_logic_vector (12 downto 0) :="0000000000000";

signal S0 : std_logic_vector (12 downto 0) :="0000000000000";
signal S1 : std_logic_vector (12 downto 0) :="0000000000000";
signal S2 : std_logic_vector (12 downto 0) :="0000000000000";
signal S3 : std_logic_vector (12 downto 0) :="0000000000000";
signal St0 : std_logic_vector (12 downto 0) :="0000000000000";
signal St1 : std_logic_vector (12 downto 0) :="0000000000000";
signal St2 : std_logic_vector (12 downto 0) :="0000000000000";
signal St3 : std_logic_vector (12 downto 0) :="0000000000000";

signal M :  std_logic_vector (12 downto 0) :="0000000000000";
signal M1:  std_logic_vector (12 downto 0) :="0000000000000";
signal M2:  std_logic_vector (12 downto 0) :="0000000000000";

begin

-----------------------------------------------------------------------------------------
------------------------------- Greyscal convrsion --------------------------------------
-----------------------------------------------------------------------------------------

--process(clk)
--begin
--	  if rising_edge(clk) then
			RED_0 <= P_0(67 downto 56); -- RED (63 -> 52)
			RED_int_0 <= to_integer(unsigned(RED_0));
			GREEN_1_0 <= P_0(55 downto 44); GREEN_int_1_0 <= to_integer(unsigned(GREEN_1_0));
			GREEN_2_0 <= P_0(31 downto 20); GREEN_int_2_0 <= to_integer(unsigned(GREEN_2_0));
			BLUE_0 <= P_0(43 downto 32); BLUE_int_0 <= to_integer(unsigned(BLUE_0));
			GREEN_int_0 <= (GREEN_int_1_0+ GREEN_int_2_0)/2;
			GREY_int_0 <= ((BLUE_int_0*7) + (GREEN_int_0*72) + (RED_int_0*21))/100;
			GREY_0 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_0,GREY_0'length));	
--			valid_out_a <= valid_in;
--	  end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
			RED_1 <= P_1(67 downto 56); -- RED (63 -> 52)
			RED_int_1 <= to_integer(unsigned(RED_1));
			GREEN_1_1 <= P_1(55 downto 44); GREEN_int_1_1 <= to_integer(unsigned(GREEN_1_1));
			GREEN_2_1 <= P_1(31 downto 20); GREEN_int_2_1 <= to_integer(unsigned(GREEN_2_1));
			BLUE_1 <= P_1(43 downto 32); BLUE_int_1 <= to_integer(unsigned(BLUE_1));
			GREEN_int_1 <= (GREEN_int_1_1+ GREEN_int_2_1)/2;
			GREY_int_1 <= ((BLUE_int_1*7) + (GREEN_int_1*72) + (RED_int_1*21))/100;
			GREY_1 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_1,GREY_1'length));	
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
			RED_2 <= P_2(67 downto 56); -- RED (63 -> 52)
			RED_int_2 <= to_integer(unsigned(RED_2));
			GREEN_1_2 <= P_2(55 downto 44); GREEN_int_1_2 <= to_integer(unsigned(GREEN_1_2));
			GREEN_2_2 <= P_2(31 downto 20); GREEN_int_2_2 <= to_integer(unsigned(GREEN_2_2));
			BLUE_2 <= P_2(43 downto 32); BLUE_int_2 <= to_integer(unsigned(BLUE_2));
			GREEN_int_2 <= (GREEN_int_1_2+ GREEN_int_2_2)/2;
			GREY_int_2 <= ((BLUE_int_2*7) + (GREEN_int_2*72) + (RED_int_2*21))/100;
			GREY_2 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_2,GREY_2'length));	
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
			RED_3 <= P_3(67 downto 56); -- RED (63 -> 52)
			RED_int_3 <= to_integer(unsigned(RED_3));
			GREEN_1_3 <= P_3(55 downto 44); GREEN_int_1_3 <= to_integer(unsigned(GREEN_1_3));
			GREEN_2_3 <= P_3(31 downto 20); GREEN_int_2_3 <= to_integer(unsigned(GREEN_2_3));
			BLUE_3 <= P_3(43 downto 32); BLUE_int_3 <= to_integer(unsigned(BLUE_3));
			GREEN_int_3 <= (GREEN_int_1_3+ GREEN_int_2_3)/2;
			GREY_int_3 <= ((BLUE_int_3*7) + (GREEN_int_3*72) + (RED_int_3*21))/100;
			GREY_3 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_3,GREY_3'length));	
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
			RED_4 <= P_4(67 downto 56); -- RED (63 -> 52)
			RED_int_4 <= to_integer(unsigned(RED_4));
			GREEN_1_4 <= P_4(55 downto 44); GREEN_int_1_4 <= to_integer(unsigned(GREEN_1_4));
			GREEN_2_4 <= P_4(31 downto 20); GREEN_int_2_4 <= to_integer(unsigned(GREEN_2_4));
			BLUE_4 <= P_4(43 downto 32); BLUE_int_4 <= to_integer(unsigned(BLUE_4));
			GREEN_int_4 <= (GREEN_int_1_4 + GREEN_int_2_4)/2;
			GREY_int_4 <= ((BLUE_int_4*7) + (GREEN_int_4*72) + (RED_int_4*21))/100;
			GREY_4 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_4,GREY_4'length));	
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
			RED_5 <= P_5(67 downto 56); -- RED (63 -> 52)
			RED_int_5 <= to_integer(unsigned(RED_5));
			GREEN_1_5 <= P_5(55 downto 44); GREEN_int_1_5 <= to_integer(unsigned(GREEN_1_5));
			GREEN_2_5 <= P_5(31 downto 20); GREEN_int_2_5 <= to_integer(unsigned(GREEN_2_5));
			BLUE_5 <= P_5(43 downto 32); BLUE_int_5 <= to_integer(unsigned(BLUE_5));
			GREEN_int_5 <= (GREEN_int_1_5+ GREEN_int_2_5)/2;
			GREY_int_5 <= ((BLUE_int_5*7) + (GREEN_int_5*72) + (RED_int_5*21))/100;
			GREY_5 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_5,GREY_5'length));	
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
			RED_6 <= P_6(67 downto 56); -- RED (63 -> 52)
			RED_int_6 <= to_integer(unsigned(RED_6));
			GREEN_1_6 <= P_6(55 downto 44); GREEN_int_1_6 <= to_integer(unsigned(GREEN_1_6));
			GREEN_2_6 <= P_6(31 downto 20); GREEN_int_2_6 <= to_integer(unsigned(GREEN_2_6));
			BLUE_6 <= P_6(43 downto 32); BLUE_int_6 <= to_integer(unsigned(BLUE_6));
			GREEN_int_6 <= (GREEN_int_1_6+ GREEN_int_2_6)/2;
			GREY_int_6 <= ((BLUE_int_6*7) + (GREEN_int_6*72) + (RED_int_6*21))/100;
			GREY_6 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_6,GREY_6'length));	
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
			RED_7 <= P_7(67 downto 56); -- RED (63 -> 52)
			RED_int_7 <= to_integer(unsigned(RED_7));
			GREEN_1_7 <= P_7(55 downto 44); GREEN_int_1_7 <= to_integer(unsigned(GREEN_1_7));
			GREEN_2_7 <= P_7(31 downto 20); GREEN_int_2_7 <= to_integer(unsigned(GREEN_2_7));
			BLUE_7 <= P_7(43 downto 32); BLUE_int_7 <= to_integer(unsigned(BLUE_7));
			GREEN_int_7 <= (GREEN_int_1_7+ GREEN_int_2_7)/2;
			GREY_int_7 <= ((BLUE_int_7*7) + (GREEN_int_7*72) + (RED_int_7*21))/100;
			GREY_7 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_7,GREY_7'length));	
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
			RED_8 <= P_8(67 downto 56); -- RED (63 -> 52)
			RED_int_8 <= to_integer(unsigned(RED_8));
			GREEN_1_8 <= P_8(55 downto 44); GREEN_int_1_8 <= to_integer(unsigned(GREEN_1_8));
			GREEN_2_8 <= P_8(31 downto 20); GREEN_int_2_8 <= to_integer(unsigned(GREEN_2_8));
			BLUE_8 <= P_8(43 downto 32); BLUE_int_8 <= to_integer(unsigned(BLUE_8));
			GREEN_int_8 <= (GREEN_int_1_8+ GREEN_int_2_8)/2;
			GREY_int_8 <= ((BLUE_int_8*7) + (GREEN_int_8*72) + (RED_int_8*21))/100;
			GREY_8 <= STD_LOGIC_VECTOR(to_unsigned(GREY_int_8,GREY_8'length));	
--	end if;
--end process;


------- Gradient Value in four directions------------
------------- Shifting operation --------------------
-------------------(UNCLOCKED)-----------------------

--{-2 -1 0
-- -1 0 1
--	0 1 2}

--greyscale <= P_0
P_0_0 <= not(GREY_0 & '0')+ONE; --left shift and 2's compliment ==> multiply by -2
P_1_0 <= not(GREY_1(11) & GREY_1)+ONE; -- 2's compliment ==> multiply by -1
P_2_0 <= (others => '0');
P_3_0 <= not(GREY_3(11) & GREY_3)+ONE; 
P_4_0 <= (others => '0');
P_5_0 <= GREY_5(11) & GREY_5;
P_6_0 <= (others => '0');
P_7_0 <= GREY_7(11) & GREY_7;
P_8_0 <= GREY_8 & '0'; -- left shift ==> multiply by 2


--{-1 -2 -1
-- 0 0 0
--	1 2 1}

P_0_1 <= not(GREY_0(11) & GREY_0)+ONE; 
P_1_1 <= not(GREY_1 & '0')+ONE; 
P_2_1 <= not(GREY_2(11) & GREY_2)+ONE;
P_3_1 <= (others => '0'); 
P_4_1 <= (others => '0');
P_5_1 <= (others => '0');
P_6_1 <= GREY_6(11) & GREY_6;
P_7_1 <= GREY_7 & '0';
P_8_1 <= GREY_8(11) & GREY_8;

--{-1 0 1
-- -2 0 2
--	-1 0 1}

P_0_2 <= not(GREY_0(11) & GREY_0)+ONE; 
P_1_2 <= (others => '0');  
P_2_2 <= GREY_2(11) & GREY_2;
P_3_2 <= not(GREY_3 & '0')+ONE; 
P_4_2 <= (others => '0');
P_5_2 <= GREY_5 & '0';
P_6_2 <= not(GREY_6(11) & GREY_6)+ONE; 
P_7_2 <= (others => '0');
P_8_2 <= GREY_8(11) & GREY_8;

-- {0 1 2
-- -1 0 1
-- -2 -1 0}

P_0_3 <= (others => '0');
P_1_3 <= GREY_1(11) & GREY_1;
P_2_3 <= GREY_2 & '0';
P_3_3 <= not(GREY_3(11) & GREY_3)+ONE; 
P_4_3 <= (others => '0');
P_5_3 <= GREY_5(11) & GREY_5;
P_6_3 <= not(GREY_6 & '0')+ONE; 
P_7_3 <= not(GREY_7(11) & GREY_7)+ONE;
P_8_3 <= (others => '0');

------------------------------------------------------
-------------- SUMMATION----- CLOCKED ----------------
------------------------------------------------------

--process(clk)
--begin
--	if rising_edge(clk) then
		St0 <= (P_0_0 + P_1_0 + P_2_0
	   + P_3_0 + P_4_0 + P_5_0
	   + P_6_0 + P_7_0 + P_8_0) ;
	   S0 <= St0 when St0(12) = '0' else (not(St0) + ONE);
--	   if St0(12) = '0' then S0 <= St0;  -- absolute value
--	   else S0 <= (not(St0) + ONE);
--	   end if;
--		valid_out_b <= valid_out_a; --!! Valid signal
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
		St1 <= (P_0_1 + P_1_1 + P_2_1
	   + P_3_1 + P_4_1 + P_5_1
	   + P_6_1 + P_7_1 + P_8_1) ;
	 
	   S1 <= St1 when St1(12) = '0' else (not(St1) + ONE);
--	   if St1(12) = '0' then S1 <= St1;  -- absolute value
--	   else S1 <= (not(St1) + ONE);
--	   end if;
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
		St2 <= (P_0_2 + P_1_2 + P_2_2
	   + P_3_2 + P_4_2 + P_5_2
	   + P_6_2 + P_7_2 + P_8_2) ;
	   
		S2 <= St2 when St2(12) = '0' else (not(St2) + ONE);
--	   if St2(12) = '0' then S2 <= St2;  -- absolute value
--	   else S2 <= (not(St2) + ONE);
--	   end if;
--	end if;
--end process;

--process(clk)
--begin
--	if rising_edge(clk) then
		St3 <= (P_0_3 + P_1_3 + P_2_3
	   + P_3_3 + P_4_3 + P_5_3
	   + P_6_3 + P_7_3 + P_8_3) ;
	 
	   S3 <= St3 when St3(12) = '0' else (not(St3) + ONE);
--	   if St3(12) = '0' then S3 <= St3;  -- absolute value
--	   else S3 <= (not(St3) + ONE);
--	   end if;
--	end if;
--end process;

--St0 <= (P_0_0 + P_1_0 + P_2_0
--	 + P_3_0 + P_4_0 + P_5_0
--	 + P_6_0 + P_7_0 + P_8_0) when rising_edge(clk) ;
--S0 <= St0 when St0(12) = '0' else (not(St0) + ONE); -- absolute value

	 
--St1 <= P_0_1 + P_1_1 + P_2_1
--	 + P_3_1 + P_4_1 + P_5_1
--	 + P_6_1 + P_7_1 + P_8_1 when rising_edge(clk) ;
--S1 <= St1 when St1(12) = '0' else (not(St1) + ONE); 	 

--
--St2 <= P_0_2 + P_1_2 + P_2_2
--	 + P_3_2 + P_4_2 + P_5_2
--	 + P_6_2 + P_7_2 + P_8_2 when rising_edge(clk) ;
--S2 <= St2 when St2(12) = '0' else (not(St2) + ONE);	 
--
--St3 <= P_0_3 + P_1_3 + P_2_3
--	 + P_3_3 + P_4_3 + P_5_3
--	 + P_6_3 + P_7_3 + P_8_3 when rising_edge(clk) ;
--S3 <= St3 when St3(12) = '0' else (not(St3) + ONE);	 


---------MAX Gradient--------	 

--M1 <= S0 when S0>S1 else S1;
--M2 <= S3 when S3>S2 else S2;
--M  <= M1 when M1>M2 else M2;
---------------------------------------------------------
----------- Threshold comaparator and Output ------------
-------------------(CLOCKED)-----------------------------

M1 <= S0 when S0>S1 else S1;
M2 <= S3 when S3>S2 else s2;
M  <=  M1  when  M1>M2 else M2;
Data_out(64 downto 1) <= P_4(67 downto 4);
Data_out(0) <= '1' when M>THRESHOLD else '0';
peaking_flag <= '1' when M>THRESHOLD else '0';
valid_out <= '0' when P_4(3 downto 0) = "0000" else '1'; 



--process(clk)
--begin 
--if rising_edge(clk) then
--   if S0>S1 then M1 <= S0;
--   else M1 <= S1;
--	end if;
--	if S3>S2 then M2 <= S3;
--	else M2 <= M2;
--	end if;	
--	if M1> M2 then M <= M1;
--	else M <= M2;
--	end if;
--	
--	Data_out(64 downto 1) <= P_4;
--	
--	if M>THRESHOLD then
--		Data_out(0) <= '1'; -- Peaking bit is HIGH
--		peaking_flag <= '1';
--	else
--		Data_out(0) <= '0'; -- Peaking bit is LOW
--		peaking_flag <= '0';
--	end if;	
--	
--	valid_out <= valid_out_b; --!! Valid signal
--
----	Data_out(11 downto 0)<= P_4(11 downto 0); --RED
----	if M<THRESHOLD then
----		Data_out(23 downto 12)<= P_4(23 downto 12); --GREEN
----	else 
----		Data_out(23 downto 12)<= "000000000000";
----	end if;	
----	if M<THRESHOLD then
----		Data_out(35 downto 24)<= P_4(35 downto 24); --BLUE
----	else	
----		Data_out(35 downto 24)<= "000000000000";
----	end if;
----	Data_out(63 downto 36)<= P_4(63 downto 36); --overlay
--
--end if;
--end process;	
end Behavioral;
-----------------------------

--	Data_out(11 downto 0)<= P_4(11 downto 0);
--	Data_out(23 downto 12)<= P_4(23 downto 12) when M>THRESHOLD else "000000000000";
--	Data_out(35 downto 24)<= P_4(35 downto 24) when M>THRESHOLD else "000000000000";
--	Data_out(63 downto 36)<= P_4(63 downto 36);




--
--
--process(clk)
--begin
--	if rising_edge(clk) then
--			RED <= data_in(63 downto 52); -- RED (63 -> 52)
--			RED_int <= to_integer(unsigned(RED));
--			GREEN_1 <= data_in(51 downto 40); GREEN_int_1 <= to_integer(unsigned(GREEN_1));
--			GREEN_2 <= data_in(27 downto 16); GREEN_int_2 <= to_integer(unsigned(GREEN_2));
--			BLUE <= data_in(39 downto 28); BLUE_int <= to_integer(unsigned(BLUE));
--			GREEN_int <= (GREEN_int_1+ GREEN_int_2)/2;
--			GREEN <= STD_LOGIC_VECTOR(to_unsigned(GREEN_int,GREEN'length));
--			GREY_int <= ((BLUE_int*7) + (GREEN_int*72) + (RED_int*21))/100;
--			GREY <= STD_LOGIC_VECTOR(to_unsigned(GREY_int,GREY'length));	
--			valid_out <= valid_in;
--	end if;
--end process;
--
----greyscale <= P_0
--P_0_0 <= not((P_0(47 downto 36) & '0'))+ONE; --left shift and 2's compliment ==> multiply by -2
--P_1_0 <= not(P_1(47) & P_1(47 downto 36))+ONE; -- 2's compliment ==> multiply by -1
--P_2_0 <= (others => '0');
--P_3_0 <= not(P_3(47) & P_3(47 downto 36))+ONE; 
--P_4_0 <= (others => '0');
--P_5_0 <= P_5(47) & P_5(47 downto 36);
--P_6_0 <= (others => '0');
--P_7_0 <= P_7(47) & P_7(47 downto 36);
--P_8_0 <= P_8(47 downto 36) & '0'; -- left shift ==> multiply by 2
