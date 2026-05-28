
public abstract class Room {
    public final RoomBase room;
    private final GameObject[] objects;
    

    public Room(RoomBase room, GameObject... objects) {
        this.room = room;
        if (room.getID() == 1) {
            gameWorld.clear();
            gameWorld.add(room);
            for (GameObject object : objects) {
                gameWorld.add(object);
            }
        }
        this.objects = new GameObject[]{room};
    }

    public RoomBase getRoom() {
        return room;
    }

    public void loadRoom() {
        gameWorld.clear();
        gameWorld.add(room);
        print(Arrays.toString(objects));
        for (GameObject object : objects) {
            // print(object.toString());
                // gameWorld.add(object);
        }
    }

    public Door[] getDoorsForRoomID(int roomid) {
        ArrayList<Door> doors = new ArrayList<Door>();
        for (GameObject object : gameWorld) {
            if (object instanceof Door) {
                Door door = (Door) object;
                if (door.getstartID() == roomid) {
                    doors.add(door);
                }
            }
        }
        Door[] doorArray = new Door[doors.size()];
        for (int i = 0; i < doors.size(); i++) {
            doorArray[i] = doors.get(i);
        }

        return doorArray;
    }

}

public class RoomOne extends Room{
    public RoomOne() {
        super(
            new RoomBase(new Sprite(-1, "Sprites/RuinsSprites/firstroom.jpeg"), new Hitbox[] {
            // public Hitbox(PVector originPoint, int xBound, int yBound, int collideMask, int ignoreMask, PVector offset) {
                
            // CAMERA BOUNDS
            new Hitbox(new PVector(0, 0), 640, 220, 0, 1, new PVector(0, 0), "CUP"),
            new Hitbox(new PVector(0, 0), 150, 220, 0, 1, new PVector(0, 0), "CLR"),
            new Hitbox(new PVector(536, 0), 300, 220, 0, 1, new PVector(0, 0), "CLR"),
                
            // WALLS 
            new Hitbox(new PVector(10, 53), 18, 100, 0, 1, new PVector(0, 0), "WALL")
            }, new PVector(-40, 0), true, "BORDER_S", "", new int[][] {}, new int[][] {}, new int[] { }, new PVector(), new PVector(), 1),
            new Door(new PVector(580, 72), new PVector(580, 72), 1, 2, new Hitbox(new PVector(580, 72), 50, 50, 0, 1, new PVector(), "DOOR" )
            )
        );
    }
}
public class RoomTwo extends Room{
    public RoomTwo() {
        super(
            new RoomBase(new Sprite(-1, "Sprites/RuinsSprites/firstroom.jpeg"), new Hitbox[] {
            // public Hitbox(PVector originPoint, int xBound, int yBound, int collideMask, int ignoreMask, PVector offset) {
                
            // CAMERA BOUNDS
            new Hitbox(new PVector(0, 0), 640, 220, 0, 1, new PVector(0, 0), "CUP"),
            new Hitbox(new PVector(0, 0), 150, 220, 0, 1, new PVector(0, 0), "CLR"),
            new Hitbox(new PVector(536, 0), 300, 220, 0, 1, new PVector(0, 0), "CLR"),
                
            // WALLS 
            new Hitbox(new PVector(10, 53), 18, 100, 0, 1, new PVector(0, 0), "WALL")
            }, new PVector(-40, 0), true, "BORDER_S", "", new int[][] {}, new int[][] {}, new int[] { }, new PVector(), new PVector(), 2),
            mainPlayer
        );
    }
}
