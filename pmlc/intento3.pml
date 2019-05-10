bool wantp = false
bool wantq = false

active proctype P(){
	do
		:: true ->
				printf("P%d non critical section 1 \n", _pid)
				printf("P%d non critical section 2\n", _pid)
				printf("P%d non critical section 3\n", _pid)
				
				wantp = true
				(!wantq) ->
				printf("P%d CRITICAL section 1\n", _pid)
				printf("P%d CRITICAL section 2\n", _pid)
				printf("P%d CRITICAL section 3\n", _pid)
				wantp = false
		od
}


active proctype Q(){
	do
		:: true ->
				printf("P%d non critical section 1\n", _pid)
				printf("P%d non critical section 2\n", _pid)
				printf("P%d non critical section 3\n", _pid)
				
				wantq = true
				(!wantp) ->
				printf("P%d CRITICAL section 1\n", _pid)
				printf("P%d CRITICAL section 2\n", _pid)
				printf("P%d CRITICAL section 3\n", _pid)
				wantq = false
		od
}