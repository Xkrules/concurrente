active proctype P() {
    byte dividiendo = 100
    byte divisor = 13
    byte cociente = 0
    byte residuo = dividiendo
    
    do
    :: residuo > divisor ->
        cociente++
        residuo = residuo - divisor
    :: else -> break
    od

    assert(cociente * divisor + residuo == dividiendo)
}