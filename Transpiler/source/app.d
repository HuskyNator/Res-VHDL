import std.stdio;
import scanner;

void main() {
	Scanner s = new Scanner("../Examples/Clock/clock.res");
	while (!s.eof())
		writeln(s.nextToken());
}
