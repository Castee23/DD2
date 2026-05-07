library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity calculadora_tb is
end entity;

architecture sim of calculadora_tb is

    -- Constantes de tiempo
    constant T_CLK       : time := 20 ns; 
    constant T_PULSACION : time := 40 ms; 
    constant T_REPOSO    : time := 40 ms; 

    -- Senales del Top Level
    signal clk_s      : std_logic := '0';
    signal nRst_s     : std_logic := '0';
    signal columna_s  : std_logic_vector(3 downto 0);
    signal fila_s     : std_logic_vector(3 downto 0);
    signal mux_disp_s : std_logic_vector(7 downto 0);
    signal disp_s     : std_logic_vector(7 downto 0);

    signal tecla_simulada : integer := -1; 

begin

    -- 1. Instancia del Top Level
    uut: entity work.CALCULADORA
        port map(
            clk      => clk_s,
            nRst     => nRst_s,
            columna  => columna_s,
            fila     => fila_s,
            mux_disp => mux_disp_s,
            disp     => disp_s
        );

    -- 2. Generador de Reloj
    clk_s <= not clk_s after T_CLK / 2;

    -- 3. Emulador de Teclado Matricial Fisico (Corregido segun la imagen)
    process(fila_s, tecla_simulada)
    begin
        columna_s <= "1111";
        
        case tecla_simulada is
            -- Fila 0 (Arriba): 1, 2, 3, F
            when 1  => columna_s(0) <= fila_s(0);
            when 2  => columna_s(1) <= fila_s(0);
            when 3  => columna_s(2) <= fila_s(0);
            when 15 => columna_s(3) <= fila_s(0); -- F es 15
            
            -- Fila 1: 4, 5, 6, E
            when 4  => columna_s(0) <= fila_s(1);
            when 5  => columna_s(1) <= fila_s(1);
            when 6  => columna_s(2) <= fila_s(1);
            when 14 => columna_s(3) <= fila_s(1); -- E es 14 (Multiplicacion)
            
            -- Fila 2: 7, 8, 9, D
            when 7  => columna_s(0) <= fila_s(2);
            when 8  => columna_s(1) <= fila_s(2);
            when 9  => columna_s(2) <= fila_s(2);
            when 13 => columna_s(3) <= fila_s(2); -- D es 13 (Resta)
            
            -- Fila 3 (Abajo): A, 0, B, C
            when 10 => columna_s(0) <= fila_s(3); -- A es 10 (Suma)
            when 0  => columna_s(1) <= fila_s(3); -- 0 es 0
            when 11 => columna_s(2) <= fila_s(3); -- B es 11 (Igual / Resultado)
            when 12 => columna_s(3) <= fila_s(3); -- C es 12 (Cambio de signo)
            
            when others => null; 
        end case;
    end process;

    -- 4. Proceso Principal de Estimulos
    process
        procedure press_key(k : integer) is
        begin
            tecla_simulada <= k;          
            wait for T_PULSACION;         
            tecla_simulada <= -1;         
            wait for T_REPOSO;            
        end procedure;
    begin
        -- ESTADO INICIAL Y RESET
        nRst_s <= '0';
        wait for 100 ns;
        nRst_s <= '1';
        wait for 10 ms; 

        -- =========================================================================
        -- PRUEBA 1: COMPORTAMIENTO BASICO Y DESBORDE
        -- =========================================================================
        press_key(0); 
        press_key(0); 
        press_key(1);
        press_key(2);
        press_key(3);
        press_key(4); 
        
        -- Validar Operando 1 con Suma (Tecla A)
        press_key(10); 

        -- =========================================================================
        -- PRUEBA 2: OPERANDO 2 CON CAMBIO DE SIGNO
        -- =========================================================================
        press_key(4);
        press_key(5);
        press_key(12); -- Tecla C (Cambio de signo)
        
        -- Ejecutar Operacion (Tecla B)
        press_key(11); 
        
        wait for 50 ms; 

        -- =========================================================================
        -- PRUEBA 3: SALIDA DE RESULTADO Y MULTIPLICACION
        -- =========================================================================
        press_key(9); 
        press_key(9);
        press_key(9);
        
        -- Validar con Multiplicacion (Tecla E)
        press_key(14); 
        
        press_key(9);
        press_key(9);
        press_key(9);
        press_key(12); -- Tecla C
        
        -- Ejecutar (Tecla B)
        press_key(11); 
        
        wait for 50 ms;

        -- =========================================================================
        -- PRUEBA 4: SALIDA POR TECLA NO NUMERICA Y RESTA
        -- =========================================================================
        press_key(10); -- Tecla A (Resetea a 0)
        press_key(1);
        press_key(0);
        
        -- Resta (Tecla D)
        press_key(13); 
        
        press_key(2);
        press_key(0);
        
        -- Ejecutar (Tecla B)
        press_key(11); 

        wait for 50 ms;

        assert false report "=== TEST FINALIZADO ===" severity failure;
    end process;

end sim;