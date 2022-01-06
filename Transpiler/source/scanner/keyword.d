module scanner.keyword;
import scanner;

enum Keyword {
	import_,
	interface_,
	circuit_,
	in_,
	out_,
	inout_,
	main_,
	process_,
	// Types
	int_,
	uint_,
	logic_,
	bit_
}

immutable Keyword[string] keywordMap;
immutable string[Keyword] keywordMapReverse;

shared static this() {
	foreach (string keyword; __traits(allMembers, Keyword)) {
		string s = keyword[0 .. $ - 1];
		Keyword k = __traits(getMember, Keyword, keyword);
		keywordMap[s] = k;
		keywordMapReverse[k] = s;
	}
}
