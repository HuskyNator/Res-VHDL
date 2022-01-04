
circuit Clock_tb {
	ClockI!5ns clock = new Clock;

	process {
		wait for 100ns;
		finish;
	}
}