
entity multiplexer_tb is
end entity;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

architecture multiplexer_tb of multiplexer_tb is
  signal input : std_logic_vector(3 downto 0);
  signal sel : std_logic_vector(1 downto 0);
  signal output : std_logic;
begin
  MUX : entity work.multiplexer
    generic map(T => std_logic, TA => std_logic_vector, L => 4)
    port map(input => input, sel => sel, output => output);

  process
  begin
	input <= "0101";
	wait for 1 ns;

	GEN : for i in 0 to 3 loop
		sel <= std_logic_vector(to_unsigned(i, sel'length));
		wait for 1 ns;
		assert output = input(i);
	end loop;
	finish;
  end process;
end architecture;