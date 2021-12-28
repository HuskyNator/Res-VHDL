
entity circ_tb is
end entity;

package TypePackage is new work.CircTypePackage generic map(T=>bit);

use std.env.finish;
use work.ClockPackage.all;
use work.TypePackage.all;

library ieee;
use ieee.numeric_std.all;
use work.ClockPackage.all;
architecture circ_tb of circ_tb is
	signal clock : Clock;
	signal a,b: bit_vector(1 downto 0);
	signal selector: bit_vector(0 downto 0);
	signal ares, bres: bit;
begin
	clockc: entity work.ClockE(ClockC) generic map(time => 5 ns) port map(clock => clock);
	circ: entity work.CircE(CircA) generic map(bit, bit_vector, 2) port map(clock => clock, a=>a, b=>b, selector => selector, result(0) => ares, result(1) => bres);

	process
		variable bits: bit_vector(1 downto 0);
	begin
		for i in 0 to 2**2-1 loop
			bits := bit_vector(to_integer(i, bits'length));
			a <= bits;
			b <= not bits;
		end loop;
		finish;
	end process;
end architecture;
