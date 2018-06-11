----------------------------------------------------------------------------------
-- Company: APERTUS (GOOGLE SUMMER OF CODE)
-- Engineer: RAHUL VYAS
-- 
-- Create Date:    00:50:43 06/11/2018 
-- Design Name:    
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
generic (  COLUMNS : natural := 720;
	 THRESHOLD : natural := 200;
	      ROWS : natural := 1024;
	       ONE : std_logic_vector := "000000000001";
	DATA_WIDTH : natural :=64);
    Port ( P_0        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
	   P_1        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
	   P_2        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
           P_3        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
           P_4        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
           P_5        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
           P_6        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
           P_7        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 
           P_8        : in  STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0); -- current neighbour pixel window		 

        --   clk      : in  STD_LOGIC;
        --   valid_in : in  STD_LOGIC;
			  
             data_out : out STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0)); 	 
        --  valid_out : out  STD_LOGIC);
end sobel_kernel;

architecture Behavioral of sobel_kernel is
function bv_negate(a : in std_logic_vector) return std_logic_vector;

signal P_0_0 : std_logic_vector (11 downto 0) :="000000000000";
signal P_1_0 : std_logic_vector (11 downto 0) :="000000000000";
signal P_2_0 : std_logic_vector (11 downto 0) :="000000000000";
signal P_3_0 : std_logic_vector (11 downto 0) :="000000000000";
signal P_4_0 : std_logic_vector (11 downto 0) :="000000000000";
signal P_5_0 : std_logic_vector (11 downto 0) :="000000000000";
signal P_6_0 : std_logic_vector (11 downto 0) :="000000000000";
signal P_7_0 : std_logic_vector (11 downto 0) :="000000000000";
signal P_8_0 : std_logic_vector (11 downto 0) :="000000000000";

signal P_0_1 : std_logic_vector (11 downto 0) :="000000000000";
signal P_1_1 : std_logic_vector (11 downto 0) :="000000000000";
signal P_2_1 : std_logic_vector (11 downto 0) :="000000000000";
signal P_3_1 : std_logic_vector (11 downto 0) :="000000000000";
signal P_4_1 : std_logic_vector (11 downto 0) :="000000000000";
signal P_5_1 : std_logic_vector (11 downto 0) :="000000000000";
signal P_6_1 : std_logic_vector (11 downto 0) :="000000000000";
signal P_7_1 : std_logic_vector (11 downto 0) :="000000000000";
signal P_8_1 : std_logic_vector (11 downto 0) :="000000000000";

signal P_0_2 : std_logic_vector (11 downto 0) :="000000000000";
signal P_1_2 : std_logic_vector (11 downto 0) :="000000000000";
signal P_2_2 : std_logic_vector (11 downto 0) :="000000000000";
signal P_3_2 : std_logic_vector (11 downto 0) :="000000000000";
signal P_4_2 : std_logic_vector (11 downto 0) :="000000000000";
signal P_5_2 : std_logic_vector (11 downto 0) :="000000000000";
signal P_6_2 : std_logic_vector (11 downto 0) :="000000000000";
signal P_7_2 : std_logic_vector (11 downto 0) :="000000000000";
signal P_8_2 : std_logic_vector (11 downto 0) :="000000000000";

signal P_0_3 : std_logic_vector (11 downto 0) :="000000000000";
signal P_1_3 : std_logic_vector (11 downto 0) :="000000000000";
signal P_2_3 : std_logic_vector (11 downto 0) :="000000000000";
signal P_3_3 : std_logic_vector (11 downto 0) :="000000000000";
signal P_4_3 : std_logic_vector (11 downto 0) :="000000000000";
signal P_5_3 : std_logic_vector (11 downto 0) :="000000000000";
signal P_6_3 : std_logic_vector (11 downto 0) :="000000000000";
signal P_7_3 : std_logic_vector (11 downto 0) :="000000000000";
signal P_8_3 : std_logic_vector (11 downto 0) :="000000000000";

