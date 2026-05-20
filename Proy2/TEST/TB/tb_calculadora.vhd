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
  
  -- Salidas
  signal resultado	: std_logic_vector(15 downto 0);

  --Cte
  constant T_CLK : time := 20 ns; -- Reloj de 50 MHz (ESP15)

begin

  -- Instanciación del DUT (CALCULADORA)
  dut: entity work.calculadora(estructural)
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
    procedure introducir_numero (columna, fila, clk, x"003");

    -- ==========================================================
    -- 2. SELECCIÓN DE OPERACIÓN: SUMA
    -- ==========================================================
    procedure suma (columna, fila, clk)

    -- ==========================================================
    -- 3. INTRODUCCIÓN OPERANDO 2: "040"
    -- ==========================================================
    procedure introducir_numero (columna, fila, clk, x"040");

    -- ==========================================================
    -- 4. CAMBIAR SIGNO
    -- ==========================================================
    procedure cambiar_signo(columna, fila, clk);

    -- ==========================================================
    -- 5. VALIDACIÓN Y RESULTADO
    -- ==========================================================
    procedure resultado(columna, fila, clk);



    -- ==========================================================
    -- OPERACION 2: 999 * 999
    -- ==========================================================

    -- ==========================================================
    -- 1. INTRODUCCIÓN OPERANDO 1: "999"
    -- ==========================================================
    procedure introducir_numero (columna, fila, clk, x"999");
    procedure introducir_numero (columna, fila, clk, x"000");

    -- ==========================================================
    -- 2. SELECCIÓN DE OPERACIÓN: MULTIPLICACION
    -- ==========================================================
    procedure multiplicacion (columna, fila, clk)

    -- ==========================================================
    -- 3. INTRODUCCIÓN OPERANDO 2: "999"
    -- ==========================================================
    procedure introducir_numero (columna, fila, clk, x"999");
    procedure introducir_numero (columna, fila, clk, x"000");

    -- ==========================================================
    -- 4. VALIDACIÓN Y RESULTADO
    -- ==========================================================
    procedure resultado(columna, fila, clk);



    wait until clk'event and clk = '1';
    assert false report "Test manual finalizado" severity failure;
  end process;

end test;