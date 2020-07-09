package olibek.manager;

public class Node {
    String address;
    int count;

    public Node(String address, int count) {
        this.address = address;
        this.count = count;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
