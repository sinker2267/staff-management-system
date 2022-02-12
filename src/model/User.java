package model;

public class User {
    private int id;
    private String userName;
    private String userMoblie;
    private String userPsd;

    public User(){}

    public User(int id, String userName, String userMoblie, String userPsd) {
        this.id = id;
        this.userName = userName;
        this.userMoblie = userMoblie;
        this.userPsd = userPsd;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserMoblie() {
        return userMoblie;
    }

    public void setUserMoblie(String userMoblie) {
        this.userMoblie = userMoblie;
    }

    public String getUserPsd() {
        return userPsd;
    }

    public void setUserPsd(String userPsd) {
        this.userPsd = userPsd;
    }
}
