public abstract class BattleScene {
    private final NPC enemy;
    private boolean started;
    private Event[] scenes;
    private int sceneIndex;



    public BattleScene(NPC enemy) {
        this.enemy = enemy; 
        sceneIndex = 0;
        started = false;
    }

    public void defineSequence(Event... events) {
        this.scenes = events;
        for (int i = 0; i< scenes.length; i++) {
            int index = i;
            scenes[i] = new Event(scenes[i].getname(), () -> sceneIndex == index && scenes[index].getStartCriteria().get() , scenes[i].getEvent() );
        }
        
    }

    public void start() {
        if (!started && scenes != null) {
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
            flowerThing);
        // defineSequence( 
        //     new Event(
        //         "Load scene", 
        //         () -> {

        //         }
        //     ),
        //     new Event(
        //         "Dialouge one", 
        //         () -> {

        //         }
        //     ),
        //     new Event(
        //         "Dialouge Two", 
        //         () -> {

        //         }
        //     ),
        //     new Event(
        //         "Dialouge Three", 
        //         () -> {

        //         }
        //     ),
        //     new Event(
        //         "Dialouge Four", 
        //         () -> {

        //         }
        //     ),
        //     new Attack(1),
        //     new Event(
        //         "Start Attack", 
        //         () -> { 
        //             for (GameObject object : gameWorld) {
        //                 if (object.getParent().equals("Projectile")) {
        //                     object.setDirection(new PVector()); // TODO: make facing player
        //                 } 
        //             }
        //         }
        //     ),
        //     new Event(
        //         "Start Attack", 
        //         () -> { 
        //             for (GameObject object : gameWorld) {
        //                 if (object.getParent().equals("Projectile")) {
        //                     object.setDirection(new PVector()); // TODO: make facing player
        //                 } 
        //             }
        //         }
        //     ),
        //     new Event(
        //         "post fight Dialouge 1 ",
        //         () -> true, // Check that fight is over
        //         () -> {

        //         }
        //     )
        // );
    }

}