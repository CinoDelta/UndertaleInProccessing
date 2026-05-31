public abstract class  NPC extends GameObject {

    private final float damage;
    private final String name;
    private float health;

    public NPC(String name, Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent, float health, float damage) {
         super(mySprite,  myHitbox, myPosition, isVisible, cameraMode, myParent);
         this.damage = damage;
         this.health = health;
         this.name = name; 
    }

    public abstract void update();

    public abstract void die();

    public void giveDamage() {
        mainPlayer.takeDamage(damage);
    }

    public void takeDamage(float damage) {
        health -= damage;
    }
}


public class FlowerThing extends NPC {
    public FlowerThing() {
        super("", new Sprite(-2, ""), new Hitbox(0, 0, 0, 0, new PVector(), ""), new PVector(), true, "", "", 100, 100); // TODO: implament this constructor
    }

    @Override 
    public void update() {

    }

    @Override 
    public void die() {

    }
}