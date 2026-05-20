class Player extends GameObject {
        private PVector currentDirection;
        private boolean canMove; 
        private String currentImage;
        private PVector direction;
        private int zIndex;
        private String myParent;
        private PVector myPosition;



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
    public void setDirection(int code) {
        switch (code) {
            case RIGHT:
                this.direction.x = PlayerConstants.SPEED;
                this.direction.y = 0.0;
                break;
            case LEFT:
                this.direction.x = -PlayerConstants.SPEED;
                this.direction.y = 0.0;
                break;
            case DOWN:
                this.direction.x = 0.0;
                this.direction.y = PlayerConstants.SPEED;
                break;
            case UP:
                this.direction.x = 0.0;
                this.direction.y = -PlayerConstants.SPEED;
                break;
            default:
                this.direction.x = 0.0;
                this.direction.y = 0.0;
                break;
        }
    }

    @Override
    public void update() {
        super.addVector(direction);
        super.update();
    }
 }

    interface PlayerConstants {
        float SPEED = 0.4;
    }
