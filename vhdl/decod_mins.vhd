library IEEE;
use IEEE.Std_Logic_1164.all;
entity decod_mins is									-- converte a contagem dos minutos para
	port (i: in std_logic_vector(3 downto 0); -- um formato adequado aos dois dec7seg
			o: out std_logic_vector(9 downto 0) -- (5 bits para as dezenas e mais 5 para as unidades)
			);
end decod_mins;

architecture decod_estr of decod_mins is
	begin
		o <=
   -- dezena/unidade
		 --0--/----
		"0000000000" when i = "0000" else --00
		"0000000001" when i = "0001" else --01
		"0000000010" when i = "0010" else --02
		"0000000011" when i = "0011" else --03
		"0000000100" when i = "0100" else --04
		"0000000101" when i = "0101" else --05
		"0000000110" when i = "0110" else --06
		"0000000111" when i = "0111" else --07
		"0000001000" when i = "1000" else --08
		"0000001001" when i = "1001" else --09
		
		 --1--/----
		"0000100000" when i = "1010" else --10
		"0000100001" when i = "1011" else --11
		"0000100010" when i = "1100" else --12
		"0000100011" when i = "1101" else --13
		"0000100100" when i = "1110" else --14
		"0000100101";                     --15 (maximo de 15 minutos)
		
end decod_estr;