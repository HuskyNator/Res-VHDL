module scanner.token;
import scanner.keyword;
import scanner.symbol;
import scanner.bitstring;

enum TokenType {
	Keyword,
	Symbol,
	Operator,
	Identifier,
	String,
	Char,
	BitString,
	// TODO
	Integer,
	Real,
	Unit // time, etc.
}

immutable char[char] escapableChar;
shared static this(){
	escapableChar = [
		'\\':'\\',
		't': '\t',
		'r': '\r',
		'n': '\n'
	];
}

struct Token {
	TokenType type;
	union {
		Keyword keyword;
		Symbol symbol;
		string identifier;
		string str;
		char chr;
		BitString bitstring;
		// TODO
	}

	string toString() const pure nothrow {
		if (type == TokenType.Keyword)
			return "Keyword(" ~ keywordMapReverse[keyword] ~ ")";
		else if (type == TokenType.Identifier) {
			return "Identifier(\"" ~ identifier ~ "\")";
		} else if (type == TokenType.Symbol) {
			return "Symbol(\'" ~ symbolMapReverse[symbol] ~ "\')";
		} else
			assert(0);
	}
}
