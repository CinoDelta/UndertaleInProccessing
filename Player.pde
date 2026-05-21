class Player extends GameObject {
    private PVector currentDirection;
    private boolean canMove; 
    private String currentImage;
    private PVector direction;
    private int zIndex;
    private String myParent;
    private int speed = 20;

    public Player(Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent, int zIndex) {
        super(mySprite,  myHitbox, myPosition, isVisible, cameraMode, myParent);
        currentDirection = new PVector();
        boolean canMove = false; 
        currentImage = mySprite.getImagePath();
        direction = new PVector();
        this.zIndex = zIndex;
        this.myParent = myParent;
    }

    /**
    * Set direction base on char as follows: 
    * 'R' for right
    * 'L' for left
    * 'U' for up
    * 'D' for down
    * 'N' for neutral (no movement)
    */
    public void setDirection(PVector newDirection) {
        this.direction = newDirection.mult((float) speed);
        print(this.direction.x + " " + this.direction.y);
        super.setPosition(getPosition().add(this.direction));
    }
}