signal S0 : std_logic_vector (11 downto 0) :="000000000000";
signal S1 : std_logic_vector (11 downto 0) :="000000000000";
signal S2 : std_logic_vector (11 downto 0) :="000000000000";
signal S3 : std_logic_vector (11 downto 0) :="000000000000";
signal M: std_logic_vector (11 downto 0) :="000000000000";
signal M1: std_logic_vector (11 downto 0) :="000000000000";
signal M2: std_logic_vector (11 downto 0) :="000000000000";


begin

------- Gradient Value in four directions--

--{-2 -1 0
-- -1 0 1
-- 0 1 2}

P_0_0 <= not((P_0(46 downto 36) & '0'))+ONE; --left shift and 2's compliment ==> multiply by -2
P_1_0 <= not(P_1(47 downto 36))+ONE; -- 2's compliment ==> multiply by -1
P_2_0 <= (others => '0');
P_3_0 <= not(P_3(47 downto 36))+ONE; 
P_4_0 <= (others => '0');
P_5_0 <= P_5(47 downto 36);
P_6_0 <= (others => '0');
P_7_0 <= P_7(47 downto 36);
P_8_0 <= P_8(46 downto 36) & '0'; -- left shift ==> multiply by 2

--{-1 -2 -1
-- 0 0 0
-- 1 2 1}

P_0_1 <= not(P_0(47 downto 36))+ONE; 
P_1_1 <= not(P_1(46 downto 36) & '0')+ONE; 
P_2_1 <= not(P_2(47 downto 36))+ONE;
P_3_1 <= (others => '0'); 
P_4_1 <= (others => '0');
P_5_1 <= (others => '0');
P_6_1 <= P_6(47 downto 36);
P_7_1 <= P_7(46 downto 36) & '0';
P_8_1 <= P_8(47 downto 36);

--{-1 0 1
-- -2 0 2
-- -1 0 1}
P_0_2 <= not(P_0(47 downto 36))+ONE; 
P_1_2 <= (others => '0');  
P_2_2 <= P_2(47 downto 36);
P_3_2 <= not(P_3(46 downto 36) & '0')+ONE; 
P_4_2 <= (others => '0');
P_5_2 <= P_5(46 downto 36) & '0';
P_6_2 <= not(P_6(47 downto 36))+ONE; 
P_7_2 <= (others => '0');
P_8_2 <= P_8(47 downto 36);

-- {0 1 2
-- -1 0 1
-- -2 -1 0}
P_0_3 <= (others => '0');
P_1_3 <= P_1(47 downto 36);
P_2_3 <= P_2(46 downto 36) & '0';
P_3_3 <= not(P_3(47 downto 36))+ONE; 
P_4_3 <= (others => '0');
P_5_3 <= P_5(47 downto 36);
P_6_3 <= not(P_6(46 downto 36)&'0')+ONE; 
P_7_3 <= not(P_7(47 downto 36))+ONE;
P_8_3 <= (others => '0');

S0 <= P_0_0 + P_1_0 + P_2_0
	 + P_3_0 + P_4_0 + P_5_0
	 + P_6_0 + P_7_0 + P_8_0;
	 
S1 <= P_0_1 + P_1_1 + P_2_1
	 + P_3_1 + P_4_1 + P_5_1
	 + P_6_1 + P_7_1 + P_8_1;
	 
S2 <= P_0_2 + P_1_2 + P_2_2
	 + P_3_2 + P_4_2 + P_5_2
	 + P_6_2 + P_7_2 + P_8_2;

S3 <= P_0_3 + P_1_3 + P_2_3
	 + P_3_3 + P_4_3 + P_5_3
	 + P_6_3 + P_7_3 + P_8_3;

---------MAX Gradient--------	 
M1 <= S0 when S0>S1 else S1;
M2 <= S3 when S3>S2 else S2;
M <= M1 when M1>M2 else M2;
-----------------------------

Data_out(11 downto 0)<= P_4(11 downto 0);
Data_out(23 downto 12)<= P_4(23 downto 12) when M>THRESHOLD else "000000000000";
Data_out(35 downto 24)<= P_4(35 downto 24) when M>THRESHOLD else "000000000000";
Data_out(63 downto 36)<= P_4(63 downto 36);
-----------------------------


end Behavioral;

