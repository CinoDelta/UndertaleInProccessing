public class Attack {
    private final Event attack;
    private final int TRIANGLESWOOP = 0;
    private final int CIRCULAR = 1;

    public Attack(Sprite sprite, int attackMode) {
        attack = new Event("Attack " + attackMode, this::runAttack);

    }

    private void runAttack() {
        
    }

    public void attack() { 
        if (!attack.isSchedualed()) attack.schedule();
    }
}