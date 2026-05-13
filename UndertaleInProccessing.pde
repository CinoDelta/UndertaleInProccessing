import java.util.*;

ArrayDeque<GameObject> gameWorld = new ArrayDeque<GameObject>();

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
        } else if (left[l] <= right[r]) {
        newArray[i] = left[l];
        l ++;
        } else {
        newArray[i] = right[r];
        r ++;
        }
    }
    return newArray;
}


int[] mergeSort(int[] data){
    if (data.length > 1) {
        // Hi we split data in half.
        int[] arrOne = new int[data.length / 2];
        int[] arrTwo = new int[data.length - arrOne.length];

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

GameObject[] sortWorldByZ() {
    GameObject[] startArray = gameWorld.toArray(new GameObject[gameWorld.size()]);
    // enact MergeSort
}


void setup() {

}

void draw() {

}


