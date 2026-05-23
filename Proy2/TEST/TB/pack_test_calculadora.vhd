library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package pack_test_calculadora is
  
  constant Tclk_50_MHz:       time := 20 ns;

  -- Convertidor teclado
  procedure convertidor_teclado (constant tecla:	in  std_logic_vector(3 downto 0);
                                 signal fila:		in std_logic_vector(3 downto 0);
                                 signal columna:	out std_logic_vector(3 downto 0));

  -- Pulsacion breve de tecla
  procedure tecleo(signal   columna:	out std_logic_vector(3 downto 0);
                   signal   fila:	in std_logic_vector(3 downto 0);
                   signal   clk:	in  std_logic;
                   constant tecla:	in  std_logic_vector(3 downto 0));


  -- Introducir el numero en exadecimal sin signo
  procedure introducir_numero (signal columna:	out std_logic_vector(3 downto 0);
                               signal fila:	in std_logic_vector(3 downto 0);
                               signal clk:	in std_logic;
                               constant valor:	in std_logic_vector(11 downto 0));


  --Cambiar signo
  procedure cambiar_signo (signal columna:	out std_logic_vector(3 downto 0);
                           signal fila:		in std_logic_vector(3 downto 0);
                           signal clk:		in std_logic);


  --Suma
  procedure suma (signal columna:	out std_logic_vector(3 downto 0);
                  signal fila:		in std_logic_vector(3 downto 0);
                  signal clk:		in std_logic);


  --Resta
  procedure resta (signal columna:	out std_logic_vector(3 downto 0);
                   signal fila:		in std_logic_vector(3 downto 0);
                   signal clk:		in std_logic);


  --Multiplicacion
  procedure multiplicacion (signal columna:	out std_logic_vector(3 downto 0);
                            signal fila:	in std_logic_vector(3 downto 0); 
                            signal clk:		in std_logic);


  --Resultado
  procedure mostrar_resultado (signal columna:	out std_logic_vector(3 downto 0);
                               signal fila:	in std_logic_vector(3 downto 0);
                               signal clk:	in std_logic);

end package;

package body pack_test_calculadora is
  -- Procedimientos de test -----------------------------------------------------------------------------------

  -- Convertidor teclado
  procedure convertidor_teclado (constant tecla:	in  std_logic_vector(3 downto 0);
                                 signal fila:		in std_logic_vector(3 downto 0);
                                 signal columna:	out std_logic_vector(3 downto 0)) is
  begin
    case tecla is
      -- FILA 0 ("1110"): Teclas 1, 2, 3, F
      when x"1" => columna(0) <= fila(0); 
      when x"2" => columna(1) <= fila(0); 
      when x"3" => columna(2) <= fila(0); 
      when x"F" => columna(3) <= fila(0); 

      -- FILA 1 ("1101"): Teclas 4, 5, 6, E
      when x"4" => columna(0) <= fila(1); 
      when x"5" => columna(1) <= fila(1); 
      when x"6" => columna(2) <= fila(1); 
      when x"E" => columna(3) <= fila(1); 

      -- FILA 2 ("1011"): Teclas 7, 8, 9, D
      when x"7" => columna(0) <= fila(2); 
      when x"8" => columna(1) <= fila(2); 
      when x"9" => columna(2) <= fila(2); 
      when x"D" => columna(3) <= fila(2); 

      -- FILA 3 ("0111"): Teclas A, 0, B, C
      when x"A" => columna(0) <= fila(3); 
      when x"0" => columna(1) <= fila(3); 
      when x"B" => columna(2) <= fila(3); 
      when x"C" => columna(3) <= fila(3); 

      when others => columna <= "1111";
    end case;

  end procedure;


  -- Pulsacion breve de tecla
  procedure tecleo (signal   columna:	out std_logic_vector(3 downto 0);
                    signal   fila:	in std_logic_vector(3 downto 0);
                    signal   clk:       in  std_logic;
                    constant tecla:     in  std_logic_vector(3 downto 0)) is
  begin
    for i in 1 to 750000 loop
      wait until clk'event and clk = '1';
      convertidor_teclado (tecla, fila, columna);
    end loop;

    columna <= "1111";

    for i in 1 to 750000 loop
      wait until clk'event and clk = '1';
    end loop;

  end procedure;


  -- Introducir el numero en exadecimal sin signo
  procedure introducir_numero (signal columna:	out std_logic_vector(3 downto 0);
                               signal fila:	in std_logic_vector(3 downto 0);
                               signal clk:	in std_logic;
                               constant valor:	in std_logic_vector(11 downto 0)) is
  begin
    tecleo(columna, fila, clk, valor(11 downto 8));
    tecleo(columna, fila, clk, valor(7 downto 4));
    tecleo(columna, fila, clk, valor(3 downto 0));

  end procedure;


  --Cambiar signo
  procedure cambiar_signo (signal columna:	out std_logic_vector(3 downto 0);
                           signal fila:		in std_logic_vector(3 downto 0);
                           signal clk:		in std_logic) is
  begin
    tecleo(columna, fila, clk, X"C");

  end procedure;


  --Suma
  procedure suma (signal columna:	out std_logic_vector(3 downto 0);
                  signal fila:		in std_logic_vector(3 downto 0);
                  signal clk:		in std_logic) is
  begin
    tecleo(columna, fila, clk, X"A");

  end procedure;


  --Resta
  procedure resta (signal columna:	out std_logic_vector(3 downto 0);
                   signal fila:		in std_logic_vector(3 downto 0);
                   signal clk:		in std_logic) is
  begin
    tecleo(columna, fila, clk, X"D");

  end procedure;


  --Multiplicacion
  procedure multiplicacion (signal columna:	out std_logic_vector(3 downto 0);
                            signal fila:	in std_logic_vector(3 downto 0);
                            signal clk:		in std_logic) is
  begin
    tecleo(columna, fila, clk, X"E");

  end procedure;


  --Resultado
  procedure mostrar_resultado (signal columna:	out std_logic_vector(3 downto 0);
                               signal fila:	in std_logic_vector(3 downto 0);
                               signal clk:	in std_logic) is
  begin
    tecleo(columna, fila, clk, X"B");

  end procedure;


end package body pack_test_calculadora;