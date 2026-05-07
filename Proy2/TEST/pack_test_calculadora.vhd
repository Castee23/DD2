library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package pack_test_calculadora is
  
  constant Tclk_50_MHz:       time := 20 ns; 

  -- Pulsacion breve de tecla
  procedure tecleo(signal   cmd_tecla: out std_logic_vector(3 downto 0); 
                   signal   clk:       in  std_logic;
                   constant tecla:     in  std_logic_vector(3 downto 0));


  -- Introducir el numero en exadecimal sin signo
  procedure introducir_numero (signal cmd_tecla: out std_logic_vector(3 downto 0);
                               signal clk: in std_logic;
                               constant valor: in std_logic_vector(11 downto 0));


  --Cambiar signo
  procedure cambiar_signo (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                           signal clk: in std_logic);


  --Suma
  procedure suma (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                  signal clk: in std_logic);


  --Resta
  procedure resta (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                   signal clk: in std_logic);


  --Multiplicacion
  procedure multiplicacion (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                            signal clk: in std_logic);


  --Resultado
  procedure resultado (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                       signal clk: in std_logic);

end package;

package body pack_test_calculadora is
  -- Procedimientos de test -----------------------------------------------------------------------------------

  -- Pulsacion breve de tecla
  procedure tecleo (signal   cmd_tecla: out std_logic_vector(3 downto 0); 
                   signal   clk:       in  std_logic;
                   constant tecla:     in  std_logic_vector(3 downto 0)) is
  begin
   wait until clk'event and clk = '1';
     cmd_tecla <= tecla;

   wait until clk'event and clk = '1';

  end procedure;


  -- Introducir el numero en exadecimal sin signo
  procedure introducir_numero (signal cmd_tecla: out std_logic_vector(3 downto 0);
                               signal clk: in std_logic;
                               constant valor: in std_logic_vector(11 downto 0)) is
  begin
    tecleo(cmd_tecla, clk, valor(11 downto 8));
    tecleo(cmd_tecla, clk, valor(7 downto 4));
    tecleo(cmd_tecla, clk, valor(3 downto 0));

  end procedure;


  --Cambiar signo
  procedure cambiar_signo (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                           signal clk: in std_logic) is
  begin
    tecleo(cmd_tecla, clk, X"C");

  end procedure;


  --Suma
  procedure suma (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                  signal clk: in std_logic) is
  begin
    tecleo(cmd_tecla, clk, X"A");

  end procedure;


  --Resta
  procedure resta (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                   signal clk: in std_logic) is
  begin
    tecleo(cmd_tecla, clk, X"D");

  end procedure;


  --Multiplicacion
  procedure multiplicacion (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                            signal clk: in std_logic) is
  begin
    tecleo(cmd_tecla, clk, X"E");

  end procedure;


  --Resultado
  procedure resultado (signal cmd_tecla: out std_logic_vector(3 downto 0); 
                       signal clk: in std_logic) is
  begin
    tecleo(cmd_tecla, clk, X"B");

  end procedure;


end package body pack_test_calculadora;