import java.util.*;

// Hitbox Layers:
// 0 is Player
// 1 is hitboxes that the player ignores

// TODO: add how it works and description to updated doc 
ArrayDeque<GameObject> gameWorld = new ArrayDeque<GameObject>();
Player mainPlayer;
Room currentGameRoom;

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

    // Create the player.

    // z index of 0
    mainPlayer = new Player(new Sprite(0, "Sprites/Frisk/FriskDown0.png"), new Hitbox(10, 7, 0, 1, new PVector(0, 7.5)), new PVector(100, 100), true, "BORDER_M", "", 0);

    // Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent,
    //  int[][] exitXBounds, int[][] exitYBounds, int[] transitionRooms, PVector enterPosition, PVector exitPosition, int roomID
    currentGameRoom = new Room(new Sprite(-1, "Sprites/RuinsSprites/firstroom.jpeg"), new Hitbox[] { }, new PVector(0, 0), true, "BORDER_S", "", new int[][] {}, new int[][] {}, new int[] { }, new PVector(), new PVector(), 0);

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

