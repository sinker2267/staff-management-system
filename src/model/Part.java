package model;

public class Part {
    private int id;
    private String partName;
    private String partLeader;
    private int leaderId;

    public Part(){}

    public Part(int id, String partName, String partLeader, int leaderId) {
        this.id = id;
        this.partName = partName;
        this.partLeader = partLeader;
        this.leaderId = leaderId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public String getPartLeader() {
        return partLeader;
    }

    public void setPartLeader(String partLeader) {
        this.partLeader = partLeader;
    }

    public int getLeaderId() {
        return leaderId;
    }

    public void setLeaderId(int leaderId) {
        this.leaderId = leaderId;
    }
}
