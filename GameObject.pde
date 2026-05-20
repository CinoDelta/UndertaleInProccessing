public abstract class  GameObject {

    private Sprite mySprite;
    private Hitbox myHitbox;
    private PVector myPosition;
    private boolean isVisible = true;
    private String cameraMode = "BORDER_S";
    private String myParent = "";
    private boolean removeMyself = false;
    private PVector direction;


    public GameObject(Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent) {
        this.mySprite = mySprite;
        this.myHitbox = myHitbox;
        this.myPosition = myPosition;
        this.isVisible = isVisible;
        this.cameraMode = cameraMode;
        this.myParent = myParent;

        direction = new PVector();

        gameWorld.add(this);
    }

    public PVector getPosition() {
        return myPosition;
    }

    public void setPosition(PVector newPos) {
        myPosition = newPos;
    }

    public int getZIndex() {
        return mySprite.getZIndex();
    }

    public void remove() {
        gameWorld.remove(this);
    }

    public void changeImage(String path) {
        mySprite.setImage(path);
    }

    public abstract void update();

    private void updatePos() {
        myHitbox.setOriginPoint(myPosition);
        image(mySprite.getImage(), myPosition.x, myPosition.y);
    }

    private void addVector(PVector toAdd) {
        myPosition.add(toAdd);
    }

    public void setDirection(PVector direction) {
        this.direction = direction;
    }

    public Hitbox getHitBox() {
        return myHitbox;
    }
}