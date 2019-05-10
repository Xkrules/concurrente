int c = 1

active proctype p() {
    int i = 0;
    do
    :: i < 10 ->
        printf("Seccion critica 1, i: %d\n", i)
        (c == 1) ->
            i++
            c = 2
            printf("Seccion no critica 1, i: %d\n", i)
    :: else -> break
    od
}

active proctype q() {
    int i = 0;
    do
    :: i < 10 ->
        printf("Seccion critica 2, i: %d\n", i)
        (c == 2) ->
            i++
            c = 1
            printf("Seccion no critica 2, i: %d\n", i)
    :: else -> break
    od
}