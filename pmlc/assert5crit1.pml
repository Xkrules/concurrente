#define NUM_PROCS 2

byte turn = 0
byte critical = 0

active[NUM_PROCS] proctype P() {
    do
    :: true ->
        (turn == _pid) ->
        critical++
        assert(critical <= 1)
        critical--
        turn = (_pid + 1) % NUM_PROCS
    od
}
