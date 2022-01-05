/*
Can use explicit port maps to intermediate signals.
Can have implicit maps using `circuit.port` access.
*/

circuit Multiplexer_tb {
	logic[4] input;
	auto mux = new Multiplexer!(logic, 4)(input = input);

	process {
		input = "0101";
		wait for 1ns;
		for uint i in [0:4] {
			mux.sel = logic(i);
			wait for 1ns;
			assert mux.output == input[i];
		}
		finish();
	}
}
