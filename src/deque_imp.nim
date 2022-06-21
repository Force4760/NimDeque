import std/deques
import values


# Check if the Deque is Empty
# | 1 | 2 | 3 | -> false
# |   |         -> true
proc isEmpty*(d: var Deque[Value]): bool =
    return len(d) == 0


# Push a new value to the Deque
# isLeft is used to control the side where the value is pushed
# push(X, true)  -> | X | 1 | 2 | 3 |
# push(X, false) -> | 1 | 2 | 3 | X |
proc push*(d: var Deque[Value], val: Value, isLeft: bool) =
    if isLeft:
        d.addFirst(val)
    else:
        d.addLast(val)


# Pop the value from the Deque
# isLeft is used to control the side where the value is poped
# pop(true)  ->  (X)  + | 1 | 2 | 3 |
# pop(false) -> | 1 | 2 | 3 | +  (X)
proc pop*(d: var Deque[Value], isLeft: bool): Value =
    # Can't pop on an empty deque
    if d.isEmpty():
        raise newException(ValueError, "")
    
    if isLeft:
        return d.popFirst()
    else:
        return d.popLast()

# Peek the value from the Deque (return it without poping)
# isLeft is used to control the side where the value is poped
# peek(true)  -> | X | 1 | 2 | 3 | + (X)
# peek(false) -> | 1 | 2 | 3 | X | + (X)
proc peek*(d: var Deque[Value], isLeft: bool): Value =
    # Can't pop on an empty deque
    if d.isEmpty():
        raise newException(ValueError, "")
    
    if isLeft:
        return d.popFirst()
    else:
        return d.popLast()