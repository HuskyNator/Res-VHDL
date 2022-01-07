module scanner.scanner;
import scanner;
import std.exception : enforce;
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

	private static bool isLetter(char c) {
		return (c >= 'a' && c <= 'z')
			|| (c >= 'A' && c <= 'Z');
	}

	private static bool isNumber(char c) {
		return c >= '0' && c <= '9';
	}

	private static bool isIdChar(char c) {
		return isLetter(c) || c == '_' || isNumber(c);
	}

	private static bool isWhitespace(char c) {
		return c == ' ' || c == '\t' || c == '\r' || c == '\n';
	}

	private static bool isSymbol(char c) {
		return (c in symbolMap) != null;
	}

	private static char toLower(char c) {
		immutable int diff = 'A' - 'a';
		if (c >= 'A' && c <= 'Z')
			return cast(char)(c - diff);
		return c;
	}

	private static char toUpper(char c) {
		immutable int diff = 'A' - 'a';
		if (c >= 'a' && c <= 'z')
			return cast(char)(c + diff);
		return c;
	}

	unittest {
		assert(toLower('a') == 'a');
		assert(toLower('A') == 'a');
		assert(toLower('Z') == 'z');
		assert(toUpper('A') == 'A');
		assert(toUpper('a') == 'A');
		assert(toUpper('z') == 'Z');
	}

	bool endoftoken() {
		return eof() || (!isIdChar(c));
	}

	private static bool isBitStringChar(char c) {
		switch (c) {
		case 'b', 'B', 'o', 'O', 'x', 'X':
			return true;
		default:
			return false;
		}
	}

	Token scanBitString(char c) {
		ubyte base;
		string s = "";
		switch (c) {
		case 'b', 'B':
			base = 2;
			break;
		case 'o', 'O':
			base = 8;
			break;
		case 'x', 'X':
			base = 16;
			break;
		default:
			assert(0, "Char \'" ~ c ~ "\' is not a supported bitstring base denotation.");
		}
		next();
		while (true) {
			enforce(!eof(), "Expected closing \"");

			if (c == '\"') {
				Token token;
				token.type = TokenType.BitString;
				BitString bs = BitString(base, s.idup);
				token.bitstring = bs;
				return token;
			}

			final switch (base) {
			case 2:
				enforce(c == '0' || c == '1', "Invalid character in BitString: " ~ c);
				break;
			case 8:
				enforce(c >= '0' && c <= '7', "Invalid character in BitString: " ~ c);
				break;
			case 16:
				char upper = toUpper(c);
				enforce(isNumber(c) || (upper >= 'A' && upper <= 'F'), "Invalid character in BitString: " ~ c);
			}
			s ~= c;
		}
	}

	Token nextToken() {
		assert(!eof() && !isWhitespace(c));
		scope (exit)
			skipWhitespace();

		Token token;
		if (isLetter(c)) {
			string s = "" ~ c;
			next();
			if (!eof() && c == '\"' && isBitStringChar(s[0]))
				return scanBitString(s[0]);
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
		// TODO Numbers (Literal integer, real, scientific notation, base literals, physics literals)
		else if (isSymbol(c)) {
			import std.stdio;

			token.type = TokenType.Symbol;
			token.symbol = symbolMap[c];
			next(); // Consume symbol
			return token;
		} else if (c == '\"') {
			string s = "";
			bool escaped = false;
			while (true) {
				enforce(!eof(), "Expected closing \"");
				next();
				if (c == '\\')
					escaped = !escaped;
				else if (c == '\"' && !escaped) {
					next(); // Consume "
					token.type = TokenType.String;
					token.str = s.idup;
					return token;
				}
				s ~= c;
			}
		} else if (c == '\'') {
			char _c;

			next();
			enforce(!eof(), "Char missing closing \'");
			enforce(c != '\'', "Char missing content");

			next();
			enforce(!eof(), "Char missing closing \'");
			if (c == '\\') {
				next();
				enforce(!eof(), "Char missing closing \'");
				enforce(c in escapableChar, "Cannot escape " ~ c);
				_c = escapableChar[c];
			} else
				_c = c;

			next();
			enforce(!eof() && c == '\'', "Expected closing \'");
			next(); // Consume '

			token.type = TokenType.Char;
			token.chr = _c;
			return token;
		}
		assert(0); // TEMP
	}
}
