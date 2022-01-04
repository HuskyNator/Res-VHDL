
interface ClockI(time halftime = 5ns) {
	inout logic clk = 0;
}

circuit Clock: ClockI!10ns {
	main {
		clk = not clk after halftime;
	}
}