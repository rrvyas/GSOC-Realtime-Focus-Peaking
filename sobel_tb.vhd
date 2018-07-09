--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:20:57 07/01/2018
-- Design Name:   
-- Module Name:   /home/pdp/Desktop/gsoc_3/sobel_tb.vhd
-- Project Name:  gsoc_3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sobel_kernel
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
 
ENTITY sobel_tb IS
END sobel_tb;
 
ARCHITECTURE behavior OF sobel_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sobel_kernel
    PORT(
         P_0 : IN  std_logic_vector(63 downto 0);
         P_1 : IN  std_logic_vector(63 downto 0);
         P_2 : IN  std_logic_vector(63 downto 0);
         P_3 : IN  std_logic_vector(63 downto 0);
         P_4 : IN  std_logic_vector(63 downto 0);
         P_5 : IN  std_logic_vector(63 downto 0);
         P_6 : IN  std_logic_vector(63 downto 0);
         P_7 : IN  std_logic_vector(63 downto 0);
         P_8 : IN  std_logic_vector(63 downto 0);
         data_out : OUT  std_logic_vector(63 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal P_0 : std_logic_vector(63 downto 0) := (others => '0');
   signal P_1 : std_logic_vector(63 downto 0) := (others => '0');
   signal P_2 : std_logic_vector(63 downto 0) := (others => '0');
   signal P_3 : std_logic_vector(63 downto 0) := (others => '0');
   signal P_4 : std_logic_vector(63 downto 0) := (others => '0');
   signal P_5 : std_logic_vector(63 downto 0) := (others => '0');
   signal P_6 : std_logic_vector(63 downto 0) := (others => '0');
   signal P_7 : std_logic_vector(63 downto 0) := (others => '0');
   signal P_8 : std_logic_vector(63 downto 0) := (others => '0');
--	signal grscl_0 : std_logic_vector (11 downto 0) := (others => '0');
--	signal grscl_1 : std_logic_vector (11 downto 0) := (others => '0');
--	signal grscl_2 : std_logic_vector (11 downto 0) := (others => '0');
--	signal grscl_3 : std_logic_vector (11 downto 0) := (others => '0');
--	signal grscl_4 : std_logic_vector (11 downto 0) := (others => '0');
--	signal grscl_5 : std_logic_vector (11 downto 0) := (others => '0');
--	signal grscl_6 : std_logic_vector (11 downto 0) := (others => '0');
--	signal grscl_7 : std_logic_vector (11 downto 0) := (others => '0');
--	signal grscl_8 : std_logic_vector (11 downto 0) := (others => '0');






 	--Outputs
   signal data_out : std_logic_vector(63 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   --constant clk_period : time := 10 ns;
 
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
          data_out => data_out
        );

--   -- Clock process definitions
--   clk_process :process
--   begin
--		clk <= '0';
--		wait for clk_period/2;
--		clk <= '1';
--		wait for clk_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

  --    wait for clk_period*10;
P_0<= "0000000000000000000000000010000000000000000000000000000000000001";
P_1<= "0000000000000000000000000110000000000000000000000000000000000000";
P_2<= "0000000000000000000000001110000000000000000000000000000000000000";
P_3<= "0000000000000000000000011110000000000000000000000000000000000000";
P_4<= "0000000000000000000000000010000000000000000000000000000000000000";
P_5<= "0000000000000000000000000110000000000000000000000000000000000000";
P_6<= "0000000000000000000000001110000000000000000000000000000000000000";
P_7<= "0000000000000000000000011110000000000000000000000000000000000000";
P_8<= "0000000000000000000000000010000000000000000000000000000000000000";



      -- insert stimulus here 

      wait;
   end process;

--g_process: process
--begin
--grscl_0 <= P_0(47 downto 36); 
--grscl_1 <= P_1(47 downto 36); 
--grscl_2 <= P_2(47 downto 36); 
--grscl_3 <= P_3(47 downto 36); 
--grscl_4 <= P_4(47 downto 36); 
--grscl_5 <= P_5(47 downto 36); 
--grscl_6 <= P_6(47 downto 36); 
--grscl_7 <= P_7(47 downto 36); 
--grscl_8 <= P_8(47 downto 36); 
-- wait;
--end process;

END;
