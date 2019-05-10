active proctype P() {
    byte a = 5
    byte b = 5
    byte max;

    if
    :: a >= b -> max = a
    :: b >= a -> max = b + 1
    fi

    assert(a >= b -> max == a : max == b)
}
