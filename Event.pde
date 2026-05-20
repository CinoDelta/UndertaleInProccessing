import java.util.function.Supplier;

public class Event {
    private final Runnable[] events;

    public Event(Runnable... events) {
        this.events = events;
    }

    public void start() {
        for (Runnable event : events) {
            event.run();
        }
    }

    
}