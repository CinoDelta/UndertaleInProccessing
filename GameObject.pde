class GameObject {

    private Sprite mySprite;
    private Hitbox myHitbox;
    private PVector myPosition;
    private boolean isVisible = true;
    private String cameraMode = "BORDER_S";
    private String myParent = "";
    private boolean removeMyself = false;


    public GameObject(Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent) {
        this.mySprite = mySprite;
        this.myHitbox = myHitbox;
        this.myPosition = myPosition;
        this.isVisible = isVisible;
        this.cameraMode = cameraMode;
        this.myParent = myParent;
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
        removeMyself = true;
    }

    public void changeImage(String path) {
        mySprite.setImage(path);
    }

    public void update() {
        myHitbox.setOriginPoint(myPosition);
    }


}