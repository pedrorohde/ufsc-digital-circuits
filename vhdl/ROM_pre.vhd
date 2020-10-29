library ieee;
use ieee.std_logic_1164.all;

entity ROM_pre is
  port ( address : in std_logic_vector(2 downto 0);
         data : out std_logic_vector(39 downto 0) );
end entity ROM_pre;

architecture behavioral of ROM_pre is
  type mem is array ( 0 to 2**3 - 1) of std_logic_vector(39 downto 0);
  constant my_Rom : mem := (
			  --c1\--c2\--c3\--c4\min\--seg\-------pot
    0  => "1100110010110011100000100000000000010000",  -- pipo, 02:00,  5
    1  => "1111101100100010101000100111100000001000",  --  cha, 02:30,  4
    2  => "1010101110100001111001100000000001000000",  -- legu, 06:00,  7
    3  => "1110011000110010101001010111100000100000",  -- sopa, 05:30,  6
    4  => "1011010010110001001101000010100000000100",  -- mioj, 04:10,  3
    5  => "0101111000101011100000110011111000000000",  -- bolo, 03:15, 10
    6  => "1100111110011011001010100000000010000000",  -- pudi, 10:00,  8
    7  => "0101011011110111100011111011010100000000"); -- arro, 15:45,  9
begin
   process (address)
   begin
     case address is
       when "000" => data <= my_rom(0);
       when "001" => data <= my_rom(1);
       when "010" => data <= my_rom(2);
       when "011" => data <= my_rom(3);
       when "100" => data <= my_rom(4);
       when "101" => data <= my_rom(5);
       when "110" => data <= my_rom(6);
       when "111" => data <= my_rom(7);
       when others => data <= "0000000000000000000000000000000000000000";
	 end case;
  end process;
end architecture behavioral;