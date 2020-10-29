library IEEE;
use IEEE.Std_Logic_1164.all;
entity decod_segs is									-- converte a contagem dos segundos para 
	port (i: in std_logic_vector(5 downto 0); -- um formato adequado aos dois dec7seg
			o: out std_logic_vector(9 downto 0) -- (5 bits para as dezenas e mais 5 para as unidades)
			);
end decod_segs;

architecture decod_estr of decod_segs is
	begin
		o <=
   -- dezena/unidade
		 --0--/----
		"0000000000" when i = "000000" else --00
		"0000000001" when i = "000001" else --01
		"0000000010" when i = "000010" else --02
		"0000000011" when i = "000011" else --03
		"0000000100" when i = "000100" else --04
		"0000000101" when i = "000101" else --05
		"0000000110" when i = "000110" else --06
		"0000000111" when i = "000111" else --07
		"0000001000" when i = "001000" else --08
		"0000001001" when i = "001001" else --09
		
	  	 --1--/----
		"0000100000" when i = "001010" else --10
		"0000100001" when i = "001011" else --11
		"0000100010" when i = "001100" else --12
		"0000100011" when i = "001101" else --13
		"0000100100" when i = "001110" else --14
		"0000100101" when i = "001111" else --15
		"0000100110" when i = "010000" else --16
		"0000100111" when i = "010001" else --17
		"0000101000" when i = "010010" else --18
		"0000101001" when i = "010011" else --19
		
		 --2--/----
		"0001000000" when i = "010100" else --20
		"0001000001" when i = "010101" else --21
		"0001000010" when i = "010110" else --22
		"0001000011" when i = "010111" else --23
		"0001000100" when i = "011000" else --24
		"0001000101" when i = "011001" else --25
		"0001000110" when i = "011010" else --26
		"0001000111" when i = "011011" else --27
		"0001001000" when i = "011100" else --28
		"0001001001" when i = "011101" else --29
		
		 --3--/----
		"0001100000" when i = "011110" else --30
		"0001100001" when i = "011111" else --31
		"0001100010" when i = "100000" else --32
		"0001100011" when i = "100001" else --33
		"0001100100" when i = "100010" else --34
		"0001100101" when i = "100011" else --35
		"0001100110" when i = "100100" else --36
		"0001100111" when i = "100101" else --37
		"0001101000" when i = "100110" else --38
		"0001101001" when i = "100111" else --39
		
		 --4--/----
		"0010000000" when i = "101000" else --40
		"0010000001" when i = "101001" else --41
		"0010000010" when i = "101010" else --42
		"0010000011" when i = "101011" else --43
		"0010000100" when i = "101100" else --44
		"0010000101" when i = "101101" else --45
		"0010000110" when i = "101110" else --46
		"0010000111" when i = "101111" else --47
		"0010001000" when i = "110000" else --48
		"0010001001" when i = "110001" else --49
		
		 --5--/----
		"0010100000" when i = "110010" else --50
		"0010100001" when i = "110011" else --51
		"0010100010" when i = "110100" else --52
		"0010100011" when i = "110101" else --53
		"0010100100" when i = "110110" else --54
		"0010100101" when i = "110111" else --55
		"0010100110" when i = "111000" else --56
		"0010100111" when i = "111001" else --57
		"0010101000" when i = "111010" else --58
		"0010101001";							   --59
		
end decod_estr;