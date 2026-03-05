library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use work.pack_test_reloj.all;

entity test_estimulos_reloj is
port(clk:     	  in std_logic;
     nRst:        in std_logic;
     tic_025s:    out std_logic;
     tic_1s:      out std_logic;
     ena_cmd:     out std_logic;
     cmd_tecla:   out std_logic_vector(3 downto 0);
     pulso_largo: out std_logic;
     modo:        in std_logic;
     segundos:    in std_logic_vector(7 downto 0);
     minutos:     in std_logic_vector(7 downto 0);
     horas:       in std_logic_vector(7 downto 0);
     AM_PM:       in std_logic;
     info:        in std_logic_vector(1 downto 0)
    );
end entity;

architecture test of test_estimulos_reloj is

begin
  -- Tic para el incremento continuo de campo. Escalado. 
  process
  begin
    tic_025s <= '0';
    for i in 1 to 3 loop
       wait until clk'event and clk = '1';
    end loop;

    tic_025s <= '1';
    wait until clk'event and clk = '1';

  end process;
  -- Tic de 1 seg. Escalado.
  process
  begin
    tic_1s <= '0';
    for i in 1 to 15 loop
       wait until clk'event and clk = '1';
    end loop;

    tic_1s <= '1';
    wait until clk'event and clk = '1';

  end process;


  process
  begin
    ena_cmd  <= '0';
    cmd_tecla <= (others => '0');
    pulso_largo <= '0';

    -- Esperamos el final del Reset
    wait until nRst'event and nRst = '1';

    for i in 1 to 9 loop
       wait until clk'event and clk = '1';
    end loop;

	-- PRUEBA 1: Probar que no se sobrepasa ningun valor fuera de los esperados en: h, min y seg en los modos 12h y 24h --

	-- 1. Comprobacion de salto de AM a PM (Modo 12h)
	esperar_hora(horas, minutos, AM_PM, clk, '0', X"11"&X"59");

	-- 1 min y algo 
 	wait for 61*16*Tclk_50_MHz;
	wait until clk'event and clk = '1';

	-- 2. Comprobacion de salto de PM a AM (Modo 12h)
	esperar_hora(horas, minutos, AM_PM, clk, '1', X"11"&X"59");
	-- 1 min y algo 
 	wait for 61*16*Tclk_50_MHz;
	wait until clk'event and clk = '1';
    
	-- 3. Cambiamos modo 24h
    cambiar_modo_12_24(ena_cmd, cmd_tecla, clk);
    esperar_hora(horas, minutos, AM_PM, clk, '1', X"23"&X"59");

    -- Esperar 1 min y algo 
 	wait for 600*16*Tclk_50_MHz;
	wait until clk'event and clk = '1';

	-- PRUEBA 2: Puerta de Entrada y Vigilante de Inactividad (Timeout) --
    
    -- 1. Acceder a la programacion de horas (Pulsacion larga de tecla A)
    entrar_modo_prog(pulso_largo, cmd_tecla, clk);
    wait until clk'event and clk = '1';
    -- 2. Esperar 8 tics escalados sin inyectar estimulos
    -- Esto forzara el modo normal
    time_out(clk);
 	wait until clk'event and clk = '1';

	
	-- PRUEBA 3: Edición de Horas e Inyección de Errores (Límites BCD) --

	-- Se supone que estamos en modo 12h
	esperar_hora(horas, minutos, AM_PM, clk, '0', X"02"&X"30"); 

    -- 1. Acceder de nuevo a la programacion de horas 
    entrar_modo_prog(pulso_largo, cmd_tecla, clk, 15);
