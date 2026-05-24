class GameObject {

    private Sprite mySprite;
    private Hitbox myHitbox;
    private Hitbox[] myHitboxes;
    private PVector myPosition;
    private boolean isVisible = true;
    private String cameraMode = "BORDER_S";
    private String myParent = "";
    private boolean removeMyself = false;
    private PVector direction;
    private boolean multipleContacts = false;


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

    public GameObject(Sprite mySprite, Hitbox[] myHitboxes, PVector myPosition, boolean isVisible, String cameraMode, String myParent) {
        this.mySprite = mySprite;
        this.myHitboxes = myHitboxes;
        this.myPosition = myPosition;
        this.isVisible = isVisible;
        this.cameraMode = cameraMode;
        this.myParent = myParent;

        multipleContacts = true;
        
        direction = new PVector();

        gameWorld.add(this);
    }

    public PVector getPosition() {
        return myPosition;
    }

    public void setPosition(PVector newPos) {
        myPosition = newPos;
    }

    public void setZIndex(int newZIndex) {
        mySprite.zIndex = newZIndex;
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

    public String toString() {
        return mySprite.getImagePath();
    }

    public Hitbox[] getMyHitboxes() {
        return myHitboxes;
    }

    public Hitbox getMyHitbox() {
        return myHitbox;
    }

    public void update() {
        float relativeX = myPosition.x - mainCam.CFrame.x;
        float relativeY = myPosition.y - mainCam.CFrame.y;

        if (cameraMode.equals("BORDER_S")) {
            image(mySprite.getImage(), relativeX, relativeY);
        } else {
            image(mySprite.getImage(), myPosition.x, myPosition.y);
        }

        if (!multipleContacts) {
            myHitbox.setOriginPoint(myPosition);
        } else {
            for (Hitbox box : myHitboxes) {
                //box.setOriginPoint(myPosition);
                if (box.debug) {
                    // drawing a debug rectangle yippe.
                    fill(255, 0, 0, hitboxTransparency);
                    rect(box.originPoint.x + box.getOffset().x, box.originPoint.y + box.getOffset().y, box.getXBound(), box.getYBound());
                }
            }
        }
    }

    public void setDirection(PVector direction) {
        this.direction = direction;
    }

    public boolean hasMultipleContacts() {
        return multipleContacts;
    }
}