-- Temporizador para MEDTH
--
-- Genera las señales de temporizacion para el resto de circuitos. Todas son tics de un periodo
-- de reloj:
-- tic_1ms
-- Genericos:
---- DIV_1ms (divisor para generar tics de 1 ms a partir del reloj de 50 MHz)
---- Los valores por defecto son para sintesis
--
--    Designer: DTE
--    Versión: 1.0
--    Fecha: 24-11-2016

library ieee;
use ieee.std_logic_1164.all;

use ieee.std_logic_unsigned.all;

entity timer is 
generic(
    DIV_1ms : natural :=49999
   );
port(
    clk           : in std_logic;
    nRst          : in std_logic;
    tic_1ms       : buffer std_logic
    );  
end entity;

architecture rtl of timer is
  signal cnt_div_1ms : std_logic_vector(16 downto 0);
begin
  
 -- generación del tic de 1 ms
 process(clk, nRst)
  begin
    if nRst = '0' then
      cnt_div_1ms <= (others => '0');
    elsif clk'event and clk = '1' then
      if tic_1ms = '1' then
        cnt_div_1ms <= (others => '0');
      else
        cnt_div_1ms <= cnt_div_1ms + 1;
      end if;
    end if;
  end process;

  tic_1ms <= '1' when cnt_div_1ms = DIV_1ms else '0';

end rtl;