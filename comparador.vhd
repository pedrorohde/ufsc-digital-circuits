library IEEE;
use IEEE.Std_Logic_1164.all;

entity comparador is
port (A, B: in std_logic_vector(9 downto 0);
		EQ: out std_logic);
end comparador;

architecture comp_stru of comparador is
begin
		EQ <= (A(9) xnor B(9)) and -- porta XNOR tem saida 1 quando suas entradas sao iguais
				(A(8) xnor B(8)) and -- se cada bit de A for igual ao respectivo bit de B (saida da XNOR = 1),
				(A(7) xnor B(7)) and  -- a saida EQ sera 1, por causa das ANDs
				(A(6) xnor B(6)) and
				(A(5) xnor B(5)) and
				(A(4) xnor B(4)) and
				(A(3) xnor B(3)) and
				(A(2) xnor B(2)) and
				(A(1) xnor B(1)) and
				(A(0) xnor B(0));
end comp_stru;