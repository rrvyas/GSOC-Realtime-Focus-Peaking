----------------------------------------------------------------------------------
-- Company: APERTUS (GOOGLE SUMMER OF CODE - 2018)
-- Engineer: RAHUL VYAS
-- 
-- Create Date:    00:50:43 06/11/2018 
-- Design Name:    Sobel kernel test bench 
-- Module Name:    sobel kernel test bench - Behavioral 
-- Project Name:   REALTIME FOCUS PEAKING
-- Target Devices: ZYNQ(MICROZED)
-- Description : This VHDL module simulates the implementation of peaking algorithm on the incoming window of pixels.
-----------------------------------------------------------------------------------
-- This program is free software: you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation, either version
-- 2 of the License, or (at your option) any later version.
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY sobel_tb IS
END sobel_tb;
 
ARCHITECTURE behavior OF sobel_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sobel_kernel
    PORT(
         P_0 : IN  std_logic_vector(67 downto 0);
         P_1 : IN  std_logic_vector(67 downto 0);
         P_2 : IN  std_logic_vector(67 downto 0);
         P_3 : IN  std_logic_vector(67 downto 0);
         P_4 : IN  std_logic_vector(67 downto 0);
         P_5 : IN  std_logic_vector(67 downto 0);
         P_6 : IN  std_logic_vector(67 downto 0);
         P_7 : IN  std_logic_vector(67 downto 0);
         P_8 : IN  std_logic_vector(67 downto 0);
			clk : in std_logic;
			valid_out : out std_logic;
         data_out : OUT  std_logic_vector(64 downto 0)
        );
    END COMPONENT;
    
	signal clk : std_logic := '0';
   --Inputs
   signal P_0 : std_logic_vector(67 downto 0) := (others => '0');
   signal P_1 : std_logic_vector(67 downto 0) := (others => '0');
   signal P_2 : std_logic_vector(67 downto 0) := (others => '0');
   signal P_3 : std_logic_vector(67 downto 0) := (others => '0');
   signal P_4 : std_logic_vector(67 downto 0) := (others => '0');
   signal P_5 : std_logic_vector(67 downto 0) := (others => '0');
   signal P_6 : std_logic_vector(67 downto 0) := (others => '0');
   signal P_7 : std_logic_vector(67 downto 0) := (others => '0');
   signal P_8 : std_logic_vector(67 downto 0) := (others => '0');
   signal valid_out : std_logic;
 	--Outputs
   signal data_out : std_logic_vector(64 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 5 ns; -- 30 Mhz
 
BEGIN
	-- Instantiate the Unit Under Test (UUT)
   uut: sobel_kernel PORT MAP (
          P_0 => P_0,
          P_1 => P_1,
          P_2 => P_2,
          P_3 => P_3,
          P_4 => P_4,
          P_5 => P_5,
          P_6 => P_6,
          P_7 => P_7,
          P_8 => P_8,
	  clk => clk,
          valid_out => valid_out,
          data_out => data_out
        );

--   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		

      wait for clk_period*10;
	wait for clk_period;
	P_0<= "00000000000000000000000000100000000000000000000000000000000000011001";
	P_1<= "00000000000000000000000001100000000000000000000000000000000000001001";
	P_2<= "00000000000000000000000011100000000000000000000000000000000000001001";
	P_3<= "00000000000000000000000111100000000000000000000000000000000000001001";
	P_4<= "00000000000000000000000000100000000000000000000000000000000000001001";
	P_5<= "00000000000000000000000001100000000000000000000000000000000000001001";
	P_6<= "00000000000000000000000011100000000000000000000000000000000000001001";
	P_7<= "00000000000000000000000111100000000000000000000000000000000000001001";
	P_8<= "00000000000000000000000000100000000000000000000000000000000000001001";
	wait for clk_period;
      wait;
   end process;

END;
