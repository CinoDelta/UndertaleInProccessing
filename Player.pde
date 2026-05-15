class Player extends GameObject {
        private PVector currentDirection;
        private boolean canMove; 

        public Player(Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent, int zIndex) {
         super(mySprite,  myHitbox, myPosition, isVisible, cameraMode, myParent);
         currentDirection = new PVector();
         boolean canMove = false; 
    }
}