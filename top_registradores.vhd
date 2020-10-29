library IEEE;
use IEEE.Std_Logic_1164.all;
entity top_registradores is
	port (BTN0, CLK1, CLK2, RESET_POT, EN_POT: in std_logic;
			SEL_POT: in std_logic_vector(9 downto 0);
			REG_OPEN, REG_ALARM, OUT_POT: out std_logic_vector (9 downto 0)
			);
end top_registradores;

architecture registradores_estr of top_registradores is
	signal RST_P:			 -- reset do registrador (comb entre RST e RESET_POT)
			 std_logic;
	signal in_reg_open,   -- saida da inversora / entrada do registrador
			 out_reg_open,  -- saida do registrador / entrada da inversora
			 in_reg_alarm,  -- saida de comb / entrada do registrador
			 out_reg_alarm, -- saida do registrador / entrada de comb
			 decod_out:     -- saida do decodificador / entrada do registrador
			 std_logic_vector(9 downto 0);

	component reg_10
		port (CLK, RST: in std_logic;
				D: in std_logic_vector(9 downto 0);
				Q: out std_logic_vector(9 downto 0)
				);
	end component;
	
	component reg_4
		port (CLK, RST, EN: in std_logic;
				D: in std_logic_vector(9 downto 0);
				Q: out std_logic_vector(9 downto 0)
				);
	end component;
	
	component decod_pot
		port (i: in std_logic_vector(9 downto 0);
				o: out std_logic_vector(9 downto 0)
				);
	end component;
	
	component ROM_seq17
		port (address : in std_logic_vector(9 downto 0);
				data : out std_logic_vector(9 downto 0)
				);
	end component;

	begin
		L0: reg_10 port map (CLK1, BTN0, in_reg_open, out_reg_open);
		REG_OPEN <= out_reg_open; -- saida REG_OPEN definida como a saida do registrador
		in_reg_open <= not out_reg_open; -- inverte a saida do registrador para gerar a nova entrada
		L1: decod_pot port map (SEL_POT, decod_out);
		RST_P <= BTN0 and (not RESET_POT); -- 0 quando BTN0 pressionado ou RESET_POT = 1
		L2: reg_4 port map (CLK1, RST_P, EN_POT, decod_out, OUT_POT);
		L3: reg_10 port map (CLK2, BTN0, in_reg_alarm, out_reg_alarm);
		REG_ALARM <= out_reg_alarm; -- saida REG_ALARM definida como a saida do registrador
		L4: ROM_seq17 port map (out_reg_alarm, in_reg_alarm);
				-- gera novo valor para a entrada do registrador a partir de ROM_seq17
	
end registradores_estr;