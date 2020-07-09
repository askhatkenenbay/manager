package olibek.manager;

public class StatNode {
    int phone;
    int value; //price or order

    public StatNode(int phone, int value) {
        this.phone = phone;
        this.value = value;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
