--Conversor BCD Ca2

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity conv_bcd_ca2 is
port(num_bcd :	in std_logic_vector(11 downto 0);
     signo :	in std_logic;

     num_ca2 :	buffer std_logic_vector(10 downto 0));
end entity;

architecture rtl of conv_bcd_ca2 is
  signal num_bin :	std_logic_vector(10 downto 0);
begin

num_bin <= '0'&((num_bcd(11 downto 8)&"000000") + (num_bcd(11 downto 8)&"00000") + (num_bcd(11 downto 8)&"00") + (num_bcd(7 downto 4)&"000") + (num_bcd(7 downto 4)&"0") + num_bcd(3 downto 0));

num_ca2 <= not num_bin + 1 when signo = '1' else
           num_bin;

end rtl;