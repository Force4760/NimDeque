from std/strformat import fmt


type Modifier* = enum 
    MLeft,  # operate on the left end of the deque
    MRight, # operate on the right end of the deque
    MLabel, # used as an "anchor" in the program 
    MNone 


type TokenKind* = enum
    KAdd,   KSub,   KMul,  KDiv,  KMod,  KMax, KMin,  # Binary number ops
    KDrop,  KDup,   KDup2, KOver, KSwap, KRot, KMove, # Deque Operations
    KEq,    KNeq,   KLeq,  KGeq,  KLess, KGreat,      # Predicates
    KInt,   KFloat, KTrue, KFalse, KChar,             # Data Types
    KInc,   KDec,   KSim,  KAbs,   KSqrt,             # Unary number ops
    KLabel, KJump,  KJumpIf,                          # Control Flow
    KAnd,   KOr,    KNot,                             # Boolean ops
    KPrint, KInput,                                   # IO
    KEnd,                                             # Others


# Token Object
type Token* = object
    kind:      TokenKind # Kind of token
    modifier:  Modifier  # Modifier to the token operation
    val:       string    # Literal value from the src program


# Constructor for the Token kind
func newToken*(k: TokenKind, m: Modifier, v: string): Token =
    Token(kind: k, modifier: m, val: v)


# String representation for the token type
func `$`*(t: Token): string =
    fmt"Token({t.kind}, {t.modifier}, {t.val})"