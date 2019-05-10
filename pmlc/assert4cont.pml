byte n = 0

proctype P() {
    byte t
    byte i
    for (i : 1..10) {
        t = n
        n = t + 1
    }
}

init {
    atomic {
        run P()
        run P()
    }
    (_nr_pr == 1) -> printf("n = %d\n", n)
    assert(n>2)
}
