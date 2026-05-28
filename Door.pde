public class Door extends GameObject{
    private PVector location;
    private final Event transitionRooms;
    private boolean canSwitch; 
    private int currentid;
    private int nextid;
    // private static int doorNum = 0;

    public Door (PVector initlocation, PVector nextLocation, int currentid, int nextid, Hitbox myHitbox) {
        super(initlocation, true, "BORDER_S", "TODO", myHitbox);
        location =  initlocation;
        transitionRooms = new Event("Room " + currentid + " room " + nextid + " transition", 
            () -> {
                if (currentGameRoom.getRoom().getID() != nextid) {
                    currentGameRoom = rooms.get(nextid - 1);
                    currentGameRoom.loadRoom();
                    location = nextLocation;
                    print("hi");
                } else {
                    currentGameRoom = rooms.get(currentid - 1);
                    location = initlocation;
                }
            }
        );
        this.currentid = currentid;
        this.nextid = nextid;
        canSwitch = true;
    }

    @Override 
    public void update() {
        super.update();
        if (super.getMyHitbox().isColidingWith(mainPlayer.getMyHitbox())) {
            if (canSwitch) {
                canSwitch = false;
                transitionRooms.getEvent().run();
            }
        } else { 
            canSwitch = true;
        }
    }

    public int getstartID() {
        return currentid;    
    }

    public int getnextID() {
        return nextid;
    }
}