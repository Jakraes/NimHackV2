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
    tb.setBackgroundColor(t.get_bColor)
    tb.setForegroundColor(t.get_fColor, bright = t.is_bright)
    tb.write(t.get_x, t.get_y, t.get_char)

proc display*() =
    tb.display()