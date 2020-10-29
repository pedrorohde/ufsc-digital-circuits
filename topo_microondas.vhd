-- organiza todos os outros blocos, definindo as ligacoes entre eles

library ieee;
use ieee.std_logic_1164.all;

entity topo_microondas is
	port (CLOCK_50: in std_logic;
			SW: in std_logic_vector(9 downto 0);
			KEY: in std_logic_vector(3 downto 0);
			LEDR: out std_logic_vector(9 downto 0);
			HEX5, HEX4, HEX3, HEX2, HEX1, HEX0: out std_logic_vector(6 downto 0)
			); -- somente entradas e saidas da placa
end topo_microondas;

architecture topo_estr of topo_microondas is -- fios entre os blocos
	signal MODE: std_logic_vector(39 downto 0);
	signal REG: std_logic_vector(19 downto 0);
	signal SEL_POT, SEL_TIME, CONTA, LED_OUT, OUT_POT, REG_ALARM, REG_OPEN: std_logic_vector(9 downto 0);
	signal ESTADOS: std_logic_vector(4 downto 0);
	signal BTN: std_logic_vector(3 downto 0);
	signal SEL_LED, SEL_DISP: std_logic_vector(1 downto 0);
	signal CLK1, CLK2, READY, RESET_TIME, RESET_POT, EN_TIME, SET_TIME, IN_POT, EN_POT: std_logic;
	
	component top_comparador
		port (CONTA: in std_logic_vector(9 downto 0);
				READY: out std_logic
				);
	end component;
	
	component top_contadores
		port (RST, SET_TIME, RESET_TIME, EN_TIME, CLOCK_50: in std_logic;
				SEL_TIME: in std_logic_vector(9 downto 0);
				CLK1, CLK2: out std_logic;
				CONTA: out std_logic_vector(9 downto 0)
				);
	end component;
	
	component top_controlador
		port (BTN3, BTN2, BTN1, BTN0, READY, CLOCK_50: in std_logic;
				ESTADOS: out std_logic_vector(4 downto 0);
				SEL_LED, SEL_DISP: out std_logic_vector(1 downto 0);
				RESET_POT, EN_POT, SET_TIME, RESET_TIME, EN_TIME, IN_POT: out std_logic
				);
	end component;
	
	component top_debouncer
		port (KEY: in std_logic_vector(3 downto 0);
				CLOCK_50: in std_logic;
				BTN: out std_logic_vector(3 downto 0)
				);
	end component;
	
	component top_predefinicao
		port (SW: in std_logic_vector(2 downto 0);
				MODE: out std_logic_vector(39 downto 0)
				);
	end component;
	
	component top_registradores
		port (BTN0, CLK1, CLK2, RESET_POT, EN_POT: in std_logic;
				SEL_POT: in std_logic_vector(9 downto 0);
				REG_OPEN, REG_ALARM, OUT_POT: out std_logic_vector (9 downto 0)
				);
	end component;
	
	component top_seletores
		port (OUT_POT, REG_ALARM, REG_OPEN, CONTA, SW: in std_logic_vector(9 downto 0);
				MODE: in std_logic_vector(39 downto 0);
				SEL_DISP, SEL_LED: in std_logic_vector(1 downto 0);
				IN_POT: in std_logic;
				LED_OUT, SEL_TIME, SEL_POT: out std_logic_vector(9 downto 0);
				REG: out std_logic_vector(19 downto 0)
				);
	end component;
	
	component dec7seg
		port (C: in std_logic_vector(4 downto 0);
				F: out std_logic_vector(6 downto 0)
				);
	end component;
	
	begin -- ligacoes entre os blocos e associacao de fios
		L0: top_debouncer port map (KEY(3 downto 0), CLOCK_50, BTN(3 downto 0));
			-- botoes agora sao BTN
		L1: top_predefinicao port map (SW(2 downto 0), MODE(39 downto 0));
			-- saida da predefinicao depende dos switches
		L2: top_controlador port map (BTN(3), BTN(2), BTN(1), BTN(0), READY, CLOCK_50, ESTADOS, SEL_LED,
												SEL_DISP, RESET_POT, EN_POT, SET_TIME, RESET_TIME, EN_TIME, IN_POT);
			-- saidas do controlador controlam os demais blocos
		L3: top_contadores port map (BTN(0), SET_TIME, RESET_TIME, EN_TIME, CLOCK_50, SEL_TIME, CLK1, CLK2, CONTA);
			-- contador define os clocks de 1 e 10 Hz e faz a contagem regressiva
		L4: top_comparador port map (CONTA, READY);
			-- indica se conta e 0000000000
		L5: top_registradores port map (BTN(0), CLK1, CLK2, RESET_POT, EN_POT, SEL_POT, REG_OPEN, REG_ALARM, OUT_POT);
			-- registradores para os efeitos de luz nos LEDs
		L6: top_seletores port map (OUT_POT, REG_ALARM, REG_OPEN, CONTA, SW, MODE, SEL_DISP, SEL_LED, IN_POT, LEDR, SEL_TIME, SEL_POT, REG);
			-- seleciona quais valores mostrar nos displays e LEDs, alem dos valores de tempo e potencia
		L7: dec7seg port map (REG(4 downto 0), HEX0); -- display mais a direita (unidade dos segundos no tempo)
		L8: dec7seg port map (REG(9 downto 5), HEX1); -- (dezena dos segundos no tempo)
		L9: dec7seg port map (REG(14 downto 10), HEX2); -- (unidade dos minutos no tempo)
		L10: dec7seg port map (REG(19 downto 15), HEX3); -- (dezena dos minutos no tempo)
		L11: dec7seg port map (ESTADOS, HEX4); -- (estado atual da maquina de estados)
		HEX5 <= "0000110"; -- display mais a esquerda (mostra a letra E sempre)
		
end topo_estr;