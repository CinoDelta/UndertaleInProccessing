class GameObject {

    private Sprite mySprite;
    private Hitbox myHitbox;
    private PVector myPosition;
    private boolean isVisible = true;
    private String cameraMode = "BORDER_S";
    private String myParent = "";


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

    public int getZIndex() {
        return mySprite.getZIndex();
    }

}