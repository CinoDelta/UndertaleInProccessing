import java.util.*;

// Hitbox Layers:
// 0 is Player
// 1 is hitboxes that the player ignores
ArrayDeque<GameObject> gameWorld = new ArrayDeque<GameObject>();
Player mainPlayer;
Room currentGameRoom;
Camera mainCam;
int hitboxTransparency = 40; // 255 for opaque hitboxes, 0 for invisible hitboxes. Adjust as needed for debugging.

GameObject[] merge(GameObject[] left, GameObject[] right) {
    GameObject[] newArray = new GameObject[left.length + right.length];

    int l = 0;
    int r = 0;

    for (int i = 0; i < newArray.length; i ++) {
        if (!(r < right.length)) {
        newArray[i] = left[l];
        l ++;
        } else if (!(l < left.length)){
        newArray[i]  = right[r];
        r ++;
        } else if (left[l].getZIndex() <= right[r].getZIndex()) {
        newArray[i] = left[l];
        l ++;
        } else {
        newArray[i] = right[r];
        r ++;
        }
    }
    return newArray;
}


GameObject[] mergeSort(GameObject[] data){
    if (data.length > 1) {
        // Hi we split data in half.
        GameObject[] arrOne = new GameObject[data.length / 2];
        GameObject[] arrTwo = new GameObject[data.length - arrOne.length];

        for (int i = 0; i < data.length; i ++) {
        if (i < arrOne.length) {
            arrOne[i] = data[i];
        } else {
            arrTwo[i - arrOne.length] = data[i];
        }
        }
        return merge(mergeSort(arrOne), mergeSort(arrTwo));
    } else {
        return data;
    }
}

Hitbox[] worldToBoxes(ArrayDeque<GameObject> theWorld) {
    ArrayDeque<Hitbox> hitboxes = new ArrayDeque<Hitbox>();
    for(int i = 0; i < theWorld.toArray().length; i ++) {
        GameObject anObject = theWorld.toArray(new GameObject[theWorld.size()])[i];
        if (anObject.hasMultipleContacts()) {
            for (Hitbox hb : anObject.getMyHitboxes()) {
                hitboxes.add(hb);
            }
        } else {
            hitboxes.add(anObject.getMyHitbox());
        }
    }

    Hitbox[] result = hitboxes.toArray(new Hitbox[hitboxes.size()]);

    return result;
}

boolean checkCollisions(GameObject object, String certainMetaData) {
    Hitbox[] hitboxes = worldToBoxes(gameWorld);
    if (object.hasMultipleContacts()) {
        for (Hitbox box : object.getMyHitboxes()) {
            for (Hitbox otherBox : hitboxes) {
                if (box != otherBox && box.canCollideWith(otherBox) && otherBox.metaData.equals(certainMetaData)) {
                    if (box.originPoint.x + box.getOffset().x < otherBox.originPoint.x + otherBox.getOffset().x + otherBox.getXBound() &&
                        box.originPoint.x + box.getOffset().x + box.getXBound() > otherBox.originPoint.x + otherBox.getOffset().x &&
                        box.originPoint.y + box.getOffset().y < otherBox.originPoint.y + otherBox.getOffset().y + otherBox.getYBound() &&
                        box.originPoint.y + box.getOffset().y + box.getYBound() > otherBox.originPoint.y + otherBox.getOffset().y) {
                        return true;
                    }
                }
            }
        }
    } else {
        for (Hitbox otherBox : hitboxes) {
            if (object.getMyHitbox() != otherBox && object.getMyHitbox().canCollideWith(otherBox) && otherBox.metaData.equals(certainMetaData)) {
                if (object.getMyHitbox().originPoint.x + object.getMyHitbox().getOffset().x < otherBox.originPoint.x + otherBox.getOffset().x + otherBox.getXBound() &&
                    object.getMyHitbox().originPoint.x + object.getMyHitbox().getOffset().x + object.getMyHitbox().getXBound() > otherBox.originPoint.x + otherBox.getOffset().x &&
                    object.getMyHitbox().originPoint.y + object.getMyHitbox().getOffset().y < otherBox.originPoint.y + otherBox.getOffset().y + otherBox.getYBound() &&
                    object.getMyHitbox().originPoint.y + object.getMyHitbox().getOffset().y + object.getMyHitbox().getYBound() > otherBox.originPoint.y + otherBox.getOffset().y) {
                    return true;
                }
            }
        }
    }

    return false;
}


