
package ClockPackage is
	type Clock is record
		value: bit;
		count: integer;
	end record;
end package;

use work.ClockPackage.Clock;
entity ClockE is
	generic(period: time);
	port(clock: inout Clock);
end entity;

architecture ClockA of ClockE is
begin
	process
	begin
		wait for period;
		clock.value <= not clock;
		clock.count <= clock.count + 1;
	end process;
end architecture;
