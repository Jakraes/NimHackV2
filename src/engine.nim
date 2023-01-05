import illwill, tile

var tb*: TerminalBuffer

proc exitProc*() {.noconv.} =
    illwillDeinit()
    showCursor()
    quit(0)

proc init*() =
    illwillInit(fullscreen = true)
    setControlCHook(exitProc)
    hideCursor()

    tb = newTerminalBuffer(terminalWidth(), terminalHeight())

proc put_tile*(t: Tile) =
    tb.setBackgroundColor(t.bColor)
    tb.setForegroundColor(t.fColor, bright = t.bright)
    tb.write(t.x, t.y, t.c)

proc display*() =
    tb.display()