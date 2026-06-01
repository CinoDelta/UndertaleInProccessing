import processing.sound.*;
public class Text extends GameObject {
    private String text;
    private color myColor;

    
    private SoundFile[][] dialogueSounds = new SoundFile[][] {
        {
            
        }
    };

    public Text(PVector myPosition, boolean isVisible, String text, color myColor) {
        //Sprite mySprite, Hitbox myHitbox, PVector myPosition, boolean isVisible, String cameraMode, String myParent
        //PVector myPosition, boolean isVisible, String cameraMode
        super(myPosition, isVisible, "BORDER_M", 101);
        this.text = text;
        this.myColor = myColor;
    }

    public void setColor(color newColor) {
        myColor = newColor;
    }


    public void updateText(String newText, boolean periodicUpdate, int dialogueIndex) {

        if (!periodicUpdate) {
            text = newText;
            return;
        } 

        char[] textArray = newText.toCharArray();
        String[] words = newText.split("\\s+");

        text = "* "; 
        String nextWord = words[0];
        int partitionIndex = 1;
        int amtOfWords = 0;
        int amtOfLines = 0;
        boolean newLineAdded = false;

        for (char c : textArray) {
            newLineAdded = false;

            if (text.substring(partitionIndex).contains(nextWord)) {
                amtOfWords ++;
                partitionIndex = text.indexOf(nextWord, partitionIndex) + nextWord.length() - 1;
                nextWord = (words.length > 1) && (amtOfWords < words.length) ? words[amtOfWords] : ""; // get the next word or set to empty if there are no more words
                if (text.length() + nextWord.length() > 20 * (amtOfLines + 1)) { // if the next word will go over the character limit for the line, add a line break
                    amtOfLines++;
                    newLineAdded = true;
                    text += "\n";
                }
            }
            text += !newLineAdded ? c : (c == ' ' ? "" : c); // if a new line was just added, don't add the space after the line break
            if (c == '\n') {
                amtOfLines++;
                text += "* "; // add a star at the beginning of each new line
            }
            //print(Arrays.deepToString(dialogueSounds));
            help.play();
            delay(c == '!' || c == '.' || c == '?' ? 500 : c == ',' ? 300 : 40);
        }
    }

    @Override

    public void update() {
        if (!super.isVisible) {
            return;
        }
        float relativeX = super.myPosition.x - mainCam.CFrame.x;
        float relativeY = super.myPosition.y - mainCam.CFrame.y;

        fill(myColor);

        textSize(20); // we'll update this later
        text(text, super.myPosition.x, super.myPosition.y);

    }



}