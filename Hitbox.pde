class Hitbox {
    
    private PVector originPoint = new PVector(0, 0);
    private int xBound;
    private int yBound;
    public boolean debug = true;
    public int collideMask = 0;
    public int ignoreMask = 0;
    private PVector offset = new PVector(0, 0);
    public String metaData = "";

    public Hitbox(PVector originPoint, int xBound, int yBound, int collideMask, int ignoreMask, PVector offset, String metaData) {
        this.originPoint = originPoint;
        this.xBound = xBound;
        this.yBound = yBound;
        this.collideMask = collideMask;
        this.ignoreMask = ignoreMask;
        this.offset = offset;
        this.metaData = metaData;
    }

    public Hitbox(int xBound, int yBound, int collideMask, int ignoreMask, PVector offset, String metaData) {
        this.xBound = xBound;
        this.yBound = yBound;
        this.collideMask = collideMask;
        this.ignoreMask = ignoreMask;
        this.offset = offset;
        this.metaData = metaData;
    }

    public boolean canCollideWith(Hitbox other) {
        if ((this.collideMask & other.ignoreMask) != 0 || (other.collideMask & this.ignoreMask) != 0) {
            return false;
        }
        return true;
    }

    public void setOriginPoint(PVector pos) {
        originPoint = pos;
    }

    public void setOffset(PVector offset) {
        this.offset = offset;
    }

    public PVector getOffset() {
        if (!metaData.equals("PLR")) {
            return new PVector(offset.x - mainCam.CFrame.x, offset.y - mainCam.CFrame.y);
        }
        return this.offset;
    }

    public int getXBound() {
        return this.xBound;
    }

    public int getYBound() {
        return this.yBound;
    }
    
    public String toString() {
      return this.metaData;
    }

    public void setMetaData(String data) {
        this.metaData = data;
    }
}
