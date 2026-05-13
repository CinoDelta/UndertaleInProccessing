class Sprite {
    
    public int zIndex;
    private PImage img;

    public Sprite(int zIndex, PImage img) {
        this.zIndex = zIndex;
        this.img = img;
    }
    

    public PImage getImage() {
        return img;
    }

    public void setImage(String imgDirect) {
        img = loadImage(imgDirect);
    }
}