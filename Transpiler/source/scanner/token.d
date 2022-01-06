module scanner.token;
import scanner;
import std.conv : to;

enum TokenType {
	Keyword,
	Identifier
}

struct Token {
	TokenType type;
	union {
		Keyword keyword;
		string identifier;
	}

	string toString() const pure nothrow {
		if (type == TokenType.Keyword)
			return "Keyword(" ~ keywordMapReverse[keyword] ~ ")";
		else if (type == TokenType.Identifier){
			return "Identifier(\"" ~ identifier ~ "\")";}
		else assert(0);
	}
}
