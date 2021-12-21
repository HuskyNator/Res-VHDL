# Adrian syntax notation (ASN)
A custom notation, inspired by ABNF.
It is designed to
- Reduce extensive `"` use.
- Simplify delimited lists.
---
## Notation
1. All special elements are denoted by a prefixed `@`:
> - Placeholders: `@name`
>   + All names are defined as `name = elements`.
> - Groups: `@[element element ...]`
> - Element from set: `@[element | element | ...]`
> - Count (Optional & Repetition):
> 	+ Optional: `@?element` (thus also `@?[group]`)
> 	+ Repetition (any number): `@*element`
> 	+ Repetition (1 or more): `@+element`
>   + Repetition (a till b): `@a-b*element`
> - List: `@^delimiter` followed by a repetition
>	+ `@^;+[@thing]` is equivalent to `@thing @*[; @thing]`
>   + For multicharacter delimiters, use `@^(text)` instead.

2. Both `[]` and `()` brackets can be used interchangeably.  
3. All other parts should be considered literal text.
4. Special symbols (`[ ] ( ) @ \`) need to be escaped using a `\` in text.
5. All words have implied seperating whitespace.

## Future Considerations
- Possibly customize delimiter using a master rule `delimiter = "@";`
- Possibly add whitespace sensitivity alternative. This could be moving more towards ABNF, though delimiters could also be used to refer to whitespace tokens like `@tab`.