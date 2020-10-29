library IEEE;
use IEEE.Std_Logic_1164.all;
entity top_debouncer is
	port (KEY: in std_logic_vector(3 downto 0);
			CLOCK_50: in std_logic;
			BTN: out std_logic_vector(3 downto 0)
			);
end top_debouncer;

architecture debouncer_estr of top_debouncer is

	component ButtonSync
		port (key0 : in  std_logic;
				key1 : in  std_logic;
				key2 : in  std_logic;
				key3 : in  std_logic;	
				clk  : in  std_logic;
				btn0 : out std_logic;
				btn1 : out std_logic;
				btn2 : out std_logic;
				btn3 : out std_logic
				);
	end component;
	
	begin
		L0: ButtonSync port map (KEY(0), KEY(1), KEY(2), KEY(3), CLOCK_50, BTN(0), BTN(1), BTN(2), BTN(3));
	
end debouncer_estr;