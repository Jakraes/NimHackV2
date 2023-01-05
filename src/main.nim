import engine, map, std/[random, os], illwill, entity

proc main() =
    var 
        world = generate_map()
        turns = 0
        
    world.add_tile(new_player(15, 17))

    init()

    for t in world.tiles:
        put_tile(t)
    display()

    while true:
        tb.clear()
        for e in world.get_entites():
            e.move(world)
        
        for t in world.tiles:
            put_tile(t)
        
        turns += 1
        tb.write(27, 2, "Turns: " & $turns)

        display()
        sleep(1)
    
main()