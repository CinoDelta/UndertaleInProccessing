public class BattleScene {
    private final NPC enemy;
    private boolean started;
    private Event[] scenes;
    private int sceneIndex;



    public BattleScene(NPC enemy, Event... scenes ) {
        this.enemy = enemy; 
        sceneIndex = 0;
        started = false;
        for (int i = 0; i< scenes.length; i++) {
            int index = i;
            scenes[i] = new Event(scenes[i].getname(), () -> sceneIndex == index, scenes[i].getEvent() );
        }
        

    }

    public void start() {
        if (!started) {
            for (Event scene : scenes) {
                scene.schedule();
            }
            started = true;
        }
    }

    public void advance() {
        sceneIndex++;
    }

}



public class BattleOne extends BattleScene {
    public BattleOne() {
        super(
            flowerThing, 
            new Event(
                "Dialouge one", 
                () -> {

                }
            ),
            new Event(
                "Dialouge Two", 
                () -> {

                }
            ),
            new Event(
                "Dialouge Three", 
                () -> {

                }
            ),
            new Event(
                "Dialouge Four", 
                () -> {

                }
            ),
            new Attack(1),
            new Event(
                "Start Attack", 
                () -> { 
                    // for (GameObject object : gameWorld) {
                    //     if (object.getParent().equals("Projectile")) {
                    //         object.setDirection(new PVector());
                    //     }
                    // }
                }
            )
        );
    }
}