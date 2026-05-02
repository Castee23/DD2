library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity convca2_bcd_tb is
end convca2_bcd_tb;

architecture test of convca2_bcd_tb is

    signal clk     : std_logic;
    signal nRst    : std_logic;
    signal inicio  : std_logic;
    signal num_c2 : std_logic_vector(19 downto 0);
    signal num_bcd : std_logic_vector(23 downto 0);
    signal fin     : std_logic;

    constant T_CLK: time := 20 ns;

begin

    dut: entity work.convca2_bcd
        port map (
            clk     => clk,
            nRst    => nRst,
            inicio  => inicio,
            num_c2 => num_c2,
            num_bcd => num_bcd,
            fin     => fin
        );

process
begin
  clk <= '0';
  wait for T_CLK/2;
  clk <= '1';
  wait for T_CLK/2;
end process;

    process
    begin

        nRst <= '0';     
        wait until clk'event and clk = '1';  
        wait until clk'event and clk = '1'; 
        nRst <= '1';

        num_c2 <= X"1E240"; 
        inicio <= '1';         
        wait until clk'event and clk = '1'; 
        inicio <= '0';         
        
        wait until fin = '1';

        wait until clk'event and clk = '1'; 
        wait until clk'event and clk = '1'; 

        num_c2 <= X"E1DC0"; 
        inicio <= '1';
        wait until clk'event and clk = '1'; 
        inicio <= '0';

        wait until fin = '1';

        wait until clk'event and clk = '1'; 
        wait until clk'event and clk = '1'; 

        num_c2 <= X"FFFFB"; 
        inicio <= '1';
        wait until clk'event and clk = '1'; 
        inicio <= '0';

        wait until fin = '1';
        wait for 10*T_CLK;

        assert false
        report "fone"
        severity failure;
    end process;

end test;