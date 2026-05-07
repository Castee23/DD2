library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;

entity alu is
    port(
        op1_i     : in  std_logic_vector(10 downto 0);
       -- op1_sgn   : in  std_logic; 
        op2_i     : in  std_logic_vector(10 downto 0);
        --op2_sgn   : in  std_logic; 
        operacion : in  std_logic_vector(1 downto 0);
        res_o     : out std_logic_vector(20 downto 0); 
        inicio    : out std_logic
    );
end entity;

architecture rtl of alu is

    signal ext_op1  : std_logic_vector(20 downto 0); -- para representar el maximo: 998.001, -2^20= -1.048.575 ,2^20-1=1.048.575
    signal ext_op2  : std_logic_vector(20 downto 0);
    signal mult_res : std_logic_vector(21 downto 0);

begin

    multiplicador: entity work.lpm_multiplicacion port map (
	dataa		=>op1_i,
	datab		=>op1_i,
	result		=>mult_res

    );

    -- 1. Extensión de signo manual
    ext_op1 <= (20 downto 11 => op1_i(10)) & op1_i;
    ext_op2 <= (20 downto 11 => op2_i(10)) & op2_i;
    
    -- 3. Señal inicio, ns si tiene esta funcionalidad exactamente
    inicio <= '1' when (operacion = "00" or operacion = "01" or operacion = "10") else '0';

    -- 4. Sentencia concurrente para las operaciones
    res_o <= ext_op1 + ext_op2      when operacion = "00" else -- Suma
             ext_op1 - ext_op2      when operacion = "01" else -- Resta
             mult_res(20 downto 0)  when operacion = "10" else -- Multiplicación
             (others => '0');                                  -- default

end rtl;
