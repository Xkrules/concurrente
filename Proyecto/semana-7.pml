#define wait(s) atomic { s > 0 -> s-- }
#define signal(s) s++
#define N_PHI 5
#define THINKING 0
#define HUNGRY 1
#define EATING 2
int state[N_PHI] = {THINKING, THINKING, THINKING, THINKING, THINKING};
int sem[N_PHI] = {0, 0, 0, 0, 0};
int mut = 1

proctype test(int i) {
    int left = ((i + N_PHI) - 1) % N_PHI
    int right = (i + 1) % N_PHI
    //printf("Phi %d is testing\n", i)
    if
    :: state[i] == HUNGRY && state[left] != EATING && state[right] != EATING ->
        printf("Phi %d is eating\n", i)
        state[i] = EATING
        signal(sem[i])
    :: else -> skip
    fi
}

active proctype get_fork() {
    int i;
    for(i : 0..(N_PHI-1)){
        wait(mut)
        state[i] = HUNGRY
        printf("Phi %d is hungry\n", i)
        atomic {
            run test(i)
        }  
        signal(mut)
        wait(sem[i])
    }
}

active proctype put_fork() {
    int i;
    for(i : 0..(N_PHI-1)){
        wait(mut)
        state[i] = THINKING
        int left = ((i + N_PHI) - 1) % N_PHI
        int right = (i + 1) % N_PHI
        printf("Phi %d is thinking\n", i)
        atomic {
            run test(left)
            run test(right)
        }  
        signal(mut)
    }
}
