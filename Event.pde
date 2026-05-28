
public class Event {
    private final Runnable event;
    private final int startDelayMiliSeconds;
    private final int endDelayMiliSeconds;
    private final String name;
    private boolean isFinished;
    

    public Event(String name, Runnable event) {
        this(name, 0, event, 0);
    }

    public Event(String name, Runnable event, float delaySeconds) {
        this(name, 0, event, delaySeconds);
    }

    public Event(String name, float startDelaySeconds, Runnable event, float endDelaySeconds) {
        this.event = event;
        endDelayMiliSeconds = (int) endDelaySeconds * 1000;
        startDelayMiliSeconds = (int) startDelaySeconds * 1000;
        isFinished = false;
        this.name = name;
    }



    public void start() {
        delay(startDelayMiliSeconds);
        event.run();
        delay(endDelayMiliSeconds);
        isFinished = true;
    }

    public boolean isFinished() {
        return isFinished;
    }

    public String getname() {
        return name;
    }
}