library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity fsm_calculadora is
port(
     clk             : in std_logic;
     nRst            : in std_logic;
     tecla_pulsada   : in std_logic;
     tecla           : in std_logic_vector(3 downto 0);
     op1             : out  std_logic_vector(11 downto 0);
     op1_sgn         : out std_logic;
     op2             : out std_logic_vector(11 downto 0);
     op2_sgn         : out std_logic;
     operacion       : out std_logic_vector(1 downto 0);
     pres            : out std_logic_vector(1 downto 0)
);
end entity;

architecture rtl of fsm_calculadora is

  type t_estados is (OPERANDO1, OPERANDO2, RESULTADO);
  signal estado : t_estados;

  signal op1_reg     : std_logic_vector(11 downto 0);
  signal op2_reg     : std_logic_vector(11 downto 0);
  signal op1_sgn_reg : std_logic;
  signal op2_sgn_reg : std_logic;
  signal operacion_reg     : std_logic_vector(1 downto 0);

begin

  process(clk, nRst)
  begin
    if nRst = '0' then
      estado <= OPERANDO1;
      op1_reg    <= (others => '0');
      op2_reg    <= (others => '0');
      op1_sgn_reg   <= '0';
      op2_sgn_reg   <= '0';
      operacion_reg   <= "00";
   elsif clk'event and clk = '1' then
     if tecla_pulsada = '1' then
     case estado is

     when OPERANDO1 =>
       if tecla <= X"9" then --Meter dato
         if op1_reg = X"000" then
           if tecla /= X"0" then
             op1_reg(3 downto 0) <= tecla;
           end if;
         elsif op1_reg(11 downto 8) = X"0" then
           op1_reg <= op1_reg(7 downto 0)&tecla; 
         end if;

       elsif tecla = X"C" then --Cambio sgino
         op1_sgn_reg <= not op1_sgn_reg;

       elsif tecla = X"A" or tecla = X"D" or tecla = X"E" then 
         if tecla = X"A" then
           operacion_reg <= "00";-- Suma
         elsif tecla = X"D" then
           operacion_reg <= "01";  --Resta
         elsif tecla = X"E" then
           operacion_reg <= "10";  --Multplicacion
         end if;
       estado <= OPERANDO2;
       end if;

     when OPERANDO2 =>
       if tecla <= X"9" then --Meter dato
         if op2_reg = X"000" then
           if tecla /= X"0" then
             op2_reg(3 downto 0) <= tecla;
           end if;
         elsif op2_reg(11 downto 8) = X"0" then
           op2_reg <= op2_reg(7 downto 0)&tecla; 
         end if;

       elsif tecla = X"C" then --Cambio signo
         op2_sgn_reg <= not op2_sgn_reg;

       elsif tecla = X"B" then
         estado <= RESULTADO;
       end if;

     when RESULTADO =>
         op2_reg       <= (others => '0');
         op1_sgn_reg   <= '0';
         op2_sgn_reg   <= '0';

           if tecla <= X"9" then
             op1_reg <= "00000000"&tecla;
           else 
             op1_reg    <= (others => '0');
           end if;
        estado <= OPERANDO1;
   

      end case;
     end if;
    end if;
  end process;

  pres <= "00" when estado = OPERANDO1 else
          "01" when estado = OPERANDO2 else
          "10";

  op1       <= op1_reg;
  op2       <= op2_reg;
  op1_sgn   <= op1_sgn_reg;
  op2_sgn   <= op2_sgn_reg;
  operacion <= operacion_reg;

end rtl;
