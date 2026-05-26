public class Door extends GameObject{
    private PVector location;

    public Door (PVector Intlocation, PVector nextLocation, Room current, Room Next, Sprite mySprite, Hitbox myHitbox) {
        super(mySprite, myHitbox, (current == currentGameRoom) ? Intlocation : nextLocation, true, "BORDER_S", "TODO");
        location = (current == currentGameRoom) ? Intlocation : nextLocation;
    }

    @Override 
    public void update() {
        super.update();
        
    }
}