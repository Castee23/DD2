library ieee;
use ieee.std_logic_1164.all;

entity CALCULADORA is
    port(
        clk         : in  std_logic;
        nRst        : in  std_logic;
        columna     : in  std_logic_vector(3 downto 0);
        fila        : out std_logic_vector(3 downto 0);
        mux_disp    : out std_logic_vector(7 downto 0);
        disp        : out std_logic_vector(7 downto 0)
    );
end entity;

architecture estructural of CALCULADORA is
    
    -- Tics
    signal tic_1ms_s       : std_logic;
    signal tic_5ms_s       : std_logic;
    
    -- Teclado
    signal tecla_s         : std_logic_vector(3 downto 0);
    signal tecla_pulsada_s : std_logic;

    -- Control (FSM) y Datos Integrados
    signal pres_s          : std_logic_vector(1 downto 0);
    signal operacion_s     : std_logic_vector(1 downto 0);
    signal op1_bcd_s       : std_logic_vector(11 downto 0);
    signal op1_sgn_s       : std_logic;
    signal op2_bcd_s       : std_logic_vector(11 downto 0);
    signal op2_sgn_s       : std_logic;
    signal inicio_conv_s   : std_logic;
    signal fin_conv_s      : std_logic;

    -- Ruta de Datos: Señales en Ca2 (Binario)
    signal op1_ca2_s       : std_logic_vector(10 downto 0);
    signal op2_ca2_s       : std_logic_vector(10 downto 0);
    signal res_ca2_s       : std_logic_vector(20 downto 0); 

    -- Ruta de Datos: Resultados Finales en BCD (6 dígitos)
    signal res_bcd_s       : std_logic_vector(23 downto 0);
    signal res_sgn_s       : std_logic;

begin

    -- 1. Generador de tiempos
    i_timer: entity work.timer
        port map(
            clk       => clk,
            nRst      => nRst,
            tic_1ms   => tic_1ms_s,
            tic_5ms   => tic_5ms_s
        );

    -- 2. Controlador de Teclado
    i_ctrl_tec: entity work.ctrl_tec
        port map(
            clk           => clk,
            nRst          => nRst,
            tic           => tic_5ms_s,
            columna       => columna,
            fila          => fila,
            tecla_pulsada => tecla_pulsada_s,
            pulso_largo   => open, 
            tecla         => tecla_s
        );

    -- 3. Unidad de Control (FSM Absorbe Editor y Registros)
    i_fsm: entity work.fsm_calculadora
        port map(
            clk            => clk,
            nRst           => nRst,
            tecla          => tecla_s,
            tecla_pulsada  => tecla_pulsada_s,
            --fin            => fin_conv_s,
            pres           => pres_s,
            operacion      => operacion_s,
            op1            => op1_bcd_s,
            op1_sgn        => op1_sgn_s,
            op2            => op2_bcd_s,
            op2_sgn        => op2_sgn_s
            --inicio         => inicio_conv_s
        );

    -- 4. Conversores de Entrada (BCD a Ca2)
    i_conv_op1: entity work.conv_bcd_ca2
        port map(
            num_bcd => op1_bcd_s,
            signo   => op1_sgn_s,
            num_ca2 => op1_ca2_s
        );

    i_conv_op2: entity work.conv_bcd_ca2
        port map(
            num_bcd => op2_bcd_s,
            signo   => op2_sgn_s,
            num_ca2 => op2_ca2_s
        );

    -- 5. Unidad Aritmética (ALU)
    i_alu: entity work.alu
        port map(
            op1_i     => op1_ca2_s,
            op2_i     => op2_ca2_s,
            operacion => operacion_s,
            res_o     => res_ca2_s
        );

    -- 6. Conversor de Salida (Ca2 a BCD)
    i_conv_res: entity work.convca2_bcd
        port map(
            clk     => clk,
            nRst    => nRst,
            inicio  => inicio_conv_s,
            num_c2  => res_ca2_s,
            signo   => res_sgn_s,
            num_bcd => res_bcd_s,
            fin     => fin_conv_s
        );

    -- 7. Control de Displays
    i_displays: entity work.displays
        port map(
            clk      => clk,
            nRst     => nRst,
            tic_1ms  => tic_1ms_s,
            pres     => pres_s,
            op1      => op1_bcd_s,
            op1_sgn  => op1_sgn_s,
            op2      => op2_bcd_s,
            op2_sgn  => op2_sgn_s,
            res      => res_bcd_s,
            res_sgn  => res_sgn_s,
            mux_disp => mux_disp,
            disp     => disp
        );

end estructural;
