library ieee;
use ieee.std_logic_1164.all;
entity top_predefinicao is
	port (SW: in std_logic_vector(2 downto 0);
			MODE: out std_logic_vector(39 downto 0)
			);
end top_predefinicao;

architecture pre_estr of top_predefinicao is
	
	component ROM_pre
		port (address : in std_logic_vector(2 downto 0);
				data : out std_logic_vector(39 downto 0)
				);
	end component;
	
	begin
		L0: ROM_pre port map (SW(2 downto 0), MODE(39 downto 0));
		-- switches definem a escolha do modo pre-definido de aquecimento
	
end pre_estr;