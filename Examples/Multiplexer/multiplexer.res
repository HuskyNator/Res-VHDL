import res.math.log2;

interface MultiplexerI(T, uint L) {
	in T[L] input;
	in logic[log2(L)];
	out T output;
}

circuit Multiplexer(T, uint L): MultiplexerI!(T, L) {
	main {
		output = input(uint(input));
	}
}