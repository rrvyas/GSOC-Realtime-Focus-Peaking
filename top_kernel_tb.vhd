--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:14:28 08/04/2018
-- Design Name:   
-- Module Name:   /home/pdp/Desktop/gsoc_3/tbbbbtnt.vhd
-- Project Name:  gsoc_3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: kernel_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top_kernel_tb IS
END top_kernel_tb;
 
ARCHITECTURE behavior OF top_kernel_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT kernel_top
    PORT(
         data_in : IN  std_logic_vector(63 downto 0);
         valid_in : IN  std_logic;
         clk : IN  std_logic;
         valid_out : OUT  std_logic;
			peaking_flag : out std_logic;
         data_out : OUT  std_logic_vector(64 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : std_logic_vector(63 downto 0) := (others => '0');
   signal valid_in : std_logic := '0';
   signal clk : std_logic := '0';
	signal peaking_flag : std_logic := '0';
 	--Outputs
   signal valid_out : std_logic;
   signal data_out : std_logic_vector(64 downto 0);

   -- Clock period definitions
   constant clk_period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: kernel_top PORT MAP (
          data_in => data_in,
          valid_in => valid_in,
          clk => clk,
          valid_out => valid_out,
			 peaking_flag => peaking_flag,
          data_out => data_out
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
		valid_in <= '1';
--
      --wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000011111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000101111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000000111111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001001111";

      wait for clk_period;
	   data_in <= "0000000000001000000000100000000000100000000000010000000001011111";

-------

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
--------

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


-----------
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
      
      wait for clk_period;
		



      -- insert stimulus here 
valid_in <= '0'; data_in <= (others => '0');
    --  wait for 500 ns;
   end process;

END;
