library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity CONTA_DESC is
	port (CLK, RST, EN, SET: in std_logic;
			IN_SET: in std_logic_vector(9 downto 0);
			CONTA: out std_logic_vector(9 downto 0)
			);
end CONTA_DESC;

architecture bhv of CONTA_DESC is
	signal contador: std_logic_vector(9 downto 0); -- contador interno que depois e passado para a saida CONTA
	
	begin
		P1: process(CLK, RST, contador)
			begin
				if RST = '0' then				  -- se botao de reset e pressionado
					contador <= "0000000000"; -- reseta a contagem
					
				elsif CLK'event and CLK = '1' then -- na transicao positiva do clock (aqui o clock e CLK1 de 1 Hz)
					
					if SET = '1' then
						contador <= IN_SET; -- permite uma mudanca "manual" no valor da contagem
					end if;
					
					if contador(5 downto 0) > "111011" then -- se segundos > 59
						contador(5 downto 0) <= "111011";    -- segundos <= 59
					end if;
					
					if EN = '1' then
						if contador(5 downto 0) = "000000" then              -- quando segundos chegar a zero
							contador(9 downto 6) <= contador(9 downto 6) - 1; -- decrementa os minutos
							contador(5 downto 0) <= "111011";                 -- segundos <= 59
						else
							contador(5 downto 0) <= contador(5 downto 0) - 1; -- senao, decrementa os segundos
						end if;
						
					end if;
				end if;
				CONTA <= contador; -- saida CONTA definida como o proprio contador
			end process;
end bhv;