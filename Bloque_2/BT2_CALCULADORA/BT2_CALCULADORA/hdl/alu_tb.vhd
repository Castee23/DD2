library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity alu_tb is
-- Entidad vacía para testbench
end entity;

architecture sim of alu_tb is

    -- Señales de conexión
    signal op1_i     : std_logic_vector(10 downto 0) := (others => '0');
    signal op1_sgn   : std_logic := '0';
    signal op2_i     : std_logic_vector(10 downto 0) := (others => '0');
    signal op2_sgn   : std_logic := '0';
    signal operacion : std_logic_vector(1 downto 0) := "11"; -- Empezamos en reposo
    signal res_o     : std_logic_vector(20 downto 0);
    signal inicio    : std_logic;

begin

    -- Instancia de la ALU
    uut: entity work.alu
        port map (
            op1_i     => op1_i,
           -- op1_sgn   => op1_sgn,
            op2_i     => op2_i,
            --op2_sgn   => op2_sgn,
            operacion => operacion,
            res_o     => res_o,
            inicio    => inicio
        );

    process
    begin
        -- ==========================================================
        -- CASO 1: SUMA LÍMITE POSITIVA (999 + 999 = 1998)
        -- ==========================================================
        op1_i <= conv_std_logic_vector(999, 11);
        op2_i <= conv_std_logic_vector(999, 11);
        operacion <= "00";
        wait for 20 ns;

        -- ==========================================================
        -- CASO 2: SUMA LÍMITE NEGATIVA (-999 + -999 = -1998)
        -- Comprueba que la extensión de signo manual funciona en sumas
        -- ==========================================================
        op1_i <= conv_std_logic_vector(-999, 11);
        op2_i <= conv_std_logic_vector(-999, 11);
        operacion <= "00";
        wait for 20 ns;

        -- ==========================================================
        -- CASO 3: RESTA QUE CAMBIA DE SIGNO (10 - 20 = -10)
        -- ==========================================================
        op1_i <= conv_std_logic_vector(10, 11);
        op2_i <= conv_std_logic_vector(20, 11);
        operacion <= "01";
        wait for 20 ns;

        -- ==========================================================
        -- CASO 4: MULTIPLICACIÓN MÁXIMA POSITIVA (999 * 999 = 998001)
        -- CRÍTICO: Aquí verificarás que res_o es POSITIVO gracias a los 21 bits
        -- ==========================================================
        op1_i <= conv_std_logic_vector(999, 11);
        op2_i <= conv_std_logic_vector(999, 11);
        operacion <= "10";
        wait for 20 ns;

        -- ==========================================================
        -- CASO 5: MULTIPLICACIÓN MÁXIMA NEGATIVA (999 * -999 = -998001)
        -- ==========================================================
        op1_i <= conv_std_logic_vector(999, 11);
        op2_i <= conv_std_logic_vector(-999, 11);
        operacion <= "10";
        wait for 20 ns;

        -- ==========================================================
        -- CASO 6: MULTIPLICACIÓN DE NEGATIVOS (-999 * -999 = 998001)
        -- ==========================================================
        op1_i <= conv_std_logic_vector(-999, 11);
        op2_i <= conv_std_logic_vector(-999, 11);
        operacion <= "10";
        wait for 20 ns;

        -- ==========================================================
        -- CASO 7: VALORES CERO (Cualquier num * 0 = 0)
        -- ==========================================================
        op1_i <= conv_std_logic_vector(555, 11);
        op2_i <= conv_std_logic_vector(0, 11);
        operacion <= "10";
        wait for 20 ns;

        -- ==========================================================
        -- CASO 8: REPOSO / OPERACIÓN NO VÁLIDA
        -- Comprueba que 'inicio' se pone a 0 y 'res_o' a 0
        -- ==========================================================
        operacion <= "11";
        wait for 20 ns;

        wait; 
    end process;

end sim;