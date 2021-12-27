
entity circ_tb is
end entity;

use std.env.finish;

architecture circ_tb of circ_tb is
	signal clock : Clock;
	signal a,b: bit_vector(1 downto 0);
	signal selector: bit_vector(0 downto 0);
	signal ares, bres: bit;
begin
	clockc: entity work.clock(ClockC) generic map(time => 5 ns) port map(clock => clock);
	circ: entity work.circ(CircA) generic map(bit, bit_vector, 2) port map(clock => clock, a=>a, b=>b, selector => selector, result => res);
		ares <= res(0);
		bres <= res(1);

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
