import tile, std/random, std/math

const world_size*: int = 30
const room_amount_min: int = 3
const room_amount_max: int = 6
const room_size_min: int = 3
const room_size_max: int = 6

type
    Map* = ref object of RootObj
        tiles*: seq[Tile]
        size*: int

method get_tiles_at*(map: Map, x, y: int): seq[Tile] {.base.} = 
    var tiles: seq[Tile]
    for t in map.tiles:
        if t.x == x and t.y == y:
            tiles.add(t)
    return tiles

method remove_tile*(map: Map, t: Tile) {.base.} = 
    map.tiles.del(map.tiles.find(t))

method add_tile*(map: Map, t: Tile) {.base.} =
    map.tiles.add(t)



# ------------------------------------------------------------------------------------------------ #

proc generate_empty_map(): Map =
    result = Map(tiles: @[], size: world_size)
    for y in 0..<world_size:
        for x in 0..<world_size:
            result.tiles.add(new_wall(x, y))

proc generate_rooms(map: var Map) = 
    var 
        room_amount: int = rand(room_amount_min..room_amount_max)
        rooms: seq[tuple[x, y: int]]
    for i in 0..<room_amount:
        var room_size_x, room_size_y, room_x, room_y: int
        while true:
            var done: bool = true
            room_size_x = rand(room_size_min..room_size_max)
            room_size_y = rand(room_size_min..room_size_max)
            room_x = rand(1..map.size - room_size_x - 2)
            room_y = rand(1..map.size - room_size_y - 2)
            for y in room_y..<room_y + room_size_y:
                for x in room_x..<room_x + room_size_x:
                    for t in map.get_tiles_at(x, y):
                        if t of Floor:
                            done = false
            if done:
                break
        rooms.add((room_x + int(room_size_x / 2), room_y + int(room_size_y / 2)))
        for y in room_y..<room_y + room_size_y:
            for x in room_x..<room_x + room_size_x:
                for t in map.get_tiles_at(x, y):
                    map.remove_tile(t)
                map.add_tile(new_floor(x, y))
    for i in 1..<room_amount:
        var
            init: tuple = rooms[i - 1]
            final: tuple = rooms[i]
        while init.x != final.x or init.y != final.y:
            if init.x != final.x:
                init.x += int(copySign(1.0, float(final.x - init.x)))
            elif init.y != final.y:
                init.y += int(copySign(1.0, float(final.y - init.y)))
            for t in map.get_tiles_at(init.x, init.y):
                map.remove_tile(t)
            map.add_tile(new_floor(init.x, init.y))

proc generate_map*(): Map =
    result = generate_empty_map()
    result.generate_rooms()
