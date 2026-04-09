library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ctrl_tec is
  generic(
    TICS_2s : natural := 400
  );
  port(
    clk           : in  std_logic;
    nRst          : in  std_logic;
    tic           : in  std_logic;
    columna       : in  std_logic_vector(3 downto 0);
    fila          : buffer std_logic_vector(3 downto 0);
    tecla_pulsada : buffer std_logic;
    pulso_largo   : buffer std_logic;
    tecla         : buffer std_logic_vector(3 downto 0)
  );
end entity;

architecture rtl of ctrl_tec is
  signal fila_reg  : std_logic_vector(3 downto 0);
  signal col_reg   : std_logic_vector(3 downto 0);
  signal tecla_reg : std_logic_vector(3 downto 0);
  signal tecla_temp: std_logic_vector(3 downto 0);
  signal cnt_tic   : std_logic_vector(8 downto 0);
  signal tecla_pulsada_reg : std_logic;
  signal pulso_largo_reg   : std_logic;

begin
-- ============================================================================
-- PROCESO 1
-- ============================================================================
-- Reacciona al instante sin esperar al reloj
-- Cruza la fila activa con el valor de la columna pulsada y pone en
-- tecla_temp el valor hexadecimal correspondiente

process(fila_reg, columna)
begin

  tecla_temp <= (others => '0');

  if fila_reg = "1110" then -- Si el barrido esta en la fila 0
    case columna is
      when "1110" => tecla_temp <= "0001"; -- Col 0: Tecla 1
      when "1101" => tecla_temp <= "0010"; -- Col 1: Tecla 2
      when "1011" => tecla_temp <= "0011"; -- Col 2: Tecla 3
      when "0111" => tecla_temp <= "1111"; -- Col 3: Tecla F
      when others => tecla_temp <= (others => '0');
    end case;

  elsif fila_reg = "1101" then -- Si el barrido esta en la fila 1
    case columna is
      when "1110" => tecla_temp <= "0100"; -- Col 0: Tecla 4
      when "1101" => tecla_temp <= "0101"; -- Col 1: Tecla 5
      when "1011" => tecla_temp <= "0110"; -- Col 2: Tecla 6
      when "0111" => tecla_temp <= "1110"; -- Col 3: Tecla E
      when others => tecla_temp <= (others => '0');
    end case;

  elsif fila_reg = "1011" then -- Si el barrido esta en la fila 2
    case columna is
      when "1110" => tecla_temp <= "0111"; -- Col 0: Tecla 7
      when "1101" => tecla_temp <= "1000"; -- Col 1: Tecla 8
      when "1011" => tecla_temp <= "1001"; -- Col 2: Tecla 9
      when "0111" => tecla_temp <= "1101"; -- Col 3: Tecla D
      when others => tecla_temp <= (others => '0');
    end case;
  elsif fila_reg = "0111" then --- Si el barrido esta en la fila 3
    case columna is
      when "1110" => tecla_temp <= "1010"; -- Col 0: Tecla A
      when "1101" => tecla_temp <= "0000"; -- Col 1: Tecla 0
      when "1011" => tecla_temp <= "1011"; -- Col 2: Tecla B
      when "0111" => tecla_temp <= "1100"; -- Col 3: Tecla C
      when others => tecla_temp <= (others => '0');
    end case;
  end if;
end process;

-- ============================================================================
-- PROCESO 2: Escaneo y Temporizacion
-- ============================================================================
  process(clk, nRst)
  begin
    if nRst = '0' then
      fila_reg <= "1110";
      col_reg <= "1111";
      tecla_reg <= (others => '0');
      cnt_tic <= (others => '0');
      tecla_pulsada_reg <= '0';
      pulso_largo_reg <= '0';

    elsif clk'event and clk='1' then
      tecla_pulsada_reg <= '0';

      if tic = '1' then -- Habilitador, cada 5ms

		-- Se ha pulsado una tecla: la columna detecta un '0'
        if columna /= "1111" then
          col_reg <= columna;
			
		  -- 1. Inicia el cronómetro filtra rebotes mecánicos y mide tiempos
          if cnt_tic < TICS_2s then
            cnt_tic <= cnt_tic + 1;
          end if;

          tecla_reg <= tecla_temp;

		  -- 2. Comprueba si llevamos mas de 2 segundos pulsando
          if cnt_tic >= TICS_2s then

            pulso_largo_reg <= '1';
          else
            pulso_largo_reg <= '0'; -- se mantiene apagado si no pasamos de los 2s
          end if;

          tecla_pulsada_reg <= '0';

		-- No se pulsa nada
        else

		-- Se decide si es pulsacion corta, al dejar de pulsar

          if cnt_tic > 0 and cnt_tic < TICS_2s then
			
            tecla_pulsada_reg <= '1'; -- pulso corto
          else
            tecla_pulsada_reg <= '0';
          end if;

          pulso_largo_reg <= '0';
          cnt_tic <= (others => '0');

		-- Estado de reposo: va poniendo a nivel bajo las filas para hacer el barrido 
          case fila_reg is
            when "1110" => fila_reg <= "1101";
            when "1101" => fila_reg <= "1011";
            when "1011" => fila_reg <= "0111";
            when others => fila_reg <= "1110";
          end case;
        end if;
      end if;
    end if;
  end process;

  fila <= fila_reg;
  tecla <= tecla_reg;
  tecla_pulsada <= tecla_pulsada_reg;
  pulso_largo <= pulso_largo_reg;

end rtl;
