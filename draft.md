
```
interface Inter<T, uint L>
	if(L > 0) {
	in:
		T[L] a, b;
		bit[selectorSize(L)] selector;
	out bit[2] res;

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

circuit Circ: Inter<bit, 1> {


	main{

	}


}
```

---

