library ieee;
use ieee.std_logic_1164.all;

entity top_contadores is
	port (RST, SET_TIME, RESET_TIME, EN_TIME, CLOCK_50: in std_logic;
			SEL_TIME: in std_logic_vector(9 downto 0);
			CLK1, CLK2: out std_logic;
			CONTA: out std_logic_vector(9 downto 0)
			); -- nao foi necessario PAUSE (BTN3) pois a pausa (EN_TIME = 0) ja esta definida por FSM_control
end top_contadores;

architecture cntd_estr of top_contadores is
	
	signal clock1,		-- fio interno do bloco para ligar a saida CLK1 de FSM_clock com 
							 -- a entrada de CONTA_DESC e com a saida do bloco
			 RST_CONST: -- saida da logica combinatoria que determina o reset da contagem
			 std_logic;
	
	component FSM_clock
		port (CLOCK_50, RST: in std_logic;
				CLK1, CLK2: out std_logic
				);
	end component;
	
	component CONTA_DESC
		port (CLK, RST, EN, SET: in std_logic;
				IN_SET: in std_logic_vector(9 downto 0);
				CONTA: out std_logic_vector(9 downto 0)
				);
	end component;
	
	begin
		L1: FSM_clock port map (CLOCK_50, RST, clock1, CLK2);
		
		CLK1 <= clock1; -- fio entre FSM_clock e CONTA_DESC para CLK1
		RST_CONST <= RST and (not RESET_TIME); -- 0 quando botao RST pressionado ou RESET_TIME = 1
		
		L2: CONTA_DESC port map (clock1, RST_CONST, EN_TIME, SET_TIME, SEL_TIME, CONTA);

end cntd_estr;