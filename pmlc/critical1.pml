int val = 1
int cont = 0

proctype P() {
    int i = 0
    do
    :: i < 10 ->
        printf("Seccion no crítica P 1\n")
        printf("Seccion no crítica P 2\n")
        printf("Seccion no crítica P 3\n")
        (val == 1) ->
            cont++
            printf("Sección crítica P 1\n")
            printf("Sección crítica P 2\n")
            printf("Sección crítica P 3\n")
            assert(cont == 1)
            cont--
            val = 2
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
        (val == 2) ->
            cont++
            printf("Sección crítica Q 1\n")
            printf("Sección crítica Q 2\n")
            printf("Sección crítica Q 3\n")
            assert(cont == 1)
            cont--
            val = 1
        j++
    :: else -> skip
    od
}


init {
    atomic {
        run P()
        run Q()
    }
    (_nr_pr == 1) -> printf("no prob")
}