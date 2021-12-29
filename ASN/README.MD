# Adrian Syntax Notation (ASN)
A custom notation, inspired by ABNF.
It is designed to
- Reduce extensive `"` use.
- Simplify delimited lists.
---
## Notation
1. Productions are defined as: `production = elements\`
2. All special elements are denoted by a prefixed `@`:
	1. Placeholders:
		+ `@production`
	2. Groups: 
		+ `@[element element ...]`
	3. Element from set:
		+ `@[element | element | ...]`
	4. Count:
		+ Element prepended with `@` and a count marker.
		+ Optional: `@?element`
		+ Repetition (any number): `@*element`
		+ Repetition (1 or more): `@+element`
		+ Repetition (a till b): `@a-b*element`
	5. List:
		+ `@^delimiter` followed by a count marker.
		+ For multicharacter delimiters, use `@^(delimiter)` instead.
		+ `@^;+[@thing]` is equivalent to `@thing @*[; @thing]`

3. Brackets `[]` and `()` can be used interchangeably.
4. When using counts, groups/sets/lists can exclude their second `@`: `@?@[...]` -> `@?[...]`
4. All other parts should be considered as literal text.
   1. Special symbols need to be escaped using a `\` in text:
		>	`@`, `\`, `|`, `[`, `]`, `(`, `)`, `#`, `` ` ``
   2. Alternatively literal strings can be used: `` `@\|[]()#` ``
5. All words have implied surrounding whitespace (see future considerations).
6. Line comments start with a `#`: `... #comment`

## Future Considerations
- Possibly customize delimiter, if possible.
- Possibly add whitespace sensitivity. This could be moving more towards ABNF, though delimiters could also be used to refer to whitespace tokens like `@tab`.

## Example
### Extended Backus-Naur Form (EBNF):
```
entity =
	"entity", name, "is",
		["generic", "(" generic, {";" , generic}, ")"],
		["port", "(" port , {";" , port}, ")"],
	"end", ["entity"], [name], ";";

generic = name, ":", type, [":=", default_value];

port = name, ":", porttype, type;

porttype = "in" | "out" | "inout" | "buffer";
```

### Adrian Syntax Notation (ASN):
```asn
entity =
	entity @name is
		@?[generic \(@^;*[@generic]\);]
		@?[port \(@?^;+[@port]\);]
	end @?entity @?@name;\

generic = @name : @type @?[:= @default_value]\

port = @name : @porttype @type\

porttype = @[in | out | inout | buffer]\
```