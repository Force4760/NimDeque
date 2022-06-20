import std/strutils, std/sequtils, sugar


# Check if a give string could represent an integer
# Integers follow this regex -?[0-9]+
# ex: -123 | 4567 | 8 | 90
func isInt*(s: string): bool =
    # Ints may start with a minus sign
    let str = ( 
        if s.startsWith("-"): s[1..^1]
        else: s
    )

    # Every char in an int must be a digit
    for i in str:
        if i notin {'0'..'9'}:
            return false

    # str can't be empty
    return len(str) != 0


# Check if a give string could represent a float
# Integers follow this regex -?[0-9]*[0-9]*
# ex: -012. | 34. | 56.7 | .8 | -.9
func isFloat*(s: string): bool =
    # Floats may start with a minus sign
    let str = ( 
        if s.startsWith("-"): s[1..^1]
        else: s
    )

    # Every char in a float must be a dot or a digit
    for i in str:
        if i notin {'0'..'9', '.'}:
            return false

    # Floats must have exactly 1 dot
    return str.count('.') == 1


# Check if a give string could represent an character
# Integers follow this regex '.'
# ex: '-' | '#' | 'o'
func isChar*(s: string): bool =
    # Chars must have length 3 (2 quotes + 1 character)
    if len(s) != 3:
        return false

    # Chars must start and end with a quote
    return s[0] == '\'' and s[2] == '\''


# Split a string in words divided by White Space
# WS = {'\n', '\t', '\r', ' '}
func splitWS*(str: string): seq[string] =
    str.replace('\n', ' ')        # Remove new lines
       .replace('\t', ' ')        # Remove tabs
       .replace('\r', ' ')        # Remove returns
       .split(' ')                # Split in every White Space
       .filter((x) => len(x) > 0) # Remove empty characters