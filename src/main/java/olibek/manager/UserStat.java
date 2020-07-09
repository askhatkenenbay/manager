package olibek.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class UserStat {
    long totalPrice;
    long totalOrder;
    long averageOrder;
    List<StatNode> priceTotalTop;
    List<StatNode> orderTotalTop;
    List<Node> topAddress;
    List<Integer> weekOrder;
    List<Integer> weekPrice;
    public UserStat(){}

    public UserStat(long totalPrice, long totalOrder, long averageOrder, List<Node> topAddress) {
        this.totalPrice = totalPrice;
        this.totalOrder = totalOrder;
        this.averageOrder = averageOrder;
        this.topAddress = topAddress;
    }

    public List<Node> getTopAddress() {
        return topAddress;
    }

    public void setTopAddress(List<Node> topAddress) {
        this.topAddress = topAddress;
    }

    public List<Integer> getWeekOrder() {
        return weekOrder;
    }

    public void setWeekOrder(HashMap<Integer,Integer> hashMap) {
        List<Integer> list = new ArrayList<>();
        for(int i = 2; i <= 7; i++){
            list.add(hashMap.getOrDefault(i,0));
        }
        list.add(hashMap.getOrDefault(1,0));
        weekOrder = list;
    }

    public List<Integer> getWeekPrice() {
        return weekPrice;
    }

    public void setWeekPrice(HashMap<Integer,Integer> hashMap) {
        List<Integer> list = new ArrayList<>();
        for(int i = 2; i <= 7; i++){
            list.add(hashMap.getOrDefault(i,0));
        }
        list.add(hashMap.getOrDefault(1,0));
        weekPrice = list;
    }

    public long getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(long totalPrice) {
        this.totalPrice = totalPrice;
    }

    public long getTotalOrder() {
        return totalOrder;
    }

    public void setTotalOrder(long totalOrder) {
        this.totalOrder = totalOrder;
    }

    public long getAverageOrder() {
        return averageOrder;
    }

    public void setAverageOrder(long averageOrder) {
        this.averageOrder = averageOrder;
    }

    public List<StatNode> getPriceTotalTop() {
        return priceTotalTop;
    }

    public void setPriceTotalTop(List<StatNode> priceTotalTop) {
        this.priceTotalTop = priceTotalTop;
    }

    public List<StatNode> getOrderTotalTop() {
        return orderTotalTop;
    }

    public void setOrderTotalTop(List<StatNode> orderTotalTop) {
        this.orderTotalTop = orderTotalTop;
    }
}
