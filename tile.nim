from illwill import ForegroundColor, BackgroundColor

type 
    Tile* = ref object of RootObj
        x*, y*: int
        c*: string
        bright*: bool
        fg*: ForegroundColor
        bg*: BackgroundColor

method get_x*(t: Tile): int {.base.} =
    return t.x

method set_x*(t: Tile, x: int) {.base.} =
    t.x = x

method get_y*(t: Tile): int {.base.} =
    return t.y

method set_y*(t: Tile, y: int) {.base.} =
    t.y = y

method get_char*(t: Tile): string {.base.} =
    return t.c

method is_bright*(t: Tile): bool {.base.} =
    return t.bright

method get_fColor*(t: Tile): ForegroundColor {.base.} =
    return t.fg

method get_bColor*(t: Tile): BackgroundColor {.base.} =
    return t.bg

method collide*(t1: Tile, t2: Tile) {.base.} = 
    quit("Tile collision to be declared")

# ------------------------------------------------------------------------------------------------ #

type
    Wall* = ref object of Tile
    
method collide*(t1: Wall, t2: Tile) =
    discard

proc new_wall*(x, y: int): Wall =
    return Wall(x: x, y: y, c: "#", bright: true, fg: fgBlack, bg: bgBlack)

# ------------------------------------------------------------------------------------------------ #

type
    Floor* = ref object of Tile
    
method collide*(t1: Floor, t2: Tile) =
    t2.set_x(t1.get_x)
    t2.set_y(t1.get_y)

proc new_floor*(x, y: int): Floor =
    return Floor(x: x, y: y, c: ".", bright: false, fg: fgWhite, bg: bgBlack)