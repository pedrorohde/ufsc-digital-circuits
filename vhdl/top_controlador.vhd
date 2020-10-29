library ieee;
use ieee.std_logic_1164.all;

entity top_controlador is
	port (BTN3, BTN2, BTN1, BTN0, READY, CLOCK_50: in std_logic;
			ESTADOS: out std_logic_vector(4 downto 0);
			SEL_LED, SEL_DISP: out std_logic_vector(1 downto 0);
			RESET_POT, EN_POT, SET_TIME, RESET_TIME, EN_TIME, IN_POT: out std_logic
			);
end top_controlador;

architecture ctrl_estr of top_controlador is
	
	component FSM_control
		port (PAUSE, READY, ENTER, PREDEF, RST, CLOCK_50: in std_logic;
				ESTADOS: out std_logic_vector(4 downto 0);
				SEL_DISP, SEL_LED: out std_logic_vector(1 downto 0);
				IN_POT, RESET_TIME, SET_TIME, EN_TIME, RESET_POT, EN_POT: out std_logic
				);
	end component;
	
	begin
		L0: FSM_control port map (BTN3, READY, BTN1, BTN2, BTN0, CLOCK_50, ESTADOS, SEL_DISP, SEL_LED, IN_POT, RESET_TIME, SET_TIME, EN_TIME, RESET_POT, EN_POT);
				-- BTN3 para PAUSE
				-- BTN2 para PREDEF
				-- BTN1 para ENTER
				-- BTN0 para RST
end ctrl_estr;