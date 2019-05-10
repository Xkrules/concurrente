//productores y consumidores 41
#define wait(s) atomic{s > 0 -> s-- }
#define signal(s) s++
#define MAX 1000

byte notEmpty = 0
byte mutex = 1

int buffer[MAX]
int pos = 0


active proctype Producer()
{
    int event
    int c=0
    do
    ::
        event = _pid * 1000 + c
        c++
        wait(mutex)
        buffer[pos] = event
        pos++
        signal(mutex)
        signal(notEmpty)
    od
}

active proctype Consumer()
{
    int event
    do
    ::
        wait(notEmpty)
        wait(mutex)
        pos--
        event = buffer[pos]
        signal(mutex)
        printf("EH%d handling %d\n",_pid,event)
    od
}