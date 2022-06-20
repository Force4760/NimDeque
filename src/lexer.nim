import std/strutils, sugar
import tokens, helpers


# Get the modifier applied to the token
# [val -> Left
# val] -> Right
# val: -> Label
# ____ -> None
func getMod(val: string): Modifier =
    if val.startsWith("["):
        return MLeft
    if val.endsWith("]"):
        return MRight
    if val.endsWith(":"):
        return MLabel
    return MNone


# Get the Kind of Token assossiated with the provided value
# val should have modifier character ('[', ']', ':') removed
func getKind(val: string): TokenKind =
    case val:
    of "add": KAdd
    of "sub": KSub
    of "mul": KMul
    of "div": KDiv
    of "mod": KMod
    of "max": KMax
    of "min": KMin

    of "eq": KEq
    of "neq": KNeq
    of "less": KLess
    of "leq": KLeq
    of "great": KGreat
    of "geq": KGeq

    of "and": KAnd
    of "or": KOr
    of "not": KNot

    of "inc": KInc
    of "dec": KDec
    of "sim": KSim
    of "abs": KAbs
    of "sqrt": KSqrt

    of "drop": KDrop
    of "dup": KDup
    of "dup2": KDup2
    of "over": KOver
    of "swap": KSwap
    of "rot": KRot
    of "move": KMove

    of "jmp": KJump
    of "jmpif": KJumpIf
    of "end": KEnd
    of "print": KPrint
    of "input": KInput

    of "true": KTrue
    of "false": KFalse
    else:
        if isChar(val): KChar
        elif isInt(val): KInt
        elif isFloat(val): KFloat
        else:
            raise newException(ValueError, "")


# Get the token representation of a single values
func getToken(val: string): Token =
    # Left
    if val.startsWith("["):
        let value = val[1..^1] # remove [
        let kind = getKind(value)
        return newToken(kind, MLeft, value)

    # Right
    if val.endsWith("]"): # RIGHT
        let value = val[0..^2] # remove ]
        let kind = getKind(value)
        return newToken(kind, MRight, value)
    
    # Label
    if val.endsWith(":"):
        let value = val[0..^2] # remove :
        return newToken(KLabel, MLabel, value)

    raise newException(ValueError, "")


# Convert the input sting into a sequence of tokens
func tokenize*(input: string): seq[Token] =
    let program = splitWS(input)
    
    return collect: 
        for word in program: getToken(word)