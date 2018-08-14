--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:29:52 06/24/2018
-- Design Name:   
-- Module Name:   /home/pdp/Desktop/gsoc_3/tb2.vhd
-- Project Name:  gsoc_3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: line_buffer
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
      -- hold reset state for 100 ns.
     -- wait for 100 ns;	

     -- wait for clk_period*2;
		--data_in <= "0000000000000000000000000000000000000000000000000000000000001111";
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




      -- insert stimulus here 
data_valid <= '0';
    --  wait for 500 ns;
   end process;

END;
