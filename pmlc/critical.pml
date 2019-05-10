int val = 1

proctype P() {
    int i = 0
    do
    :: i < 10 ->
        printf("Seccion no crítica P 1\n")
        printf("Seccion no crítica P 2\n")
        printf("Seccion no crítica P 3\n")
        (val == 1) ->
            printf("Sección crítica P 1\n")
            printf("Sección crítica P 2\n")
            printf("Sección crítica P 3\n")
            val = 1
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
        (val == 1) ->
            printf("Sección crítica Q 1\n")
            printf("Sección crítica Q 2\n")
            printf("Sección crítica Q 3\n")
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
}