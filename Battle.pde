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
        }
    }

    public void advance() {
        sceneIndex++;
    }


}

public class Battle extends Event {
    int triangleSwoop = 0;
    int circiular = 1;

    public Battle(int mode, NPC hostile) {
        super("Battle with " + hostile.toString() + " in mode " + mode, 
        () -> {
            switch(mode) {
                case 0:
                break;
                    
                case 1:
                break;
            }
        });
    }
}