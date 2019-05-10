

int n = 0

proctype P(){
	int t
	int i= 0
	do
	:: i < 10 ->
		t = n
		n = t +1
		i++
	::else -> break
	od
}

proctype Q(){
	int t
	int i= 0
	do
	:: i < 10 ->
		t = n
		n = t +1
		i++
	::else -> break
	od
}

init { 
	atomic{
		run P()
		run Q()
	}
	(_nr_pr ==1) -> printf("n=%d \n", n)
}