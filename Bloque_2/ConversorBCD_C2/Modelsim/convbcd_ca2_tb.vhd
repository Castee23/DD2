library ieee;
use ieee.std_logic_1164.all;

entity convbcd_ca2_tb is
end entity;

architecture test of convbcd_ca2_tb is 
  signal clk:   std_logic;
  signal nRST:  std_logic;
  signal num_bcd: std_logic_vector(11 downto 0);
  signal signo: std_logic;
  constant T_CLK: time := 20 ns;
  
begin
  

dut: entity work.conv_bcd_ca2(rtl)
     port map(num_bcd => num_bcd,
              signo => signo);

process
begin
  clk <= '0';
  wait for T_CLK/2;
  clk <= '1';
  wait for T_CLK/2;
end process;

process
begin
-- Inicializaci?n as?ncrona
   nRST <= '0';     
   wait until clk'event and clk = '1';  
   wait until clk'event and clk = '1'; 
   nRST <= '1';
   wait until clk'event and clk = '1'; 
   num_bcd <= "000000000000";   
   signo <= '0';
   wait until clk'event and clk = '1'; 
   num_bcd <= "100110011001";   -- 999
   signo <= '0';
   wait until clk'event and clk = '1'; 
   num_bcd <= "100110011001";   -- -999
   signo <= '1';
   wait until clk'event and clk = '1'; 
   num_bcd <= "000000000101";   -- -5
   signo <= '1';
   wait until clk'event and clk = '1'; 
   num_bcd <= "000001010111";   -- -57
   signo <= '1';
   wait until clk'event and clk = '1';
   num_bcd <= "010101110010";   -- 572
   signo <= '0';
   wait until clk'event and clk = '1';
   num_bcd <= "010101110010";   -- -572
   signo <= '1';
   wait until clk'event and clk = '1';
   num_bcd <= "000001101001";   -- 69
   signo <= '0';
   wait until clk'event and clk = '1';
   num_bcd <= "010001011000";   -- 458
   signo <= '0';
   wait until clk'event and clk = '1';
   wait for 10*T_CLK;
   assert false
   report "fone"
   severity failure;

  end process;

      
end test;