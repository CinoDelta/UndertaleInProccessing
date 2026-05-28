import java.util.*;

// Hitbox Layers:
// 0 is Player
// 1 is hitboxes that the player ignores
// TODO: add how it works and description to updated doc 
ArrayDeque<GameObject> gameWorld = new ArrayDeque<GameObject>();
public static Player mainPlayer;
Camera mainCam;
int hitboxTransparency = 40; // 255 for opaque hitboxes, 0 for invisible hitboxes. Adjust as needed for debugging.
public RoomOne roomOne;
Room currentGameRoom;
private static final ArrayList<Sprite> sprites = new ArrayList<Sprite>();

public static final ArrayList<Room> rooms = new ArrayList<Room>();

// ROOMS: 

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
                    return box.isColidingWith(otherBox);
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

Hitbox[] collidingWalls(GameObject object) {
  // here we are looking for hitboxes with the "WALL" meta data, and returning the walls that we are colliding with. 
   ArrayDeque<Hitbox> walls = new ArrayDeque<Hitbox>();
   Hitbox[] boxesToCheck = currentGameRoom.getRoom().getMyHitboxes();
   
   for(Hitbox box : boxesToCheck) {
     if (box.metaData == "WALL") {
      if (object.getMyHitbox() != box && object.getMyHitbox().canCollideWith(box)) {
            if (object.getMyHitbox().isColidingWith(box)) {
              walls.add(box);
          }
      }
     }
   }
   
  if (walls.size() != 0) {
    Hitbox[] result = walls.toArray(new Hitbox[walls.size()]);
    return result;
  } else {
    return null;
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
    roomOne = new RoomOne();
    currentGameRoom = roomOne;

    // FIRST ROOM (plan to move this to a room loading function that loads and removes rooms, and move these rooms to an interface.
    // for(Sprite sprite : sprites) {
    //     sprite.setImage(sprite.getImagePath());
    //     print(sprite.getImagePath());
    // }

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

    int[] hitNull = new int[] {1, 1, 1, 1}; // LEFT RIGHT UP DOWN
    
    Hitbox[] checkHitboxes = collidingWalls(mainPlayer);
    
    if (checkHitboxes != null) {
      print("checking ");
      for (Hitbox box : checkHitboxes) {
        print(box);
        print("FIRST " +  box.originPoint.x + box.getOffset().x + box.getXBound() + "\n");
        print("SECOND " + mainPlayer.getMyHitbox().originPoint.x + mainPlayer.getMyHitbox().getOffset().x + "\n");
        if (
        //object.getMyHitbox().originPoint.x + object.getMyHitbox().getOffset().x < box.originPoint.x + box.getOffset().x + box.getXBound()
          box.originPoint.x + box.getOffset().x + box.getXBound() < mainPlayer.getMyHitbox().originPoint.x + mainPlayer.getMyHitbox().getOffset().x 
          ) {
          hitNull[0] = 0;
          }
      }
    }
           
    
    currentPlayerDirection = upPressed ? PVector.add(currentPlayerDirection, new PVector(0, -0.1)) : currentPlayerDirection;
    currentPlayerDirection = downPressed ? PVector.add(currentPlayerDirection, new PVector(0, 0.1)) : currentPlayerDirection;
    currentPlayerDirection = leftPressed ? PVector.add(currentPlayerDirection, new PVector(-0.1 * hitNull[0], 0)) : currentPlayerDirection;
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


    switch (key) {
        case 'a':
            leftPressed = true;
            break;
        case 'd':
            rightPressed = true;
            break;
        case 'w':
            upPressed = true;
            break;
        case 's':
            downPressed = true;
            break;
        case 'p':
            print("Global Position: " + (mainPlayer.getPosition().x + mainCam.CFrame.x) + ", " + (mainPlayer.getPosition().y + mainCam.CFrame.y));
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

    switch (key) {
        case 'a':
            leftPressed = false;
            break;
        case 'd':
            rightPressed = false;
            break;
        case 'w':
            upPressed = false;
            break;
        case 's':
            downPressed = false;
            break;
    }
}
