# Adrian syntax notation (ASN)
A custom notation, inspired by ABNF.
It is designed to
- Reduce extensive `"` use.
- Simplify delimited lists.
---
## Notation
1. All special elements are denoted by a prefixed `@`:
> - Placeholders:
>   + `@class`
>     - All classes are defined as: `class = elements`.
> - Groups: 
>   + `@[element element ...]`
> - Element from set:
>   + `@[element | element | ...]`
> - Count:
>   + Element prepended with `@` and a count marker.
>     - Optional: `@?element`
>     - Repetition (any number): `@*element`
> 	  - Repetition (1 or more): `@+element`
>     - Repetition (a till b): `@a-b*element`
> - List:
>   + `@^delimiter` followed by a count marker.
>   + For multicharacter delimiters, use `@^(delimiter)` instead.
>   + `@^;+[@thing]` is equivalent to `@thing @*[; @thing]`

2. Both `[]` and `()` brackets can be used interchangeably.  
3. The symbols `@`,`\`,`|` need to be escaped using a `\` in text.
4. All other parts should be considered literal text.
5. All words have implied seperating whitespace.
6. Count can be prefixed to:
	- Text: `@?text`
	- Placeholders: `@?@class`
	- Groups & Sets: `@?@[...]`
	  + Groups & Sets can leave out the second `@`

## Warnings
- Due to the way VSCode TextMate highlighting works, the closing bracket of groups/lists/sets may incorrectly match to a preconnected string.

## Future Considerations
- Possibly customize delimiter using a master rule `delimiter = "@";`
- Possibly add whitespace sensitivity alternative. This could be moving more towards ABNF, though delimiters could also be used to refer to whitespace tokens like `@tab`.