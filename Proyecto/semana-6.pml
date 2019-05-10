/*#define wait(s) atomic { s > 0 -> s-- }
#define signal(s) s++

#define NUM_PROCS 2

byte s = 1
byte critical = 0

active[NUM_PROCS] proctype P() {
    do
    :: 
        wait(s);
        critical++
        assert critical <= 1
        critical--
        signal(s);
    od
}*/

#define N 10
int arr[N] = {10, 19, 18, 0, 16, 5, 20, 13, 2, 1}
byte s[2] = {0, 0}

proctype split(int n) {
    atomic {
        run sort(0, n / 2 - 1, 0);
        run sort(n / 2, n - 1, 1);
        run merge();
    }
}

proctype sort(int l; int r; int idx_s) {
    int i;
    int k;
    for(i : l..r) {
        int d = arr[i];
        for(k : i+1..r) {
            if
            :: (arr[k] < d) ->
                int t = arr[k];
                arr[k] = d;
                d = t;
            :: else -> skip
            fi
        }
        arr[i] = d;
    }
    s[idx_s]++
}

proctype merge() {
    do
    :: s[0] == 1 && s[1] == 1 ->
        int t[N];
        int i1 = 0, i2 = N / 2
        int i = 0
        do
        :: (i1 < N / 2 || i2 < N) ->
            if
            :: i1 < N / 2 && i2 < N ->
                if
                :: arr[i1] < arr[i2] ->
                    t[i] = arr[i1]
                    i1++
                :: else ->
                    t[i] = arr[i2]
                    i2++
                fi
            :: i1 < N / 2 && i2 >= N ->
                t[i] = arr[i1]
                i1++
            :: i1 >= N / 2 && i2 < N ->
                t[i] = arr[i2]
                i2++
            :: else -> break
            fi
            i++
        :: else ->
            break
        od
        int m = N;
        for(i : 0..m-1) {
            arr[i] = t[i]
            printf("--%d\n", arr[i])
        }
        break
    :: else -> skip
    od
    printf("Sorted\n")
}

init {
    atomic{
        run split(N)
    }
}