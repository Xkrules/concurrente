#define NUM_PROCS 2

bool want[NUM_PROCS]

active[NUM_PROCS] proctype P() {
    pid qpid = (_pid + 1) % NUM_PROCS
    do
    :: true ->
        want[_pid] = true
        (!want[qpid]) ->
        want[_pid] = false
    od
}
