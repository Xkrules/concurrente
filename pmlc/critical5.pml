int np = 0
int nq = 0
int cont = 0

proctype P() {
    int i = 0
    do
    :: i < 10 ->
        printf("Seccion no crítica P 1\n")
        printf("Seccion no crítica P 2\n")
        printf("Seccion no crítica P 3\n")
        np = nq + 1
        (nq == 0 || np <= nq) ->
            cont++
            printf("Sección crítica P 1\n")
            printf("Sección crítica P 2\n")
            printf("Sección crítica P 3\n")
            assert(cont == 1)
            cont--
            np = 0
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
        nq = np + 1
        (np == 0 || nq < np) ->
            cont++
            printf("Sección crítica Q 1\n")
            printf("Sección crítica Q 2\n")
            printf("Sección crítica Q 3\n")
            assert(cont == 1)
            cont--
            nq = 0
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