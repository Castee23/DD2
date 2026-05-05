library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm_calculadora is
end entity;

architecture test of tb_fsm_calculadora is 
  -- Señales de la FSM
  signal clk           : std_logic := '0';
  signal nRst          : std_logic;
  signal tecla_pulsada : std_logic := '0';
  signal tecla         : std_logic_vector(3 downto 0) := (others => '0');
  
  -- Salidas de la FSM
  signal op1           : std_logic_vector(11 downto 0);
  signal op1_sgn       : std_logic;
  signal op2           : std_logic_vector(11 downto 0);
  signal op2_sgn       : std_logic;
  signal operacion     : std_logic_vector(1 downto 0);
  signal pres          : std_logic_vector(1 downto 0);

  constant T_CLK : time := 20 ns; -- Reloj de 50 MHz (ESP15)

begin

  -- Instanciación del DUT (FSM)
  dut: entity work.fsm_calculadora(rtl)
     port map(
        clk => clk, 
        nRst => nRst,
        tecla_pulsada => tecla_pulsada, 
        tecla => tecla,
        op1 => op1, 
        op1_sgn => op1_sgn,
        op2 => op2, 
        op2_sgn => op2_sgn,
        operacion => operacion, 
        pres => pres
     );

  -- Generador de Reloj
  process
  begin
    clk <= '0'; 
    wait for T_CLK/2;
    clk <= '1'; 
    wait for T_CLK/2;
  end process;

  -- Proceso de Estímulos manual (Sin procedimientos)
  process
  begin
    -- ==========================================================
    -- 1. RESET INICIAL (ESP07)
    -- ==========================================================
    nRst <= '0';
    wait for 40 ns;
    nRst <= '1';
    wait until rising_edge(clk);
    -- En este punto: pres="00" (Op1), op1=0, op2=0

    -- ==========================================================
    -- 2. INTRODUCCIÓN OPERANDO 1: "123" (ESP01, ESP10)
    -- ==========================================================
    -- Pulsar tecla '1'
    tecla <= X"1";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;

    -- Pulsar tecla '2'
    tecla <= X"2";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;

    -- Pulsar tecla '3'
    tecla <= X"3";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;

    -- Cambiar signo a negativo (Tecla 'C') [ESP11]
    tecla <= X"C";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;

    -- ==========================================================
    -- 3. SELECCIÓN DE OPERACIÓN: SUMA (Tecla 'A') [ESP08]
    -- ==========================================================
    tecla <= X"A";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;
    -- Aquí pres debe cambiar a "01" (Op2) [ESP09]

    -- ==========================================================
    -- 4. INTRODUCCIÓN OPERANDO 2: "45"
    -- ==========================================================
    -- Pulsar tecla '4'
    tecla <= X"4";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;

    -- Pulsar tecla '5'
    tecla <= X"5";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;

    -- ==========================================================
    -- 5. VALIDACIÓN Y RESULTADO (Tecla 'B') [ESP12]
    -- ==========================================================
    tecla <= X"B";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 5; -- Esperamos un poco para observar el resultado
    -- Aquí pres debe ser "10" (Resultado) [ESP05]

    -- ==========================================================
    -- 6. SALIDA CON TECLA NUMÉRICA (ESP13)
    -- ==========================================================
    -- Pulsar '9' para empezar nueva operación
    tecla <= X"9";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;
    -- Aquí op1 debe valer "009", op2=0, sgn=0 y pres="00"

    -- ==========================================================
    -- 7. SALIDA CON CUALQUIER OTRA TECLA (ESP13)
    -- ==========================================================
    -- Pasamos rápido a modo resultado de nuevo
    tecla <= X"A"; tecla_pulsada <= '1'; wait for T_CLK; tecla_pulsada <= '0'; wait for T_CLK;
    tecla <= X"B"; tecla_pulsada <= '1'; wait for T_CLK; tecla_pulsada <= '0'; wait for T_CLK;
    
    -- Estando en resultado, pulsamos tecla de función 'F'
    tecla <= X"F";
    tecla_pulsada <= '1';
    wait for T_CLK;
    tecla_pulsada <= '0';
    wait for T_CLK * 2;
    -- Aquí op1 debe valer "000" (Calculadora reseteada)

    wait for 200 ns;
    assert false report "Test manual finalizado" severity failure;
  end process;

end test;
