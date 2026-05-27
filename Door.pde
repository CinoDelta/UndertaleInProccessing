public class Door extends GameObject{
    private PVector location;
    private final Event transitionRooms;
    private boolean canSwitch; 
    // private static int doorNum = 0;

    public Door (PVector initlocation, PVector nextLocation, Room current, Room next, Hitbox myHitbox) {
        super(initlocation, true, "BORDER_S", "TODO", myHitbox);
        location = (current == currentGameRoom) ? initlocation : nextLocation;
        transitionRooms = new Event("Room " + current.getRoom().getID() + " room " + next.getRoom().getID() + " transition", 
            () -> {
                if (location != nextLocation) {
                    currentGameRoom = next;
                    location = nextLocation;
                } else {
                    currentGameRoom = current;
                    location = initlocation;
                }
            }
        );
        canSwitch = true;
    }

    @Override 
    public void update() {
        super.update();
        if (myHitbox.isColidingWith(mainPlayer.getMyHitbox()) && canSwitch) {
            transitionRooms.start();
            canSwitch = false;
        } else { 
            canSwitch = true;
        }
    }
}