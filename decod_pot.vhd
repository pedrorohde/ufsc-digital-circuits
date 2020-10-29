library IEEE;
use IEEE.Std_Logic_1164.all;
entity decod_pot is
	port (i: in std_logic_vector(9 downto 0);
			o: out std_logic_vector(9 downto 0)
			);
end decod_pot;

architecture decod_estr of decod_pot is -- liga todos os leds a direita do switch, inclusive
	begin
		o(9) <= i(9);
		o(8) <= i(8) or i(9);
		o(7) <= i(7) or i(8) or i(9);
		o(6) <= i(6) or i(7) or i(8) or i(9);
		o(5) <= i(5) or i(6) or i(7) or i(8) or i(9);
		o(4) <= i(4) or i(5) or i(6) or i(7) or i(8) or i(9);
		o(3) <= i(3) or i(4) or i(5) or i(6) or i(7) or i(8) or i(9);
		o(2) <= i(2) or i(3) or i(4) or i(5) or i(6) or i(7) or i(8) or i(9);
		o(1) <= i(1) or i(2) or i(3) or i(4) or i(5) or i(6) or i(7) or i(8) or i(9);
		o(0) <= i(0) or i(1) or i(2) or i(3) or i(4) or i(5) or i(6) or i(7) or i(8) or i(9);

end decod_estr;