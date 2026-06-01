public abstract class GameObject {   

    private Sprite mySprite;
    public Hitbox myHitbox;
    private Hitbox[] myHitboxes;
    private PVector myPosition;
    private boolean isVisible = true;
    private String cameraMode = "BORDER_S";
    private String myParent = "";
    private boolean removeMyself = false;
    private PVector direction;
    private boolean multipleContacts = false;
    private final Event addToGameWorld;
    private final Event removeFromGameWorld;

    public GameObject(Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent) {
        this.mySprite = mySprite;
        this.myHitbox = myHitbox;
        this.myPosition = myPosition;
        this.isVisible = isVisible;
        this.cameraMode = cameraMode;
        this.myParent = myParent;

        direction = new PVector();
        addToGameWorld = new Event("Add object to world", () -> gameWorld.add(this));
        removeFromGameWorld= new Event("Add object to world", () -> gameWorld.remove(this));
        addToGameWorld.schedule();
    }

    // specifically for text objects, and dialogue which don't have sprites or hitboxes.

    public GameObject(PVector myPosition, boolean isVisible, String cameraMode, int zIndex) {
        this.myPosition = myPosition;
        this.isVisible = isVisible;
        this.cameraMode = cameraMode;
        this.mySprite = new Sprite(zIndex);

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

        addToGameWorld = new Event("Add object to world", () -> gameWorld.add(this));
        removeFromGameWorld= new Event("Add object to world", () -> gameWorld.remove(this));
        addToGameWorld.schedule();
    }

    // specifically for rooms, which cannot be auto-added to the game world upon creation due to how the room loading system works.
    public GameObject(Sprite mySprite, Hitbox[] myHitboxes, PVector myPosition, boolean isVisible, String cameraMode, String myParent, boolean shouldAddToGameWorld) {
        this.mySprite = mySprite;
        this.myHitboxes = myHitboxes;
        this.myPosition = myPosition;
        this.isVisible = isVisible;
        this.cameraMode = cameraMode;
        this.myParent = myParent;
            
        multipleContacts = true;
        
        direction = new PVector();

        addToGameWorld = new Event("Add object to world", () -> gameWorld.add(this));
        removeFromGameWorld= new Event("Add object to world", () -> gameWorld.remove(this));

        if (shouldAddToGameWorld) {
            addToGameWorld.schedule();
        }
    }

    public GameObject(PVector myPosition, boolean isVisible, String cameraMode, String myParent, Hitbox... myHitboxes) {
        this.myHitboxes = myHitboxes;
        this.myHitbox = myHitboxes[0];
        this.myPosition = myPosition;
        this.isVisible = isVisible;
        this.cameraMode = cameraMode;
        this.myParent = myParent;

        multipleContacts = true;
        
        direction = new PVector();

        addToGameWorld = new Event("Add object to world", () -> gameWorld.add(this));
        removeFromGameWorld= new Event("Add object to world", () -> gameWorld.remove(this));
        addToGameWorld.schedule();
    }

    public PVector getPosition() {
        return myPosition;
    }

    public void setPosition(PVector newPos) {
        myPosition = newPos;
    }

    public void setZIndex(int newZIndex) {
        if (mySprite != null ) mySprite.zIndex = newZIndex;
    }

    public int getZIndex() {
        return (mySprite != null) ? mySprite.getZIndex() : -1;
    }

    public void remove() {
        removeFromGameWorld.schedule();
    }

    public void addToGameWorld() {
        addToGameWorld.schedule();
    }

    public void changeImage(String path) {
        if (mySprite != null)  mySprite.setImage(path);
    }

    public Hitbox[] getMyHitboxes() {
        return myHitboxes;
    }

    public Hitbox getMyHitbox() {
        return myHitbox;
    }

    public String getParent() {
        return myParent;
    }
    public void update() {
        if (!isVisible) {
            return;
        }
        float relativeX = myPosition.x - mainCam.CFrame.x;
        float relativeY = myPosition.y - mainCam.CFrame.y;

        if (mySprite != null) {
            if (cameraMode.equals("BORDER_S")) {
                image(mySprite.getImage(), relativeX, relativeY);
            } else {
                image(mySprite.getImage(), myPosition.x, myPosition.y);
            }

        }


        if (!multipleContacts) {
            myHitbox.setOriginPoint(myPosition);
        } else {
            for (Hitbox box : myHitboxes) {
                //box.setOriginPoint(myPosition);
                if (box.debug) {
                    // drawing a debug rectangle yippe.
                    
                    strokeWeight(1);
                    if (box.metaData == "WALL") {
                      fill(0, 125, 255, hitboxTransparency + 50);
                    }else if (box.metaData.contains("CUTSCENE")) {
                      fill(255, 255, 0, hitboxTransparency + 50);
                    } else {
                      fill(255, 0, 0, hitboxTransparency);
                    }
                    rect(box.originPoint.x + box.getOffset().x, box.originPoint.y + box.getOffset().y, box.getXBound(), box.getYBound());
                    strokeWeight(0);
                }
            }
        }

        if (myParent.equals("Projectile") && myHitbox.isColidingWith(mainPlayer.getMyHitbox())) {
            mainPlayer.takeDamage(1);
        }
    }

    private void addVector(PVector toAdd) {
        myPosition.add(toAdd);
    }

    public void setDirection(PVector direction) {
        this.direction = direction;
    }

    public boolean hasMultipleContacts() {
        return multipleContacts;
    }
}
