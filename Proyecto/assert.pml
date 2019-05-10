proctype division() {
    int num = 10
    int d = 3
    int c = 0
    int r = num

    do
    :: r > d ->
        r = r - d
        c++
    :: else -> break
    od

    printf("%d %d %d %d\n", num, d, r, c)
    assert(num / d == c)
}

proctype ifs() {
    int a = 2;
    int b = 2;
    int max;
    if
    :: (a >= b)
        max = a
    :: (a >= b)
        max = b + 1
    fi
    printf("%d\n", max)
    assert(a >= b -> max == a : max == b)
}

/*int n = 0
proctype p() {
    int i
    int t
    for(i : 1..10) {
        t = n
        n = t + 1
    }
}

init {
    atomic {
        run p()
        run p()
    }
    (_nr_pr == 1) -> printf("n = %d\n", n)
}*/

/*
int c = 0
int turn = 1
_nr_pr
int num = 2
active proctype p() {
    int i = 0
    do
    :: i < 10
    if
    :: turn == 1 ->
    printf("No critical section: %d\n", 1)
    i++
    c++
    printf("Critical section: %d\n", 1)
    turn = 2
    c--
    assert(c <= 1)
    :: else -> skip
    fi
    :: else -> break
    od
    num--
}

active proctype q() {
    int i = 0
    do
    :: i < 10
        if
        :: turn == 2 -> {
            printf("No critical section: %d\n", 2)
            i++
            c++
            printf("Critical section: %d\n", 2)
            turn = 1
            c--
            assert(c <= 1)
        }
        :: else -> skip
        fi
    :: else -> break
    od
}*/

int nq = 0
int np = 0
active proctype p() {
    int i = 0
    do
    :: i < 10 ->
        np = nq + 1
        printf("Non critical section in P\n")
        if
        :: (nq == 0 || np <= nq) ->
            printf("Critical section in P\n")
            np = 0
            i++
        :: else -> 
            printf("Await P, %d, %d\n", np, nq)
        fi
    :: else -> break
    od
}

active proctype q() {
    int i = 0
    do
    :: i < 10 ->
        nq = np + 1
        printf("Non critical section in Q\n")
        if
        :: (np == 0 || nq < np) ->
            printf("Critical section in Q\n")
            nq = 0
            i++
        :: else ->
            printf("Await Q, %d, %d\n", np, nq)
        fi
    :: else -> break
    od
}