void sortWorldByZ() {
    GameObject[] startArray = gameWorld.toArray(new GameObject[gameWorld.size()]);

    startArray = mergeSort(startArray);
    
    gameWorld.clear();

    for (GameObject object : startArray) {
        gameWorld.add(object);
    }

}


void setup() {  
    size(640, 440);
    background(255,255,255);
    frameRate(30);
    
    // the game's camera.

    mainCam = new Camera(new PVector (0, 0));

    /*
    Metadatas

    CUP: inhibits the camera from moving up or down when the player is in contact with it. (Camera will still move left and right)
    CLR: inhibits the camera from moving left or right when the player is in contact with it. (Camera will still move up and down)
    PLR: the player's hitbox, makes sure they are not affected by the camera offset.

    Being in a combination of these two will inhibit the camera from moving at all when the player is in contact with it.


    */

    // Create the player.

    // z index of 0
    mainPlayer = new Player(new Sprite(0, "Sprites/Frisk/FriskDown0.png"), new Hitbox(14, 10, 0, 1, new PVector(3, 18), "PLR"), new PVector(140, 90), true, "BORDER_M", "", 0);

    // Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent,
    //  int[][] exitXBounds, int[][] exitYBounds, int[] transitionRooms, PVector enterPosition, PVector exitPosition, int roomID
    currentGameRoom = new Room(new Sprite(-1, "Sprites/RuinsSprites/firstroom.jpeg"), new Hitbox[] {

        // public Hitbox(PVector originPoint, int xBound, int yBound, int collideMask, int ignoreMask, PVector offset) {
        new Hitbox(new PVector(0, 0), 640, 220, 0, 1, new PVector(0, 0), "CUP"),
        new Hitbox(new PVector(0, 0), 190, 220, 0, 1, new PVector(0, 0), "CLR")


     }, new PVector(-40, 0), true, "BORDER_S", "", new int[][] {}, new int[][] {}, new int[] { }, new PVector(), new PVector(), 0);


}

boolean test = false;

boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false; 

void draw() {
    scale(2);
    background(255, 255, 255);
    // Draw every thing in the game world by order, with the correct sprite.

    sortWorldByZ();

    PVector currentPlayerDirection = new PVector();

    currentPlayerDirection = upPressed ? PVector.add(currentPlayerDirection, new PVector(0, -0.1)) : currentPlayerDirection;
    currentPlayerDirection = downPressed ? PVector.add(currentPlayerDirection, new PVector(0, 0.1)) : currentPlayerDirection;
    currentPlayerDirection = leftPressed ? PVector.add(currentPlayerDirection, new PVector(-0.1, 0)) : currentPlayerDirection;
    currentPlayerDirection = rightPressed ? PVector.add(currentPlayerDirection, new PVector(0.1, 0)) : currentPlayerDirection;

    mainPlayer.setDirection(currentPlayerDirection);

    for (GameObject object : gameWorld) {
        object.update();
    }



}

public void keyPressed() {
    switch(keyCode) {
        case LEFT:
            leftPressed = true;
           
            break;
        case RIGHT:
            rightPressed = true;
            break;
        case UP:
            upPressed = true;
            break;
        case DOWN:
            downPressed = true;
            break;
    }
}

public void keyReleased() {
    switch(keyCode) {
    case LEFT:
        leftPressed = false;
        
        break;
    case RIGHT:
        rightPressed = false;
        break;
    case UP:
        upPressed = false;
        break;
    case DOWN:
        downPressed = false;
        break;
    }
}