--
    -- 2. Incremento corto manual: Probamos una sola pulsacion de la tecla C, se debe verificar q se suma una hora a la anterior
    tecleo(ena_cmd, cmd_tecla, clk, X"C");
	-- 2.1. Comprobamos q se incrementes en uno los minutos
    tecleo(ena_cmd, cmd_tecla, clk, X"B");
	tecleo(ena_cmd, cmd_tecla, clk, X"C");

    -- 3. Incremento rapido (barrido 4Hz): Mantenemos pulsada la tecla C.
    programar_hora_inc_largo(pulso_largo, ena_cmd, cmd_tecla, horas, minutos, AM_PM, clk, '0', X"07"&X"50");
    wait until clk'event and clk = '1';

	-- PRUEBA 4

	-- Introduccir una hora y minitos por teclado, empezando en modo programacion (empezamos en modo 12h)
	entrar_modo_prog(pulso_largo, cmd_tecla, clk);

	-- Introduccimos 11
	  tecleo(ena_cmd, cmd_tecla, clk, X"1");
      tecleo(ena_cmd, cmd_tecla, clk, X"1");
	  wait until clk'event and clk = '1';

	  -- Ahora una hora invalida

	  tecleo(ena_cmd, cmd_tecla, clk, X"2");
      tecleo(ena_cmd, cmd_tecla, clk, X"3");
	  wait until clk'event and clk = '1';

    -- Pasamos a cambiar minutos
	  tecleo(ena_cmd, cmd_tecla, clk, X"B");

	  tecleo(ena_cmd, cmd_tecla, clk, X"3");
      tecleo(ena_cmd, cmd_tecla, clk, X"0");
	  wait until clk'event and clk = '1';

	  -- Ahora minutos invalidos

	  tecleo(ena_cmd, cmd_tecla, clk, X"7");
      tecleo(ena_cmd, cmd_tecla, clk, X"9");
	  wait until clk'event and clk = '1';

  	  
	  fin_prog(ena_cmd, cmd_tecla, clk);

	  -- Pasamos a moddo 24h

	  entrar_modo_prog(pulso_largo, cmd_tecla, clk);
	  cambiar_modo_12_24(ena_cmd, cmd_tecla, clk);
	  -- Introduccimos 11
	  tecleo(ena_cmd, cmd_tecla, clk, X"1");
      tecleo(ena_cmd, cmd_tecla, clk, X"7");
	  wait until clk'event and clk = '1';

	  -- Ahora una hora invalida

	  tecleo(ena_cmd, cmd_tecla, clk, X"3");
      tecleo(ena_cmd, cmd_tecla, clk, X"3");
	  wait until clk'event and clk = '1';

    -- Pasamos a cambiar minutos
	  tecleo(ena_cmd, cmd_tecla, clk, X"B");

	  tecleo(ena_cmd, cmd_tecla, clk, X"2");
      tecleo(ena_cmd, cmd_tecla, clk, X"5");
	  wait until clk'event and clk = '1';

	  -- Ahora minutos invalidos

	  tecleo(ena_cmd, cmd_tecla, clk, X"8");
      tecleo(ena_cmd, cmd_tecla, clk, X"5");
	  wait until clk'event and clk = '1';

	-- Prueba 5: se compueban los cambios de 12h/24h tanto en modo normal como en modo programacion
	-- Vemos como en modo 12h se pasa a 24h, para ello tenemos q estar en PM

	esperar_hora(horas, minutos, AM_PM, clk, '1', X"09"&X"30");
	tecleo(ena_cmd, cmd_tecla, clk, X"D");

	-- Vemos como en modo 24h se pasa a 12h
	esperar_hora(horas, minutos, AM_PM, clk, '1', X"21"&X"30");
	tecleo(ena_cmd, cmd_tecla, clk, X"D");

	-- Ahora se comprueba pero desde el modo programacion 
    -- Conversion de 12 a 24 horas en modo de programación

	cambiar_modo_12_24(ena_cmd, cmd_tecla, clk);
	entrar_modo_prog(pulso_largo, cmd_tecla, clk, 15);

	tecleo(ena_cmd, cmd_tecla, clk, X"2");
	tecleo(ena_cmd, cmd_tecla, clk, X"3");
	tecleo(ena_cmd, cmd_tecla, clk, X"B");
	tecleo(ena_cmd, cmd_tecla, clk, X"5");
	tecleo(ena_cmd, cmd_tecla, clk, X"0");

	tecleo(ena_cmd, cmd_tecla, clk, X"D");

	for i in 1 to 4 loop

        wait until clk'event and clk = '1';

    end loop;
	fin_prog(ena_cmd,cmd_tecla,clk);


    assert false
    report "done"
    severity failure;
  end process;

end test;
