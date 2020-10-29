library ieee;
use ieee.std_logic_1164.all;

entity reg_10 is port (
	CLK, RST: in std_logic;
	D: in std_logic_vector(9 downto 0);
	Q: out std_logic_vector(9 downto 0));
end reg_10;

architecture behv of reg_10 is
begin
	process(CLK, RST, D)
	begin
		if RST = '0' then		 -- se botao reset e pressionado
			Q <= "0000000000"; -- reseta valor
		elsif (CLK'event and CLK = '1') then -- se transicao positiva do clock
			Q <= D;									 -- armazena novo valor
		end if;										 -- senao valor permanece inalterado
	end process;
end behv;