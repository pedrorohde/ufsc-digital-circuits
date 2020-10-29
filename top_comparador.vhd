library IEEE;
use IEEE.Std_Logic_1164.all;
entity top_comparador is
	port (CONTA: in std_logic_vector(9 downto 0);
			READY: out std_logic
			);
end top_comparador;

architecture comparador_estr of top_comparador is
	component comparador
		port (A, B: in std_logic_vector(9 downto 0);
				EQ: out std_logic
				);
	end component;

	begin
		L0: comparador port map ("0000000000", CONTA, READY);
		-- quando CONTA for 0000000000, READY sera 1
	
end comparador_estr;