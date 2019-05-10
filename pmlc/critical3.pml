int val = 1
int cont = 0
bool wantp = false
bool wantq = false

proctype P() {
    int i = 0
    do
    :: i < 10 ->
        printf("Seccion no crítica P 1\n")
        printf("Seccion no crítica P 2\n")
        printf("Seccion no crítica P 3\n")
        (wantq == false) ->
            wantp = true
            cont++
            printf("Sección crítica P 1\n")
            printf("Sección crítica P 2\n")
            printf("Sección crítica P 3\n")
            assert(cont == 1)
            cont--
            wantp = false
        i++
    :: else -> skip
    od
}

proctype Q() {
    int j = 0
    do
    :: j < 10 ->
        printf("Seccion no crítica Q 1\n")
        printf("Seccion no crítica Q 2\n")
        printf("Seccion no crítica Q 3\n")
        (wantp == false) ->
            wantq = true
            cont++
            printf("Sección crítica Q 1\n")
            printf("Sección crítica Q 2\n")
            printf("Sección crítica Q 3\n")
            assert(cont == 1)
            cont--
            wantq = false
        j++
    :: else -> skip
    od
}


init {
    atomic {
        run P()
        run Q()
    }
}