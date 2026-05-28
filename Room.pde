public class RoomBase extends GameObject {
    private Sprite mySprite;
    private Hitbox myHitbox;
    private PVector myPosition;
    private boolean isVisible;
    private String cameraMode;
    private String myParent;
    private int[][] exitXBounds;
    private int[][] exitYBounds;
    
    private int roomID;

    public RoomBase(
        Sprite mySprite, Hitbox[] myHitboxes, PVector myPosition, boolean isVisible, String cameraMode, String myParent,
        int[][] exitXBounds, int[][] exitYBounds, int[] transitionRooms, PVector enterPosition, PVector exitPosition, int roomID) 
    {
        super(mySprite, myHitboxes, myPosition, isVisible, cameraMode, myParent);
        this.exitXBounds = exitXBounds;
        this.exitYBounds = exitYBounds;
    }
    

    // Returns -1 if the player isn't between any bounds. Otherwise, returns the bound index that the player is it.
    public int isPlayerBetweenExitBounds() {
        int currentBoundBetween = -1;

        for (int i = 0; i < exitXBounds.length; i ++) {
            if (
                mainPlayer.getPosition().x >= exitXBounds[i][0] && mainPlayer.getPosition().x <= exitXBounds[i][1] 
                &&
                mainPlayer.getPosition().y >= exitYBounds[i][0] && mainPlayer.getPosition().y <= exitYBounds[i][1])
            {
                currentBoundBetween = i;
            }
        }

        return currentBoundBetween;
    }

    public int getID() {
        return roomID;
    }

}