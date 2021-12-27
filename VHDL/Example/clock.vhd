
type Clock is record
	value: bit := '0';
	count: integer := 0;
end record;

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
