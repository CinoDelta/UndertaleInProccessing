// import processing.sound.*;
public class Dialogue extends GameObject {
    //PVector myPosition, boolean isVisible, String cameraMode)

    private String[][] allDialogue = new String[][] {
        {
        "Howdy! \nI'm FLOWEY. \nFLOWEY the FLOWER!", 
        "Hee hee hee...",
        "You're new to the UNDERGROUND, aren'tcha?",
        "Golly, you must be so confused.",
        "Someone ought to teach you how things work around here!",
        "I guess little old me will have to do.",
        "Ready? Here we go!"
    } // enterance one
    };

    private PImage[][] dialoguePortraits = new PImage[][] {
        {
            loadImage("Sprites/Flowey/FLOWEY_TALK_0.png"),
            loadImage("Sprites/Flowey/FLOWEY_TALK_1.png")
        }
        
    };


    private int currentDialogueIndex;
    private int frames = 0;
    private boolean talking = false;

    private Text dialogueText;

    public Dialogue(PVector myPosition, boolean isVisible, String cameraMode) {
        super(myPosition, isVisible, cameraMode, 100);
    }

    public boolean startDialogue(int dialogueIndex, boolean character) { // this is its literally only purpose, then it kills itself
        String[] dialogue = allDialogue[dialogueIndex];
        // public Text(PVector myPosition, boolean isVisible, String text, color myColor)
        dialogueText = new Text(new PVector(86 - (!character ? 90 : 0), 35), true, dialogue[0], color(255)); // gonna tweek position and everyting later

        currentDialogueIndex = 0;

        for (int i = 0; i < dialogue.length; i++) {
            talking = true;
            dialogueText.updateText(dialogue[i], true, dialogueIndex);
            while (!continueDialogue) {
                talking = false;
                delay(10);
            }
            continueDialogue = false;
        }

        inDialogue = false;
        this.remove();
        dialogueText.remove();
        return true; 
    }

    @Override
    public void update() {
        strokeWeight(3);
        stroke(255, 255, 255);
        fill(0, 0, 0);

        rect(10, 10, 300, 80);

        image(dialoguePortraits[currentDialogueIndex][!talking ? 0 : (frames / 6) % 2 == 0 ? 0 : 1], 25, 25);

        stroke(0);
        strokeWeight(0);
        frames ++;
    }
}