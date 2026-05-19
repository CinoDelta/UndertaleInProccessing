import java.util.*;

// Hitbox Layers:
// 0 is Player
// 1 is hitboxes that the player ignores
ArrayDeque<GameObject> gameWorld = new ArrayDeque<GameObject>();
Player mainPlayer;

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
}


void setup() {  
    size(640, 480);
    background(255,255,255);

    // Create the player.

    mainPlayer = new Player(new Sprite(0, "Sprites/Frisk/FriskDown0.png"), new Hitbox(10, 7, 0, 1, new PVector(0, 7.5)), new PVector(0, 0), true, "BORDER_M", "", 0);

}

void draw() {

    background(255, 255, 255);
    // Draw every thing in the game world by order, with the correct sprite.



    for (GameObject object : gameWorld) {
        object.update();
    }
}

    public void keyPressed() {
    if (keyCode == LEFT) {
        mainPlayer.setDirection('L');
    }
}


