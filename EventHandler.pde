public class EventHandler extends Event {

    public EventHandler(String name, Event... events) {
        super(name, () -> {
            for (Event event : events ) {
                event.start();
            }
        });
    }
}