library IEEE;
use IEEE.Std_Logic_1164.all;
entity top_seletores is
	port (OUT_POT, REG_ALARM, REG_OPEN, CONTA, SW: in std_logic_vector(9 downto 0);
			MODE: in std_logic_vector(39 downto 0);
			SEL_DISP, SEL_LED: in std_logic_vector(1 downto 0);
			IN_POT: in std_logic;
			LED_OUT, SEL_TIME, SEL_POT: out std_logic_vector(9 downto 0);
			REG: out std_logic_vector(19 downto 0)
			);
end top_seletores;

architecture seletores_estr of top_seletores is
	signal CONTA20: std_logic_vector(19 downto 0);
	signal comb: std_logic;
	
	component decod_mins
		port (i: in std_logic_vector(3 downto 0);
				o: out std_logic_vector(9 downto 0)
				);
	end component;
		
	component decod_segs
		port (i: in std_logic_vector(5 downto 0);
				o: out std_logic_vector(9 downto 0)
				);
	end component;
	
	component mux4x1_20
		port (w: in std_logic_vector(19 downto 0);
				x: in std_logic_vector(19 downto 0);
				y: in std_logic_vector(19 downto 0);
				z: in std_logic_vector(19 downto 0);
				s: in std_logic_vector(1 downto 0);
				m: out std_logic_vector(19 downto 0)
				);
	end component;
	
	component mux4x1_10
		port (w: in std_logic_vector(9 downto 0);
				x: in std_logic_vector(9 downto 0);
				y: in std_logic_vector(9 downto 0);
				z: in std_logic_vector(9 downto 0);
				s: in std_logic_vector(1 downto 0);
				m: out std_logic_vector(9 downto 0)
				);
	end component;
	
	component mux2x1_10
		port (w: in std_logic_vector(9 downto 0);
				x: in std_logic_vector(9 downto 0);
				s: in std_logic;
				m: out std_logic_vector(9 downto 0)
				);
	end component;
	
	begin
		L0: decod_mins port map (CONTA(9 downto 6), CONTA20(19 downto 10)); -- minutos
		L1: decod_segs port map(CONTA (5 downto 0), CONTA20(9 downto 0));   -- segundos
		L2: mux4x1_10 port map ("0000000000", REG_OPEN, OUT_POT, REG_ALARM, SEL_LED, LED_OUT); -- leds
		L3: mux4x1_20 port map ("11111110000111101111", MODE(39 downto 20), CONTA20, "11111100011100011101", SEL_DISP, REG);
				-- dec7seg e depois displays
		L4: mux2x1_10 port map (SW(9 downto 0), MODE(9 downto 0), IN_POT, SEL_POT); -- potencia
		comb <= (not SEL_DISP(1)) and SEL_DISP(0); -- 1 somente quando SEL_DISP = 01 (estado IN_PREDEF)
		L5: mux2x1_10 port map (SW(9 downto 0), MODE(19 downto 10), comb, SEL_TIME); -- tempo

end seletores_estr;