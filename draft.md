## VHDL
_TODO_

## Res

```
type Clock {
	bit value;
	uint count;
}

circuit ClockC<time period> {
	inout Clock clock = Clock(value=1, count=0);

	process {
		wait for period;
		clock.value = not clock.value;
	}
}
```
```
interface Inter<T, uint L>
	if(L > 0) {
	in:
		T[L] a, b;
		bit[selectorSize(L)] selector;
		Clock clock;
	out T[2] res;

	uint selectorSize(L){
		uint power = 1
		uint count = 0;
		while(power < L){
			power = power << 1; // * 2
			count += 1;
		}
		return count;
	}
}

circuit Circ: Inter<bit, 2> {
	bit[2] selected;

	main { // Concurrent
		uint index = uint(selector); // Local signal
		selected[0] = a[index];
		selected[1] = b[index];
	}

	process A(rising(clock.value)) { // Sequential
		res[0] = selected[0];
	}

	process B(falling(clock)) {
		res[1] = not selected[1];
		string temp = string(res);
		println(`B = {} at {} (clock#{})`, temp, Time.current, clock.count);
	}
}
```
```
test circuit CircC_TB {
	bit clock;
	bit ares, bres;
	ClockC clockc = ClockC<5ns>(clock);
	Circ tested = Circ();

	main {
		// Out ports don't introduce delta time.
		ares = tested.res[0];
		bres = tested.res[1];
	}

	process {
		for(uint i = 0; i < 2**2-1; i++){
			bit[2] bits = bits(i, 2);
			tested.a = bits;
			tested.b = not bits;

			wait rising(clock);
			assert(ares == not bres);
		}
		finish();
	}
}
```
