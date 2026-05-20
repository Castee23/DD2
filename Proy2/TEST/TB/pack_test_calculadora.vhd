library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package pack_test_calculadora is
  
  constant Tclk_50_MHz:       time := 20 ns;

  -- Convertidor teclado
  procedure convertidor_teclado (constant tecla:	in  std_logic_vector(3 downto 0);
                                 signal columna:	out std_logic_vector(3 downto 0);
                                 signal fila:		out std_logic_vector(3 downto 0));

  -- Pulsacion breve de tecla
  procedure tecleo(signal   columna:	out std_logic_vector(3 downto 0);
                   signal   fila:	out std_logic_vector(3 downto 0);
                   signal   clk:	in  std_logic;
                   constant tecla:	in  std_logic_vector(3 downto 0));


  -- Introducir el numero en exadecimal sin signo
  procedure introducir_numero (signal columna:	out std_logic_vector(3 downto 0);
                               signal fila:	out std_logic_vector(3 downto 0);
                               signal clk:	in std_logic;
                               constant valor:	in std_logic_vector(11 downto 0));


  --Cambiar signo
  procedure cambiar_signo (signal columna:	out std_logic_vector(3 downto 0);
                           signal fila:		out std_logic_vector(3 downto 0);
                           signal clk:		in std_logic);


  --Suma
  procedure suma (signal columna:	out std_logic_vector(3 downto 0);
                  signal fila:		out std_logic_vector(3 downto 0);
                  signal clk:		in std_logic);


  --Resta
  procedure resta (signal columna:	out std_logic_vector(3 downto 0);
                   signal fila:		out std_logic_vector(3 downto 0);
                   signal clk:		in std_logic);


  --Multiplicacion
  procedure multiplicacion (signal columna:	out std_logic_vector(3 downto 0);
                            signal fila:	out std_logic_vector(3 downto 0); 
                            signal clk:		in std_logic);


  --Resultado
  procedure resultado (signal columna:	out std_logic_vector(3 downto 0);
                       signal fila:	out std_logic_vector(3 downto 0);
                       signal clk:	in std_logic);

end package;

package body pack_test_calculadora is
  -- Procedimientos de test -----------------------------------------------------------------------------------

  -- Convertidor teclado
  procedure convertidor_teclado (constant tecla:	in  std_logic_vector(3 downto 0);
                                 signal columna:	out std_logic_vector(3 downto 0);
                                 signal fila:		out std_logic_vector(3 downto 0)) is
  begin
    if tecla = x"1" or tecla = x"4" or tecla = x"7" or tecla = x"A" then
      columna <= "1110";

    elsif tecla = x"2" or tecla = x"5" or tecla = x"8" or tecla = x"0" then
      columna <= "1101";

    elsif tecla = x"3" or tecla = x"6" or tecla = x"9" or tecla = x"B" then
      columna <= "1011";

    elsif tecla = x"F" or tecla = x"E" or tecla = x"D" or tecla = x"C" then
      columna <= "0111";

    else
      columna <= "0000";
    end if;


    if tecla = x"1" or tecla = x"2" or tecla = x"3" or tecla = x"F" then
      fila <= "1110";

    elsif tecla = x"4" or tecla = x"5" or tecla = x"6" or tecla = x"E" then
      fila <= "1101";

    elsif tecla = x"7" or tecla = x"8" or tecla = x"9" or tecla = x"D" then
      fila <= "1011";

    elsif tecla = x"A" or tecla = x"0" or tecla = x"B" or tecla = x"C" then
      fila <= "0111";

    else
      fila <= "0000";
    end if;

  end procedure;


  -- Pulsacion breve de tecla
  procedure tecleo (signal   columna:	out std_logic_vector(3 downto 0);
                    signal   fila:	out std_logic_vector(3 downto 0);
                    signal   clk:       in  std_logic;
                    constant tecla:     in  std_logic_vector(3 downto 0)) is
  begin
   wait until clk'event and clk = '1';
     convertidor_teclado (tecla, columna, fila);

   wait until clk'event and clk = '1';

  end procedure;


  -- Introducir el numero en exadecimal sin signo
  procedure introducir_numero (signal columna:	out std_logic_vector(3 downto 0);
                               signal fila:	out std_logic_vector(3 downto 0);
                               signal clk:	in std_logic;
                               constant valor:	in std_logic_vector(11 downto 0)) is
  begin
    tecleo(columna, fila, clk, valor(11 downto 8));
    tecleo(columna, fila, clk, valor(7 downto 4));
    tecleo(columna, fila, clk, valor(3 downto 0));

  end procedure;


  --Cambiar signo
  procedure cambiar_signo (signal columna:	out std_logic_vector(3 downto 0);
                           signal fila:		out std_logic_vector(3 downto 0);
                           signal clk:		in std_logic) is
  begin
    tecleo(columna, fila, clk, X"C");

  end procedure;


  --Suma
  procedure suma (signal columna:	out std_logic_vector(3 downto 0);
                  signal fila:		out std_logic_vector(3 downto 0);
                  signal clk:		in std_logic) is
  begin
    tecleo(columna, fila, clk, X"A");

  end procedure;


  --Resta
  procedure resta (signal columna:	out std_logic_vector(3 downto 0);
                   signal fila:		out std_logic_vector(3 downto 0);
                   signal clk:		in std_logic) is
  begin
    tecleo(columna, fila, clk, X"D");

  end procedure;


  --Multiplicacion
  procedure multiplicacion (signal columna:	out std_logic_vector(3 downto 0);
                            signal fila:	out std_logic_vector(3 downto 0);
                            signal clk:		in std_logic) is
  begin
    tecleo(columna, fila, clk, X"E");

  end procedure;


  --Resultado
  procedure resultado (signal columna:	out std_logic_vector(3 downto 0);
                       signal fila:	out std_logic_vector(3 downto 0);
                       signal clk:	in std_logic) is
  begin
    tecleo(columna, fila, clk, X"B");

  end procedure;


end package body pack_test_calculadora;