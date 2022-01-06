import std.stdio;
import scanner;
import std.conv: to;

void main()
{
	Scanner s = new Scanner("test.txt");
	writeln(s.nextToken());
	writeln(s.nextToken());
}
