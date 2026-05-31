public class Attack extends Event {
    int triangleSwoop = 0;
    int circiular = 1;

    public Attack(int mode) {
        super("Battle in mode " + mode, 
        () -> {
            switch(mode) {
                case 0:
                 // Create game objects with pvectors in random down facing directions, set parent to string "Projectile"
                
                break;
                    
                case 1:
                break;
            }
        });
    }
}