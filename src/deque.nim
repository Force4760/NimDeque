import lexer

when isMainModule:
  while true:
    stdout.write(">>> ")
    let prog = stdin.readLine()

    echo tokenize(prog)

