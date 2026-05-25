--Test calculadora

library ieee;
use ieee.std_logic_1164.all;
use work.pack_test_calculadora.all;

entity tb_calculadora is
end entity;

architecture test of tb_calculadora is 
  -- Señales
  signal clk		: std_logic;
  signal nRst		: std_logic;
  signal columna	: std_logic_vector(3 downto 0);
  signal fila		: std_logic_vector(3 downto 0);
  signal mux_disp	: std_logic_vector(7 downto 0);
  signal disp		: std_logic_vector(7 downto 0);

  --Cte
  constant T_CLK : time := 20 ns; -- Reloj de 50 MHz (ESP15)

begin

  -- Instanciación del DUT (CALCULADORA)
  dut: entity work.calculadora(structural)
     port map(clk => clk,
              nRst => nRst,
              columna => columna,
              fila => fila,
              mux_disp => mux_disp,
              disp => disp);

  -- Generador de Reloj
  process
  begin
    clk <= '0'; 
    wait for T_CLK/2;
    clk <= '1'; 
    wait for T_CLK/2;
  end process;


  -- Tecleo
  process
  begin
    -- ==========================================================
    -- RESET INICIAL
    -- ==========================================================
    columna <= "1111";
    nRst <= '0';
    wait until clk'event and clk = '1';
    nRst <= '1';
    wait until clk'event and clk = '1';

    -- ==========================================================
    -- OPERACION 1: 3 + (-40)
    -- ==========================================================

    -- ==========================================================
    -- 1. INTRODUCCIÓN OPERANDO 1: "003"
    -- ==========================================================
    introducir_numero (columna, fila, clk, x"003");

    -- ==========================================================
    -- 2. SELECCIÓN DE OPERACIÓN: SUMA
    -- ==========================================================
    suma (columna, fila, clk);

    -- ==========================================================
    -- 3. INTRODUCCIÓN OPERANDO 2: "040"
    -- ==========================================================
    introducir_numero (columna, fila, clk, x"040");

    -- ==========================================================
    -- 4. CAMBIAR SIGNO
    -- ==========================================================
    cambiar_signo (columna, fila, clk);

    -- ==========================================================
    -- 5. VALIDACIÓN Y RESULTADO
    -- ==========================================================
    mostrar_resultado (columna, fila, clk);



    -- ==========================================================
    -- OPERACION 2: 999 * 999
    -- ==========================================================

    -- ==========================================================
    -- 1. INTRODUCCIÓN OPERANDO 1: "999"
    -- ==========================================================
    introducir_numero (columna, fila, clk, x"999");
    introducir_numero (columna, fila, clk, x"000");

    -- ==========================================================
    -- 2. SELECCIÓN DE OPERACIÓN: MULTIPLICACION
    -- ==========================================================
    multiplicacion (columna, fila, clk);

    -- ==========================================================
    -- 3. INTRODUCCIÓN OPERANDO 2: "999"
    -- ==========================================================
    introducir_numero (columna, fila, clk, x"999");

    -- ==========================================================
    -- 4. VALIDACIÓN Y RESULTADO
    -- ==========================================================
    mostrar_resultado (columna, fila, clk);

    for i in 1 to 100 loop
      wait until clk'event and clk = '1';
    end loop;

    assert false report "Test manual finalizado" severity failure;
  end process;

end test;