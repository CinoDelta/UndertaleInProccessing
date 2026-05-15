class Hitbox {
    
    private PVector originPoint = new PVector(0, 0);
    private int xBound;
    private int yBound;
    public int collideMask = 0;
    public int ignoreMask = 0;

    public Hitbox(PVector originPoint, int xBound, int yBound, int collideMask, int ignoreMask, PVector offset) {
        this.originPoint = originPoint;
        this.xBound = xBound;
        this.yBound = yBound;
        this.collideMask = collideMask;
        this.ignoreMask = ignoreMask;
    }

    public Hitbox(int xBound, int yBound, int collideMask, int ignoreMask, PVector offset) {
        this.xBound = xBound;
        this.yBound = yBound;
        this.collideMask = collideMask;
        this.ignoreMask = ignoreMask;
    }

    public boolean isColliding() {
        // work on COLLISION branch
        return false;
    }

    public void setOriginPoint(PVector pos) {
        originPoint = pos;
    }
}