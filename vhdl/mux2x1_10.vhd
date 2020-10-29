library IEEE;
use IEEE.Std_Logic_1164.all;
entity mux2x1_10 is
	port (w: in std_logic_vector(9 downto 0); -- mux com 2 entradas de dados de 10 bits
			x: in std_logic_vector(9 downto 0);
			s: in std_logic;							-- entrada de selecao define qual entrada passara a saida
			m: out std_logic_vector(9 downto 0) -- saida de 10 bits
			);
end mux2x1_10;

architecture mux_estr of mux2x1_10 is
	begin
		m <=  w when s = '0' else -- se s for 0, m sera w
				x;                  -- senao, m sera x
end mux_estr;