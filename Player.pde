class Player extends GameObject {
    private PVector currentDirection;
    private boolean canMove; 
    private String currentImage;
    private PVector direction;
    private int zIndex;
    private String myParent;
    private int speed = 20;
    private int currentAnimationTick = 0;
    private String facing = "Down";
    private String lastFacing = "Down";    
    

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
        this.direction = newDirection.mult((float) speed * 1.6);

        boolean playerCollidingWithCameraUp = !checkCollisions(mainPlayer, "CUP");
        boolean playerCollidingWithCameraLeft = !checkCollisions(mainPlayer, "CLR");

        PVector adjustedDirection = this.direction.copy();

        if (playerCollidingWithCameraUp) {
            mainCam.CFrame = mainCam.CFrame.add(new PVector(0, this.direction.y));
            adjustedDirection.y = 0;
        } 
        if (playerCollidingWithCameraLeft) {
            mainCam.CFrame = mainCam.CFrame.add(new PVector(this.direction.x, 0));
            adjustedDirection.x = 0;
        }

        

        super.setPosition(getPosition().add(adjustedDirection));
    }
   
    @Override
    
    // the animation handler
    public void update() {
        if (!super.multipleContacts) {
            super.myHitbox.setOriginPoint(super.myPosition);
        } else {
            for (Hitbox box : super.myHitboxes) {
                box.setOriginPoint(super.myPosition);
            }
        }

        if (direction.mag() > 0) {
            if (Math.abs(direction.x) >= 2) { // if we are holding left or right, the left and right animations take priority.
                facing = direction.x <= -2 ? "Left" : "Right";
                super.changeImage("Sprites/Frisk/Frisk" + facing + currentAnimationTick % 12 / 6 + ".png");
            } else {
                // if we are just moving up and down
                facing = direction.y <= -2 ? "Up" : "Down";
                super.changeImage("Sprites/Frisk/Frisk" + facing + currentAnimationTick % 24 / 6 + ".png");
            }

            if (lastFacing != facing) {
                currentAnimationTick = 0;
                lastFacing = facing;
            } else {
                currentAnimationTick ++;
            }
        } else {
            super.changeImage("Sprites/Frisk/Frisk" + facing + "0.png"); // sets our animation to the IDLE state.
            currentAnimationTick = 0;
        }



        image(super.mySprite.getImage(), super.myPosition.x, super.myPosition.y);


        if (super.myHitbox.debug) {
            // drawing a debug rectangle yippe.
            fill(255, 0, 0, hitboxTransparency);
            rect(super.myHitbox.originPoint.x + super.myHitbox.getOffset().x, super.myHitbox.originPoint.y + super.myHitbox.getOffset().y, super.myHitbox.getXBound(), super.myHitbox.getYBound());
        }
    }
}