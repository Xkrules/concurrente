/*
byte n = 0

proctype P(){
    byte t
    byte i
    for ( i : 1..10){
        t = n
        n = t + 1
    }
}

init
{
    atomic{
        run P()
        run P()
    }
    (_nr_pr==1)-> printf("n=%d\n",n)
    assert(n>2)
}
*/

/*
#define NUM_PROCS 2

byte tunr = 0
byte critical = 0
bool want[NUM_PROCS]
active[NUM_PROCS] proctype P(){
    pid qpid = (_pid + 1) % NUM_PROCS
    do
    ::true ->
        (!want[qpid])->
        want[_pid] = true
        critical++
        assert(critical <=1)
        critical--
        want[_pid] = false
    od
}
*/



/*

/* Copyright (C) 2006 M. Ben-Ari. See copyright.txt */
/* 
   Bakery algorithm with atomic choice of ticket numbers
   Verify Safety with ticket numbers limited to 20
   and arguments -s -ll400 -ls200 -lt6000
*/
byte	number[3] = 0;
byte  critical  = 0;

active [3] proctype p() {
	byte max, I;
	do
    ::
    d_step {  
      max = 0;
      I = 0;
      do
      :: I > 2 -> break
      :: else ->
         if 
         :: number[I] > max -> max = number[I] 
         :: else
         fi;
         I++
      od;
      if :: max > 20 -> goto stop :: else fi;
      number[_pid] = 1 + max;
    }
    I = 0;
    do
    :: I > 2 -> break
    :: else ->
        if 
        :: I != _pid ->
            (number[I] == 0) || 
            (number[_pid] < number[I]) ||
            ((number[_pid] == number[I]) && (_pid < I))
        :: else
        fi;
        I++
    od;
    printf("%d in CS\n", _pid);
    critical++;
    assert (critical == 1);
    critical--;
    number[_pid] = 0;
  od;
stop: skip
}

*/


byte nq
byte np

proctype P(){
    Not Critical section

    np = nq +1
    
    nq = 0  np <= nq

    Critical sectionnp = 0

    np = 0
 
}

proctype Q(){
    Not Critical section

    nq = np +1
    
    nq = 0  nq < np

    Critical sectionnp = 0
    
    nq = 0
}


