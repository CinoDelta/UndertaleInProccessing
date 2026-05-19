class Player extends GameObject {
        private PVector currentDirection;
        private boolean canMove; 
        private String currentImage;
        private PVector direction;

        public Player(Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent, int zIndex) {
         super(mySprite,  myHitbox, myPosition, isVisible, cameraMode, myParent);
         currentDirection = new PVector();
         boolean canMove = false; 
         currentImage = mySprite.getImagePath();
         direction = new PVector();
    }

    /**
    * Set direction base on char as follows: 
    * 'R' for right
    * 'L' for left
    * 'U' for up
    * 'D' for down
    * 'N' for neutral (no movement)
    */
    public void setDirection(char direction) {
        switch (direction) {
            case 'R':
                this.direction.x = 0.1;
                this.direction.y = 0.0;
                break;
            case 'L':
                this.direction.x = -0.1;
                this.direction.y = 0.0;
                break;
            case 'U':
                this.direction.x = 0.0;
                this.direction.y = 0.1;
                break;
            case 'D':
                this.direction.x = 0.0;
                this.direction.y = -0.1;
                break;
            case 'N':
                this.direction.x = 0.0;
                this.direction.y = 0.0;
                break;
            default:
                break;
        }
        super.setPosition(getPosition().add(this.direction));
    }
}