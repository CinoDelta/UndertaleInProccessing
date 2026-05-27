public class Sprite {
    
    public int zIndex;
    private PImage img;
    private String imgPath;

    public Sprite(int zIndex, String path) {
        this.zIndex = zIndex;
        imgPath = path;
        img = loadImage(path);
    }

    public PImage getImage() {
        return img;
    }

    public void setImage(String imgDirect) {
        imgPath = imgDirect;
        img = loadImage(imgDirect);
    }

    public int getZIndex() {
        return zIndex;
    }

    public String getImagePath() {
        return imgPath;
    }
}