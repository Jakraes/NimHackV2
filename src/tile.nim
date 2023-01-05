from illwill import ForegroundColor, BackgroundColor

type 
    Tile* = ref object of RootObj
        x*, y*: int
        c*: string
        bright*: bool
        fColor*: ForegroundColor
        bColor*: BackgroundColor

method collide*(t1: Tile, t2: Tile) {.base.} = 
    quit("Tile collision to be declared")

# ------------------------------------------------------------------------------------------------ #

type
    Wall* = ref object of Tile
    
proc new_wall*(x, y: int): Wall =
    return Wall(x: x, y: y, c: "#", bright: true, fColor: fgBlack, bColor: bgBlack)

method collide*(t1: Wall, t2: Tile) =
    discard

# ------------------------------------------------------------------------------------------------ #

type
    Floor* = ref object of Tile

proc new_floor*(x, y: int): Floor =
    return Floor(x: x, y: y, c: ".", bright: false, fColor: fgWhite, bColor: bgBlack)

method collide*(t1: Floor, t2: Tile) =
    t2.x = t1.x
    t2.y = t1.y