library ieee; 
use ieee.std_logic_1164.all;

entity FSM_control is
port (PAUSE, READY, ENTER, PREDEF, RST, CLOCK_50: in std_logic;
		ESTADOS: out std_logic_vector(4 downto 0);
		SEL_DISP, SEL_LED: out std_logic_vector(1 downto 0);
		IN_POT, RESET_TIME, SET_TIME, EN_TIME, RESET_POT, EN_POT: out std_logic
		);
end FSM_control;

architecture FSM_beh of FSM_control is
	type states is (S0, S1, S2, S3, S4, S5, S6, S7);
	signal EA, PE: states;
	signal clock: std_logic;
	signal reset: std_logic;

begin
	
	clock <= CLOCK_50;
	reset <= RST;
	
	P1: process (clock, reset)
	begin
		if reset = '0' then -- pressionar reset "desliga" o micro-ondas independentemente do estado
			EA <= S0;		   -- passa ao estado 0 (INIT, micro-ondas desligado)
		elsif clock'event and clock = '1' then -- mudanca de estado apenas em transicao positiva de clock
			EA <= PE;
		end if;
	end process;
	
	
	P2: process (EA, ENTER, PREDEF, READY, PAUSE)
	begin
		case EA is
			when S0 => -- INIT
				if ENTER = '1' then -- enquanto enter nao for pressionado
					PE <= S0;			-- permanece no estado INIT
				else
					PE <= S1; -- pressionar enter passa ao estado OPEN
				end if;
				
				SEL_DISP   <= "00"; -- OFF
				SEL_LED    <= "00"; -- leds todos apagados
				ESTADOS <= "00000"; -- 0
	
				
			when S1 => -- OPEN
				if ENTER = '0' then -- botao enter para configuracao manual (estado 2)
					PE <= S2;
				elsif PREDEF = '0' then -- botao predef para configuracao pre-definida (estado 6)
					PE <= S6;
				else				-- se nenhum botao for prressionado
					PE <= S1;	 -- permanece no estado OPEN
				end if;
				
				SEL_LED    <= "01"; -- led piscando 1hz
				RESET_TIME  <= '1'; -- reseta contagem
				RESET_POT   <= '1'; -- reseta potencia
				EN_TIME     <= '0'; -- desabilita contagem
				SEL_DISP   <= "00"; -- leds todos apagados
				ESTADOS <= "00001"; -- 1

				
			when S2 => -- IN_TIME
				if ENTER = '0' then
					PE <= S3;			-- pressionar enter passa ao estado IN_POT
				else
					PE <= S2; 			-- enquanto enter nao for pressionado, permanece no estado IN_TIME
				end if;
				
				SET_TIME    <= '1'; -- habilita novo valor para contagem
				SEL_DISP   <= "10"; -- contagem
				RESET_TIME  <= '0'; -- desabilita reset do tempo
				RESET_POT   <= '0'; -- desabilita reset da potencia
				ESTADOS <= "00010"; -- 2
		
		
			when S3 => -- IN_POT
				if ENTER = '0' then
					PE <= S4;			-- pressionar enter passa ao estado WARM
				else
					PE <= S3;			-- enquanto enter nao for pressionado, permanece no estado IN_POT
				end if;
				
				EN_POT      <= '1'; -- habilita registrador da potencia
				SEL_LED    <= "10"; -- potencia
				SET_TIME    <= '0'; -- desabilita mudanca no valor de entrada da contagem
				IN_POT      <= '0'; -- potencia definida pelas chaves
				ESTADOS <= "00011"; -- 3
				
				
			when S4 => -- WARM
				if ENTER = '0' or READY = '1' then -- se enter pressionado ou contagem terminada
					PE <= S5;							  -- passa ao estado READY
				elsif PAUSE = '0' then	-- se botao PAUSE pressionado
					PE <= S7;				-- passa ao estado PAUSE
				else 			 -- enquanto PAUSE ou ENTER nao forem pressionados e READY for 0 (tempo nao chegou a 00:00)
					PE <= S4; -- permanece no estado WARM
				end if;
				
				EN_TIME     <= '1'; -- habilita contagem decrescente
				EN_POT      <= '0'; -- desabilita registrador da potencia
				SET_TIME    <= '0'; -- desabilita mudanca no valor de entrada da contagem
				SEL_DISP   <= "10"; -- contagem
				SEL_LED    <= "10"; -- potencia
				ESTADOS <= "00100"; -- 4
	
				
			when S5 => -- READY
				if ENTER = '0' then -- se enter pressionado, volta ao estado OPEN
					PE <= S1;
				else
					PE <= S5;	-- enquanto enter nao for pressionado, permanece em READY
				end if;
				
				SEL_DISP   <= "11"; -- hot
				SEL_LED    <= "11"; -- seq17
				ESTADOS <= "00101"; -- 5
	
	
			when S6 => -- IN_PREDEF
				if ENTER = '0' then -- pressionar enter passa ao estado WARM
					PE <= S4;
				else
					PE <= S6; -- enquanto enter nao for pressionado, permanece em IN_PREDEF
				end if;
				
				SEL_DISP   <= "01"; -- pre-definicao
				SEL_LED    <= "10"; -- potencia
				IN_POT      <= '1'; -- potencia definida pela pre-definicao
				EN_POT      <= '1'; -- habilita registrador da potencia
				RESET_TIME  <= '0'; -- desabilita reset do tempo
				RESET_POT   <= '0'; -- desabilita reset da potencia
				SET_TIME    <= '1'; -- habilita novo valor para a contagem
				ESTADOS <= "00110"; -- 6
			
			
			when S7 => -- PAUSE
				if PAUSE = '0' then -- pressionar o botao pause novamente faz voltar para WARM
					PE <= S4;
				elsif ENTER = '0' then -- pressionar enter passa ao estado READY
					PE <= S5;
				else
					PE <= S7; -- permanece pausado enquanto o botao pause e o enter nao forem pressionado novamente
				end if;
				
				EN_TIME     <= '0'; -- pausa a contagem decrescente
				EN_POT		<= '0'; -- desabilita registrador da potencia para que ela nao possa ser alterada
				SET_TIME    <= '0'; -- desabilita mudanca no tempo
				ESTADOS <= "00111"; -- 7
		
		
		end case;
	end process;

end FSM_beh;