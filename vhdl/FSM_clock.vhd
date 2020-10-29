library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FSM_clock is
	port (CLOCK_50, RST: in std_logic;
			CLK1, --  1Hz
			CLK2: -- 10Hz
			out std_logic
			);
end FSM_clock;

architecture bhv of FSM_clock is
	signal contador1hz: std_logic_vector(3 downto 0);
	signal contador10hz: std_logic_vector(23 downto 0);

	begin
		P1: process(CLOCK_50, RST)
			
			begin
				if RST = '0' then
					contador1hz <= "0000";
					contador10hz <= x"000000";
					
				elsif CLOCK_50'event and CLOCK_50 = '1' then -- transicao positiva de CLOCK_50
					contador10hz <= contador10hz + 1;  -- incrementa contador para o clock de 10Hz
					
					if contador10hz =  x"4C4B3F" then  -- apos 5 milhoes de ciclos de CLOCK_50 (0,1 segundo)
						contador10hz <= x"000000";		  -- reseta contador para o clock de 10Hz
						CLK2 <= '1';						  -- CLK2 fica em nivel logico alto
						contador1hz <= contador1hz + 1; -- incrementa contador para o clock de 1Hz
					else
						CLK2 <= '0';
					end if;
					
					if contador1hz = "1010" then -- apos o 10o ciclo de CLK2 (1 segundo)
						contador1hz <= "0000";	  -- reseta contador para o clock de 1Hz
						CLK1 <= '1';				  -- CLK1 fica em nivel logico alto
					else
						CLK1 <= '0';
					end if;
					
				end if;
			end process;
		
end bhv;