import tile, map, engine
from terminal import getch
from illwill import ForegroundColor, BackgroundColor

type 
    Entity* = ref object of Tile
        hp*, atk*, def*: int

method move*(e: Entity, map: Map) {.base.} =
    quit("Entity movement to be declared")

method collide*(t1: Tile, t2: Tile) = 
    discard

# Here comes a little impostor from the map just so we can avoid circular imports

method get_entites*(map: Map): seq[Entity] {.base.} = 
    for t in map.tiles:
        if (t of Entity):
            result.add(Entity(t))

# ------------------------------------------------------------------------------------------------ #

type 
    Player* = ref object of Entity

method move*(e: Player, map: Map) =
    let key = getch()
    var next_pos: tuple[x, y: int] = (e.x, e.y)
    case key:
        of 'q':
            exitProc()            
        of 'w':
            next_pos = (e.x, e.y - 1)
        of 's':
            next_pos = (e.x, e.y + 1)
        of 'a':
            next_pos = (e.x - 1, e.y)
        of 'd':
            next_pos = (e.x + 1, e.y)
        else:
            discard
    for t in map.get_tiles_at(next_pos.x, next_pos.y):
        t.collide(e)

proc new_player*(x, y: int): Player = 
    return Player(x: x, y: y, c: "@", bright: true, fColor: fgWhite, bColor: bgBlack, hp: 10, atk: 10, def: 10)

# ------------------------------------------------------------------------------------------------ #