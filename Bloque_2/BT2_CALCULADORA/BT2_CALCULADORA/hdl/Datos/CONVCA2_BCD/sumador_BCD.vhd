library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sumador_BCD is
    Port ( 
        DatoA    : in  std_logic_vector (3 downto 0);
        DatoB    : in  std_logic_vector (3 downto 0);
        AcarreoEnt  : in  std_logic;
        Suma    : out std_logic_vector (3 downto 0);
        AcarreoSal : out std_logic
    );
end sumador_bcd;

architecture rtl of sumador_BCD is
    signal suma_temp : std_logic_vector(4 downto 0);
begin

    suma_temp <= ('0' & DatoA) + ('0' & DatoB) + ("0000" & AcarreoEnt);   --Suma Inicial de ambos Datos

    process(suma_temp)  --Ajuste BCD
    begin
        if suma_temp > "01001" then        --Comprobar que el resultado no sea mayor que 9
            Suma <= suma_temp(3 downto 0) + "0110";     --Suma 6 para ajustar el valor
            AcarreoSal <= '1';
        else
            Suma <= suma_temp(3 downto 0);
            AcarreoSal <= '0';
        end if;
    end process;

end rtl;
