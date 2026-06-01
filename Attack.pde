public class Attack {
    int triangleSwoop = 0;
    int circiular = 1;
    private final int mode;
    private final ArrayList<GameObject> preGameWorld;

    public Attack(int mode) {
        this.mode = mode;
        preGameWorld = gameWorld;
    }

    public void load() {
        gameWorld.clear();
    }

    
}