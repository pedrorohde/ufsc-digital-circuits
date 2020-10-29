library ieee;
use ieee.std_logic_1164.all;

entity reg_4 is port (
	CLK, RST, EN: in std_logic;
	D: in std_logic_vector(9 downto 0);
	Q: out std_logic_vector(9 downto 0));
end reg_4;

architecture behv of reg_4 is
begin
	process(CLK, RST, D)
	begin
		if RST = '0' then		 -- quando botao reset e pressionado
			Q <= "0000000000"; -- reseta valor
		elsif (CLK'event and CLK = '1') then -- se transicao positiva do clock
			if EN = '1' then						 -- se habilitado
				Q <= D;								 -- armazena novo valor
			end if;									 -- senao, valor de saida permanece inalterado
		end if;
	end process;
end behv;