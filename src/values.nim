from std/strformat import fmt
from math import sqrt

############################################################
# Value Variant Type Definition
# Value = Int i | Float f | Bool b | Char c
############################################################
type ValueKind = enum vI, vF, vB, vC
type Value* = object
    case kind: ValueKind:
    of vI: i: int
    of vF: f: float
    of vB: b: bool
    of vC: c: char


############################################################
# Constructors for the Value Type
############################################################
func newInt*(i: int): Value = Value(kind: vI, i: i)
func newFloat*(f: float): Value = Value(kind: vF, f: f)
func newBool*(b: bool): Value = Value(kind: vB, b: b)
func newChar*(c: char): Value = Value(kind: vC, c: c)


############################################################
# Predicates to check if a Value is of a certain kind
############################################################
func isInt*  (v: Value): bool = v.kind == vI
func isFloat*(v: Value): bool = v.kind == vF
func isBool* (v: Value): bool = v.kind == vB
func isChar* (v: Value): bool = v.kind == vC


############################################################
# String Representations
############################################################
# String representation of the Value object
func repr*(v: Value): string =
    case v.kind:
    of vI: fmt"Int({v.i})"
    of vF: fmt"Float({v.f})"
    of vB: fmt"Bool({v.b})"
    of vC: fmt"Char({v.c})"

# String representation of the value inside the Value object
func str*(v: Value): string =
    case v.kind:
    of vI: $v.i
    of vF: $v.f
    of vB: $v.b
    of vC: $v.c


############################################################
# Boolean Operation 
############################################################

# Boolean `and` operation
# && :: (Bool, Bool) -> Bool
func `&&`*(v, w: Value): Value =
    if v.isBool() and w.isBool():
        return newBool(v.b and w.b)

    raise newException(ValueError, "")

# Boolean `or` operation
# || :: (Bool, Bool) -> Bool
func `||`*(v, w: Value): Value =
    if v.isBool() and w.isBool():
        return newBool(v.b or w.b)

    raise newException(ValueError, "")

# Boolean negation operation
# ! :: Bool -> Bool
func `!`*(v: Value): Value =
    if v.isBool():
        return newBool(not v.b)

    raise newException(ValueError, "")


############################################################
# Number (Int and Float) Binary Operation 
############################################################

# Number add operation
# + :: (Int | Float , Int | Float) -> Int | Float
func `+`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newInt(v.i + w.i)
    if v.isInt() and w.isFloat():
        return newFloat(v.f + float(w.i))    
    if v.isFloat() and w.isInt():
        return newFloat(float(v.i) + w.f)
    if v.isFloat() and w.isFloat():
        return newFloat(v.f + w.f)

    raise newException(ValueError, "")

# Number subtraction operation
# - :: (Int | Float , Int | Float) -> Int | Float
func `-`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newInt(v.i - w.i)
    if v.isInt() and w.isFloat():
        return newFloat(v.f - float(w.i))    
    if v.isFloat() and w.isInt():
        return newFloat(float(v.i) - w.f)
    if v.isFloat() and w.isFloat():
        return newFloat(v.f - w.f)

    raise newException(ValueError, "")

# Number multiplication operation
# * :: (Int | Float , Int | Float) -> Int | Float
func `*`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newInt(v.i * w.i)
    if v.isInt() and w.isFloat():
        return newFloat(v.f * float(w.i))    
    if v.isFloat() and w.isInt():
        return newFloat(float(v.i) * w.f)
    if v.isFloat() and w.isFloat():
        return newFloat(v.f * w.f)

    raise newException(ValueError, "")

# Number division operation
# / :: (Int | Float , Int | Float) -> Int | Float
func `/`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newInt(int(v.i / w.i))
    if v.isInt() and w.isFloat():
        return newFloat(v.f / float(w.i))    
    if v.isFloat() and w.isInt():
        return newFloat(float(v.i) / w.f)
    if v.isFloat() and w.isFloat():
        return newFloat(v.f / w.f)

    raise newException(ValueError, "")

# Number mod operation
# % :: (Int, Int) -> Int
func `%`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newInt(v.i mod w.i)

    raise newException(ValueError, "")

# Number maximum operation
# max :: (Int | Float , Int | Float) -> Int | Float
func max*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newInt(max(v.i, w.i))
    if v.isInt() and w.isFloat():
        return newFloat(max(float(v.i), w.f))    
    if v.isFloat() and w.isInt():
        return newFloat(max(v.f, float(w.i)))
    if v.isFloat() and w.isFloat():
        return newFloat(max(v.f, w.f))

    raise newException(ValueError, "")

