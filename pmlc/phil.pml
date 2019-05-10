/*
NAME
  phil : dining philosophers problem

DESCRIPTION
  Classical example of multi-process synchronization problem by E. Dijkstra.

AUTHER
  Fumiyoshi Kobayashi

HISTORY
  2008/08/20(Wed) Added SOL option
  2008/08/19(Tue) New

Copyright(C) 2008 Fumiyoshi Kobayashi, Ueda Laboratory.
*/

#ifndef  N
#define  N  5
#endif

bit fork[N];
byte nr_eat;

init {
  atomic {
    byte i = 0;

#if (SOL == 1)
    do
    :: i < N-1 -> run Philosopher(i); i++;
    :: else    -> run Phil_another(i); break;
    od;
#else
#if (SOL == 2)
    do
    :: i < N-1 -> run Philosopher(i); i++;
    :: else    -> run Phil_restart(i); break;
    od;
#else /* (SOL == 0 || SOL == 'invalid') */
    do
    :: i < N -> run Philosopher(i); i++;
    :: else  -> break;
    od;
#endif /* SOL == 2 */
#endif /* SOL == 1 */
  }
}

proctype Philosopher(byte id) {
Think:
  atomic { fork[id] == 0; -> fork[id] = 1; }
One:
  atomic { fork[(id + 1)%N] == 0 -> fork[(id + 1)%N] = 1; nr_eat++; };
Eat:
  d_step { nr_eat--; fork[(id + 1)%N] = 0; }
  fork[id] = 0;
  goto Think;
}

proctype Phil_another(byte id) {
Think:
  atomic { fork[(id + 1)%N] == 0 -> fork[(id + 1)%N] = 1; };
One:
  atomic { fork[id] == 0; -> fork[id] = 1; nr_eat++; }
Eat:
  d_step { nr_eat--; fork[id] = 0; }
  fork[(id + 1)%N] = 0;
  goto Think;
}

proctype Phil_restart(byte id) {
Think:
  atomic { fork[id] == 0; -> fork[id] = 1; }
One:
  if
  :: atomic { fork[(id + 1)%N] == 0 -> fork[(id + 1)%N] = 1; nr_eat++; };
  :: atomic { fork[(id + 1)%N] != 0 -> fork[id] = 0; } goto Think;
  fi;
Eat:
  d_step { nr_eat--; fork[(id + 1)%N] = 0; }
  fork[id] = 0;
  goto Think;
}
