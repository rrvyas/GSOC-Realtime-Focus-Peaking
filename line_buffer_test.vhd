----------------------------------------------------------------------------------
-- Company: APERTUS (GOOGLE SUMMER OF CODE - 2018)
-- Engineer: RAHUL VYAS
-- 
-- Create Date:    00:50:43 06/11/2018 
-- Design Name:    Line buffer test bench 
-- Module Name:    Line buffer test bench - Behavioral 
-- Project Name:   REALTIME FOCUS PEAKING
-- Target Devices: ZYNQ(MICROZED)
-- Description : This VHDL module simulates streamed in pixel values and shows the coressponding window pixels.
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
 
ENTITY tb2 IS
END tb2;
 
ARCHITECTURE behavior OF tb2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT line_buffer
    PORT(
         data_in : IN  std_logic_vector(63 downto 0);
         data_valid : IN  std_logic;
         clk : IN  std_logic;
	 data_valid_out : out std_logic;
         P_0 : OUT  std_logic_vector(63 downto 0);
         P_1 : OUT  std_logic_vector(63 downto 0);
         P_2 : OUT  std_logic_vector(63 downto 0);
         P_3 : OUT  std_logic_vector(63 downto 0);
         P_4 : OUT  std_logic_vector(63 downto 0);
         P_5 : OUT  std_logic_vector(63 downto 0);
         P_6 : OUT  std_logic_vector(63 downto 0);
         P_7 : OUT  std_logic_vector(63 downto 0);
         P_8 : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : std_logic_vector(63 downto 0) := (others => '0');
   signal data_valid : std_logic := '0';
   signal clk : std_logic := '0';

   --Outputs
   signal P_0 : std_logic_vector(63 downto 0);
   signal P_1 : std_logic_vector(63 downto 0);
   signal P_2 : std_logic_vector(63 downto 0);
   signal P_3 : std_logic_vector(63 downto 0);
   signal P_4 : std_logic_vector(63 downto 0);
   signal P_5 : std_logic_vector(63 downto 0);
   signal P_6 : std_logic_vector(63 downto 0);
   signal P_7 : std_logic_vector(63 downto 0);
   signal P_8 : std_logic_vector(63 downto 0);

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: line_buffer PORT MAP (
          data_in => data_in,
          data_valid => data_valid,
          clk => clk,
          P_0 => P_0,
          P_1 => P_1,
          P_2 => P_2,
          P_3 => P_3,
          P_4 => P_4,
          P_5 => P_5,
          P_6 => P_6,
          P_7 => P_7,
          P_8 => P_8
        );
   -- Clock process definitions
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
	   data_valid <= '1';

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000011111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000101111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000111111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001001111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001011111";
---
      wait for clk_period;

	   data_in <= "0000000000001000000000100000000000100000000000010000000000011111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000101111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000111111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001001111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001011111";
---
      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000011111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000101111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000111111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001001111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001011111";

---
      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000011111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000101111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000111111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001001111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001011111";
---
      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000011111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000101111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000111111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001001111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001011111";

   data_valid <= '0';
   end process;

END;
