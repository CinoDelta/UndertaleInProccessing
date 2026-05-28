public class Camera {

    public PVector CFrame;

    public Camera(PVector CFrame) {
        this.CFrame = CFrame;
    }

    public void resetCFrame(PVector newFrame) {
        CFrame = newFrame;
    }
}