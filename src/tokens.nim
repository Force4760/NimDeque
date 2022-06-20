from std/strformat import fmt

type Direction = enum 
    Left,  # operate on the left end of the deque
    Right, # operate on the right end of the deque
    None   # for operations that don't use the deque 

type TokenKind* = enum
    KAdd,   KSub,  KMul,  KDiv,  KMod,  KMax, KMin,  # Binary number ops
    KDrop,  KDup,  KDup2, KOver, KSwap, KRot, KMove, # Deque Operations
    KEq,    KNeq,  KLeq,  KGeq,  KLess, KGreat,      # Predicates
    KInc,   KDec,  KSim,  KAbs,  KSqrt,              # Unary number ops
    KInt,   Float, KBool, KChar,                     # Data Types
    KLabel, KJump, KJumpIf,                          # Control Flow
    KAnd,   KOr,   KNot,                             # Boolean ops
    KPrint, KInput,                                  # IO
    KEnd,                                            # Others

# Token Object
type Token* = object
    kind: TokenKind # Kind of token
    dir: Direction  # Direction of the deque where the Token may act
    val: string     # Literal value from the src program

# String representation for the token type
func `$`*(t: Token): string =
    fmt"Token({t.kind}, {t.dir}, {t.val})"