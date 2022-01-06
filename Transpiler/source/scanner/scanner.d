module scanner.scanner;
import scanner;

import std.file : readText;

final class Scanner {
	string file;
	char c;
	uint index = 0;

	this(string filename) {
		this.file = readText(filename);
		if (file.length > 0)
			c = file[index];
		skipWhitespace();
	}

	void skipWhitespace() {
		while (!eof() && isWhitespace(c))
			next();
	}

	bool eof() {
		return index == file.length;
	}

	void next() {
		assert(!eof());
		this.index += 1;
		if (!eof())
			this.c = file[index];
	}

	bool isLetter(char c) {
		return (c >= 'a' && c <= 'z')
			|| (c >= 'A' && c <= 'Z');
	}

	bool isNumber(char c) {
		return c >= '0' && c <= '9';
	}

	bool isIdChar(char c) {
		return isLetter(c) || c == '_' || isNumber(c);
	}

	bool isWhitespace(char c) {
		return c == ' ' || c == '\t' || c == '\r' || c == '\n';
	}

	bool endoftoken() {
		return eof() || (!isIdChar(c));
	}

	Token nextToken() {
		assert(!eof() && !isWhitespace(c));
		scope (exit)
			skipWhitespace();

		Token token;
		if (isLetter(c)) {
			string s = "" ~ c;
			next();
			while (!endoftoken()) {
				s ~= c;
				next();
			}
			if (s in keywordMap) {
				token.type = TokenType.Keyword;
				token.keyword = keywordMap[s];
			} else {
				token.type = TokenType.Identifier;
				token.identifier = s.idup;
			}
			return token;
		}
		assert(0); // TEMP
	}
}
