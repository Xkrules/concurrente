#define wait(s) atomic {s>0 -> s--}
#define signal(s) s++

#define NUM_PROCS 2

byte s=1

active [NUM_PROCS] proctype P(){
    do
    ::  printf("P%d NCS 1\n", _pid)
        printf("P%d NCS 2\n", _pid)
        printf("P%d NCS 3\n", _pid)
        wait(s)
        printf("P%d CRITICAL 1\n", _pid)
        printf("P%d CRITICAL 2\n", _pid)
        printf("P%d CRITICAL 3\n", _pid)
        Signal(s)
    od


}