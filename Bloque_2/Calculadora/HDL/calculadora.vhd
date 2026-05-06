library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity calculadora is
    port (
        clk    	     	: in  std_logic;
        nRst   		: in  std_logic;
        columna 	: in  std_logic_vector(3 downto 0);
        fila       	: out std_logic_vector(3 downto 0);
        disp		: out std_logic_vector(7 downto 0); 
        mux_disp      	: out std_logic_vector(7 downto 0)  
    );
end calculadora;

architecture struct of calculadora is

    signal tic_1ms        : std_logic;
    signal tecla_pulsada  : std_logic;
    signal tecla          : std_logic_vector(3 downto 0);
    signal op1_fsm        : std_logic_vector(11 downto 0);
    signal op2_fsm        : std_logic_vector(11 downto 0);
    signal op1_sgn_fsm    : std_logic;
    signal op2_sgn_fsm    : std_logic;
    signal operacion      : std_logic_vector(1 downto 0);
    signal pres           : std_logic_vector(1 downto 0);
    signal op1_ca2        : std_logic_vector(10 downto 0);
    signal op2_ca2        : std_logic_vector(10 downto 0);

    --Falta la parte de la ALU

    signal signo_res      : std_logic;
    signal num_bcd_res    : std_logic_vector(23 downto 0);

begin

    U_Timer: entity work.timer
    port map (
        clk       => clk,
        nRst      => nRst,
        tic_1ms   => tic_1ms,
    );

    U_Ctrl_Tec : entity work.ctrl_tec
    port map (
        clk           => clk,
        nRst          => nRst,
        tic           => tic_1ms,
        columna       => columna,
        fila          => fila,
        tecla         => tecla,
        tecla_pulsada => tecla_pulsada,
    );

    U_FSM : entity work.fsm_calculadora
    port map (
        clk           => clk,
        nRst          => nRst,
        tecla_pulsada => tecla_pulsada,
        tecla         => tecla,
        op1           => op1_fsm,
        op1_sgn       => op1_sgn_fsm,
        op2           => op2_fsm,
        op2_sgn       => op2_sgn_fsm,
        operacion     => operacion,
        pres          => pres
    );

    U_Conv_BCD_C2_Op1 : entity work.conv_bcd_ca2
    port map (
        num_bcd => op1_fsm,
        signo   => op1_sgn_fsm,
        num_ca2 => op1_ca2
    );

    U_Conv_BCD_C2_Op2 : entity work.conv_bcd_ca2
    port map (
        num_bcd => op2_fsm,
        signo   => op2_sgn_fsm,
        num_ca2 => op2_ca2
    );

    U_ALU : entity work.alu
    port map (
        clk       => clk,
        nRst      => nRst,
        op1       => op1_ca2,
        op2       => op2_ca2,
        operacion => operacion,
        resultado => res_alu,
        inicio    => inicio_alu
    );

    U_Conv_C2_BCD : entity work.convca2_bcd
    port map (
        clk     => clk,
        nRst    => nRst,
        inicio  => inicio_alu,
        num_c2  => res_alu,
        signo   => signo_res,
        num_bcd => num_bcd_res,
        fin     => -- A donde chcuchas meto esto?
    );

    U_displays : entity work.displays
    port map (
        clk       => clk,
        nRst      => nRst,
        tic_1ms   => tic_1ms,
        pres      => pres,
        op1       => op1_fsm,
        op1_sgn   => op1_sgn_fsm,
        op2       => op2_fsm,
        op2_sgn   => op2_sgn_fsm,
        res       => num_bcd_res,
        res_sgn   => signo_res,
        mux_disp  => mux_disp,
        disp      => disp
    );

end struct;