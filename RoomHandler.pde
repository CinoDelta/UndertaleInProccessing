
public abstract class Room {
    public final RoomBase room;
    
    public Room(RoomBase room, GameObject... objects) {
        this.room = room;
        for (GameObject object : objects) {
            gameWorld.add(object);
        }
    }

    public RoomBase getRoom() {
        return room;
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
            }, new PVector(-40, 0), true, "BORDER_S", "", new int[][] {}, new int[][] {}, new int[] { }, new PVector(), new PVector(), 0)
        );
    }
}
