module scanner.symbol;

enum Symbol {
	RoundL, // (
	RoundR, // )
	CurlL, // {
	CurlR, // }
	SquareL, // [
	SquareR, // ]
	Dot, // .
	Comma, // ,
	Colon, // :
	Semicolon, // ;
	Is, // =
	Exclamation, // !
	Plus, // +
	Minus, // -
	Times, // *
	ArrowR, // >
	ArrowL // <
}

immutable Symbol[char] symbolMap;

immutable char[Symbol] symbolMapReverse;

shared static this() {
	symbolMap = [
		'(': Symbol.RoundL,
		')': Symbol.RoundR,
		'{': Symbol.CurlL,
		'}': Symbol.CurlR,
		'[': Symbol.SquareL,
		']': Symbol.SquareR,
		'.': Symbol.Dot,
		',': Symbol.Comma,
		':': Symbol.Colon,
		';': Symbol.Semicolon,
		'=': Symbol.Is,
		'!': Symbol.Exclamation,
		'+': Symbol.Plus,
		'-': Symbol.Minus,
		'*': Symbol.Times,
		'>': Symbol.ArrowR,
		'<': Symbol.ArrowL
	];
	foreach (entry; symbolMap.byKeyValue()) {
		symbolMapReverse[entry.value] = entry.key;
	}
}
