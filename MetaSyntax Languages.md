# Examples
Note the addition of whitespace is implied in these examples.

### Extended Backus-Naur Form (EBNF):
```ebnf
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
```
@entity =
	entity @name is
		@?[generic (@^;*[@generic])]
		@?[port (@^;*[@port]);]
	end @?entity @?@name;

@generic = @name : @type @?[:= @default_value]

@port = @name : @porttype @type

@porttype = @[in | out | inout | buffer]
```

```VHDL
@?not @identifier @?[@[and | or | nor | ...] @identifier]
```

```VHDL
if @condition then
	@statements
@*[else if @condition then
	@statements
]@?[else
	@statements
]end if;
```

```VHDL
if (@condition) {
	@statements
} @*[@[elif|else if] (@condition) {
	@statements
}] @?[else {
	@statements
}]
```

```VHDL
if (@condition)
	@statement
@*[@[elif|else if] (@condition)
	@statement
] @?[else
	@statement
]
```
