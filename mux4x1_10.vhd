library IEEE;
use IEEE.Std_Logic_1164.all;
entity mux4x1_10 is
	port (w: in std_logic_vector(9 downto 0); -- mux com 4 entradas de 10 bits
			x: in std_logic_vector(9 downto 0);
			y: in std_logic_vector(9 downto 0);
			z: in std_logic_vector(9 downto 0);
			s: in std_logic_vector(1 downto 0); -- entrada de selecao de 2 bits define qual entrada passa a saida
			m: out std_logic_vector(9 downto 0) -- saida de 10 bits
			);
end mux4x1_10;

architecture mux_estr of mux4x1_10 is
	begin
		m <=  w when s = "00" else -- se s for 00, m sera w
				x when s = "01" else -- se s for 01, m sera x
				y when s = "10" else -- se s for 10, m sera y
				z;                   -- senao, m sera z
end mux_estr;