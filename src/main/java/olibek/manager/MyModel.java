package olibek.manager;

import lombok.Data;

import javax.persistence.*;
import java.util.Date;


@Entity
@Table(name = "myorder")
@Data
public class MyModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "phone")
    private int phone;

    @Column(name = "price")
    private int price;

    @Column(name = "address")
    private String address;

    @Column(name = "orderdate")
    private Date date;

    @Column(name = "mycomment")
    private String comment;

    public MyModel(){}

    public MyModel(int id, int phone, int price, String address, Date date, String comment) {
        this.id = id;
        this.phone = phone;
        this.price = price;
        this.address = address;
        this.date = date;
        this.comment = comment;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPhone() {
        return phone;
    }

    public void setPhone(int phone) {
        this.phone = phone;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public String toString() {
        return "MyModel{" +
                "id=" + id +
                ", phone=" + phone +
                ", price=" + price +
                ", address='" + address + '\'' +
                ", date=" + date +
                ", comment='" + comment + '\'' +
                '}';
    }
}
