library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sumadorBCD_6dig is
    port(
        DatoA    : in     std_logic_vector(23 downto 0); -- N�mero A (6 d�gitos BCD)
        DatoB    : in     std_logic_vector(23 downto 0); -- N�mero B (6 d�gitos BCD)
        AcarreoEnt  : in     std_logic;                    
        Suma : buffer std_logic_vector(23 downto 0); -- Resultado BCD (6 d�gitos)
        AcarreoSal : buffer std_logic                     
    );
end sumadorBCD_6dig;

architecture rtl of sumadorBCD_6dig is
    signal c : std_logic_vector(4 downto 0); -- Acarreos

begin

    -- Unidades
    Unidades: entity work.sumador_bcd port map (
        DatoA    => DatoA(3 downto 0),
        DatoB    => DatoB(3 downto 0),
        AcarreoEnt  => AcarreoEnt,       -- El acarreo inicial de la entidad global
        Suma => Suma(3 downto 0),
        AcarreoSal => c(0)       -- Sale hacia el siguiente bloque
    );

    -- BLOQUE 1: Decenas
    Decenas: entity work.sumador_bcd port map (
        DatoA    => DatoA(7 downto 4),
        DatoB    => DatoB(7 downto 4),
        AcarreoEnt  => c(0),      -- Recibe el acarreo del bloque 0
        Suma => Suma(7 downto 4),
        AcarreoSal => c(1)
    );

    -- BLOQUE 2: Centenas
    Centenas: entity work.sumador_bcd port map (
        DatoA    => DatoA(11 downto 8),
        DatoB    => DatoB(11 downto 8),
        AcarreoEnt  => c(1),
        Suma => Suma(11 downto 8),
        AcarreoSal => c(2)
    );

    -- BLOQUE 3: Unidades de millar
    UnidadesDeMillar: entity work.sumador_bcd port map (
        DatoA    => DatoA(15 downto 12),
        DatoB    => DatoB(15 downto 12),
        AcarreoEnt  => c(2),
        Suma => Suma(15 downto 12),
        AcarreoSal => c(3)
    );

    -- BLOQUE 4: Decenas de millar
    DecenasDeMillar: entity work.sumador_bcd port map (
        DatoA    => DatoA(19 downto 16),
        DatoB    => DatoB(19 downto 16),
        AcarreoEnt  => c(3),
        Suma => Suma(19 downto 16),
        AcarreoSal => c(4)
    );

    -- BLOQUE 5: Centenas de millar
    CentenasDeMillar: entity work.sumador_bcd port map (
        DatoA    => DatoA(23 downto 20),
        DatoB    => DatoB(23 downto 20),
        AcarreoEnt  => c(4),
        Suma => Suma(23 downto 20),
        AcarreoSal => AcarreoSal       -- El �ltimo acarreo sale a la salida global
    );

end rtl;