# Number minimum operation
# min :: (Int | Float , Int | Float) -> Int | Float
func min*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newInt(min(v.i, w.i))
    if v.isInt() and w.isFloat():
        return newFloat(min(float(v.i), w.f))    
    if v.isFloat() and w.isInt():
        return newFloat(min(v.f, float(w.i)))
    if v.isFloat() and w.isFloat():
        return newFloat(min(v.f, w.f))

    raise newException(ValueError, "")


############################################################
# Number (Int and Float) Unary Operation 
############################################################

# Number increment operation ( a+1 )
# inc :: Int | Float -> Int | Float
func inc*(v: Value): Value =
    if v.isInt():
        return newInt(v.i + 1)
    if v.isFloat():
        return newFloat(v.f + 1)

    raise newException(ValueError, "")

# Number decrement operation ( a-1 )
# dec :: Int | Float -> Int | Float
func dec*(v: Value): Value =
    if v.isInt():
        return newInt(v.i - 1)
    if v.isFloat():
        return newFloat(v.f - 1)

    raise newException(ValueError, "")

# Number simetric operation ( -a )
# sim :: Int | Float -> Int | Float
func sim*(v: Value): Value =
    if v.isInt():
        return newInt(-v.i)
    if v.isFloat():
        return newFloat(-v.f)

    raise newException(ValueError, "")

# Number absolute value operation ( |a| )
# abs :: Int | Float -> Int | Float
func abs*(v: Value): Value =
    if v.isInt():
        return newInt(abs(v.i))
    if v.isFloat():
        return newFloat(abs(v.f))

    raise newException(ValueError, "")

# Number square root operation ( √a )
# sqrt :: Int | Float -> Float
func sqrt*(v: Value): Value =
    if v.isInt():
        return newFloat(sqrt(float(v.i)))
    if v.isFloat():
        return newFloat(sqrt(v.f))

    raise newException(ValueError, "")


############################################################
# Comparisson Operation 
############################################################

# Equality operation
# == :: (T, T) -> Bool
func `==`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newBool(v.i == w.i)
    if v.isFloat() and w.isFloat():
        return newBool(v.f == w.f)
    if v.isBool() and w.isBool():
        return newBool(v.b == w.b)
    if v.isChar() and w.isChar():
        return newBool(v.c == w.c)

    raise newException(ValueError, "")

# Difference operation
# != :: (T, T) -> Bool
func `!=`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newBool(v.i != w.i)
    if v.isFloat() and w.isFloat():
        return newBool(v.f != w.f)
    if v.isBool() and w.isBool():
        return newBool(v.b != w.b)
    if v.isChar() and w.isChar():
        return newBool(v.c != w.c)

    raise newException(ValueError, "")

# Less operation
# < :: (Int | Float, Int | Float) -> Bool
func `<`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newBool(v.i < w.i)
    if v.isInt() and w.isFloat():
        return newBool(float(v.i) < w.f)
    if v.isFloat() and w.isInt():
        return newBool(v.f < float(w.f))
    if v.isFloat() and w.isFloat():
        return newBool(v.f < w.f)

    raise newException(ValueError, "")

# Lesser or equal operation
# <= :: (Int | Float, Int | Float) -> Bool
func `<=`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newBool(v.i <= w.i)
    if v.isInt() and w.isFloat():
        return newBool(float(v.i) <= w.f)
    if v.isFloat() and w.isInt():
        return newBool(v.f <= float(w.f))
    if v.isFloat() and w.isFloat():
        return newBool(v.f <= w.f)

    raise newException(ValueError, "")

# Greater operation
# > :: (Int | Float, Int | Float) -> Bool
func `>`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newBool(v.i > w.i)
    if v.isInt() and w.isFloat():
        return newBool(float(v.i) > w.f)
    if v.isFloat() and w.isInt():
        return newBool(v.f > float(w.f))
    if v.isFloat() and w.isFloat():
        return newBool(v.f > w.f)

    raise newException(ValueError, "")

# Greater or equal operation
# >= :: (Int | Float, Int | Float) -> Bool
func `>=`*(v, w: Value): Value =
    if v.isInt() and w.isInt():
        return newBool(v.i >= w.i)
    if v.isInt() and w.isFloat():
        return newBool(float(v.i) >= w.f)
    if v.isFloat() and w.isInt():
        return newBool(v.f >= float(w.f))
    if v.isFloat() and w.isFloat():
        return newBool(v.f >= w.f)

    raise newException(ValueError, "")

