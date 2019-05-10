#define NUM_PROCS 2

byte critical = 0
bool want[NUM_PROCS]

active[NUM_PROCS] proctype P() {
    pid qpid = (_pid + 1) % NUM_PROCS
    do
    :: true ->
        (!want[qpid]) ->
        want[_pid] = true
        critical++
        assert(critical <= 1)
        critical--
        want[_pid] = false
    od
}
