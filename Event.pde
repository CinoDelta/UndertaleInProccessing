public class Event {
    private final Runnable event;
    private final int startDelayMiliSeconds;
    private final int endDelayMiliSeconds;
    private final String name;
    private final Supplier<Boolean> startCondition;
    private boolean isFinished;
    

    public Event(String name, Runnable event) {
        this(name, 0, event, 0);
    }

    public Event(String name, Runnable event, float delaySeconds) {
        this(name, 0, event, delaySeconds);
    }

    public Event(String name, float startDelaySeconds, Runnable event, float endDelaySeconds) {
        endDelayMiliSeconds = (int) endDelaySeconds * 1000;
        startDelayMiliSeconds = (int) startDelaySeconds * 1000;
        isFinished = false;
        startCondition = () -> true;
        this.name = name;
        this.event = () -> {
                delay(startDelayMiliSeconds);
                event.run();
                delay(endDelayMiliSeconds);
                isFinished = true;
        };
    }

    public Event(String name, Supplier<Boolean> startCondition, Runnable event) {
        endDelayMiliSeconds = 0;
        startDelayMiliSeconds = 0;
        isFinished = false;
        this.name = name;
        this.startCondition = startCondition;
        this.event = () -> {
                if (startCondition.get() && !isFinished) {
                    delay(startDelayMiliSeconds);
                    event.run();
                    delay(endDelayMiliSeconds);
                    isFinished = true;
                } else {
                    schedule(); // reschedules until start condition met
                }

        };
    }

    public void start() {
        event.run();
    }

    public Event schedule() {
        eventSequence.push(this);
        return this;
    }


    public Runnable getEvent() {
        return event;
    }
    public boolean isFinished() {
        return isFinished;
    }

    public String getname() {
        return name;
    }

    public boolean isSchedualed() {
        return eventSequence.contains(this);
    }
}