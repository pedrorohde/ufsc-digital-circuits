library ieee;
use ieee.std_logic_1164.all;

entity ROM_seq17 is -- sequencia 17
  port (address : in std_logic_vector(9 downto 0);
        data : out std_logic_vector(9 downto 0)
		  );
end entity ROM_seq17;

architecture behavioral of ROM_seq17 is
  type mem is array (0 to 19) of std_logic_vector(9 downto 0);
  constant my_rom : mem := (
    0  => "0000000001",
	 1  => "0000000010",
	 2  => "0000000100",
	 3  => "0000001000",
	 4  => "0000010000",
	 5  => "0000100000",
	 6  => "0001000000",
	 7  => "0010000000",
	 8  => "0100000000",
	 9  => "1000000001",
	 10 => "0000000011",
	 11 => "0000000110",
	 12 => "0000001100",
	 13 => "0000011000",
	 14 => "0000110000",
	 15 => "0001100000",
	 16 => "0011000000",
	 17 => "0110000000",
	 18 => "1100000000",
	 19 => "1000000000");
begin
   process (address)
   begin
     case address is
       when "0000000001" => data <= my_rom(1); -- address aponta para o estado seguinte
		 when "0000000010" => data <= my_rom(2);
		 when "0000000100" => data <= my_rom(3);
		 when "0000001000" => data <= my_rom(4);
		 when "0000010000" => data <= my_rom(5);
		 when "0000100000" => data <= my_rom(6);
		 when "0001000000" => data <= my_rom(7);
		 when "0010000000" => data <= my_rom(8);
		 when "0100000000" => data <= my_rom(9);
		 when "1000000001" => data <= my_rom(10);
		 when "0000000011" => data <= my_rom(11);
		 when "0000000110" => data <= my_rom(12);
		 when "0000001100" => data <= my_rom(13);
		 when "0000011000" => data <= my_rom(14);
		 when "0000110000" => data <= my_rom(15);
		 when "0001100000" => data <= my_rom(16);
		 when "0011000000" => data <= my_rom(17);
		 when "0110000000" => data <= my_rom(18);
		 when "1100000000" => data <= my_rom(19);
       when others => data <= my_rom(0);
		 
	 end case;
  end process;
end architecture behavioral;