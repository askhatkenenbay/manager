package olibek.manager;


import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service("MyService")
public class MyService {
    private final ModelRepository modelRepository;
    @Autowired
    private JdbcTemplate jdbcTemplate;
    public MyService(@Qualifier("modelRepository") ModelRepository modelRepository){
        this.modelRepository = modelRepository;
    }
    public boolean createUser(String phoneNum, String price, String address, String comment) {
        MyModel myModel = new MyModel();
        myModel.setAddress(address);
        myModel.setComment(comment);
        try{
            myModel.setPhone(Integer.parseInt(phoneNum));
            myModel.setPrice(Integer.parseInt(price));
        }catch (NumberFormatException e){
            return false;
        }
        myModel.setDate(new java.util.Date());
        modelRepository.save(myModel);
        return true;
    }

    public UserStat getUser(String phoneNum) {
        List<MyModel> list;
        try{
            list = modelRepository.findByPhone(Integer.parseInt(phoneNum));
        }catch (NumberFormatException exception){
            return null;
        }

        long totalPrice=0;
        long totalOrder=0;
        long averageOrderPrice=0;
        HashMap<String, Integer> hashMap = new HashMap<>();
        String sql = "SELECT SUM (price) AS tprice,COUNT(*) As torder  FROM myorder where phone="+phoneNum;
        Map<String, Object> result =  (Map<String, Object>) jdbcTemplate
                .queryForMap(sql, new Object[] {});
        if(result.isEmpty())return null;
        if(result.get("torder") != null){
            totalOrder = (long) result.get("torder");
        }
        if(result.get("tprice") != null){
            totalPrice = (long) result.get("tprice");
        }
        if(totalOrder!=0){
            averageOrderPrice = totalPrice / totalOrder;
        }
        //System.out.println(totalOrder + "-" + totalPrice + "-" + averageOrderPrice);
        for(MyModel curr : list){
            hashMap.put(curr.getAddress(), hashMap.getOrDefault(curr.getAddress(),0) + 1);
        }
        List<Node> topAddress = sortByValue(hashMap);
        if(topAddress.size()>10){
            topAddress = topAddress.subList(0,10);
        }else{
            topAddress = topAddress.subList(0,topAddress.size());
        }
        return new UserStat(totalPrice,totalOrder,averageOrderPrice,topAddress);
    }

    // function to sort hashmap by values
    private List<Node> sortByValue(HashMap<String, Integer> hm) {
        List<Node> res = new ArrayList<>();
        // Create a list from elements of HashMap
        List<Map.Entry<String, Integer>> list =
                new LinkedList<Map.Entry<String, Integer>>(hm.entrySet());

        // Sort the list
        Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
            public int compare(Map.Entry<String, Integer> o1,
                               Map.Entry<String, Integer> o2) {
                return (o2.getValue()).compareTo(o1.getValue());
            }
        });

        // put data from sorted list to hashmap
        //HashMap<String, Integer> temp = new LinkedHashMap<String, Integer>();
        for (Map.Entry<String, Integer> aa : list) {
            //temp.put(aa.getKey(), aa.getValue());
            res.add(new Node(aa.getKey(),aa.getValue()));
        }
        return res;
    }

    public List<MyModel> today(int offset, int limit) {
        //new java.util.Date()
        String sql = "select * from myorder where orderdate::date = date '"+new java.util.Date()+"' order by orderdate DESC OFFSET "+offset+" LIMIT " + limit;
        List<MyModel> list = jdbcTemplate.query(
                sql,
                (rs, rowNum) -> new MyModel(rs.getInt("id"), rs.getInt("phone"),
                        rs.getInt("price"), rs.getString("address"), rs.getTimestamp("orderdate"), rs.getString("mycomment")));
        list.forEach(System.out::println);
        return list;
    }

    public UserStat getStat() {
        UserStat res = new UserStat();
        long totalPrice;
        long totalOrder;
        long averageOrderPrice;
        List<StatNode> topPrice;
        List<StatNode> topOrder;
        HashMap<Integer,Integer> hashTopPrice = new HashMap<>();
        HashMap<Integer,Integer> hashTopOrder = new HashMap<>();
        String sql = "SELECT SUM (price) AS tprice,COUNT(*) As torder  FROM myorder";
        Map<String, Object> result =  (Map<String, Object>) jdbcTemplate
                .queryForMap(sql, new Object[] {});
        totalOrder = (long) result.get("torder");
        totalPrice = (long) result.get("tprice");
        averageOrderPrice = totalPrice / totalOrder;
        //week of a day
        HashMap<Integer, Integer> hashWeekDayOrder = new HashMap<>();
        HashMap<Integer, Integer> hashWeekDayPrice = new HashMap<>();
        Calendar cal = Calendar.getInstance();
        //
        List<MyModel> list = modelRepository.findAll();
        for(MyModel curr : list){
            hashTopPrice.put(curr.getPhone(), hashTopPrice.getOrDefault(curr.getPhone(),0) + curr.getPrice());
            hashTopOrder.put(curr.getPhone(), hashTopOrder.getOrDefault(curr.getPhone(),0)+1);
            cal.setTime(curr.getDate());
            hashWeekDayOrder.put(cal.get(Calendar.DAY_OF_WEEK),hashWeekDayOrder.getOrDefault(cal.get(Calendar.DAY_OF_WEEK),0)+1);
            hashWeekDayPrice.put(cal.get(Calendar.DAY_OF_WEEK),hashWeekDayPrice.getOrDefault(cal.get(Calendar.DAY_OF_WEEK),0)+curr.getPrice());
        }
        topPrice = sortByValueStat(hashTopPrice);
        topOrder = sortByValueStat(hashTopOrder);
        if(topPrice.size()>10){
            topPrice = topPrice.subList(0,10);
        }else{
            topPrice = topPrice.subList(0, topPrice.size());
        }
        if(topOrder.size()>10){
            topOrder = topOrder.subList(0,10);
        }else{
            topOrder = topOrder.subList(0, topOrder.size());
        }
        res.setWeekOrder(hashWeekDayOrder);
        res.setWeekPrice(hashWeekDayPrice);
        res.setTotalPrice(totalPrice);
        res.setTotalOrder(totalOrder);
        res.setAverageOrder(averageOrderPrice);
        res.setPriceTotalTop(topPrice);
        res.setOrderTotalTop(topOrder);

        return res;
    }

    private List<StatNode> sortByValueStat(HashMap<Integer, Integer> hm) {
        List<StatNode> res = new ArrayList<>();
        // Create a list from elements of HashMap
        List<Map.Entry<Integer, Integer>> list =
                new LinkedList<Map.Entry<Integer, Integer>>(hm.entrySet());

        // Sort the list
        Collections.sort(list, new Comparator<Map.Entry<Integer, Integer>>() {
            public int compare(Map.Entry<Integer, Integer> o1,
                               Map.Entry<Integer, Integer> o2) {
                return (o2.getValue()).compareTo(o1.getValue());
            }
        });

        // put data from sorted list to hashmap
        //HashMap<String, Integer> temp = new LinkedHashMap<String, Integer>();
        for (Map.Entry<Integer, Integer> aa : list) {
            //temp.put(aa.getKey(), aa.getValue());
            res.add(new StatNode(aa.getKey(),aa.getValue()));
        }
        return res;
    }


    /*Calendar cal = Calendar.getInstance();
        cal.setTime(dateInstance);
        cal.add(Calendar.DATE, -30);
        Date dateBefore30Days = cal.getTime();

    Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(Calendar.DAY_OF_WEEK);
*/
    private final String DIV = "---";
    public void exportTxt(){
        File file = new File("src/export.txt");
        file.delete();
        file = new File("src/export.txt");
        FileWriter fr = null;
        List<MyModel> list = modelRepository.findAll();
        try {
            fr = new FileWriter(file, true);
            for(MyModel curr : list){
                fr.write(curr.getId()+DIV+curr.getPhone()+DIV+curr.getAddress()+DIV+curr.getPrice()+DIV+curr.getDate()+DIV+curr.getComment()+"\n");
            }
            fr.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public UserStat getByDate(String bydate) {
        String sql = "SELECT SUM (price) AS tprice,COUNT(*) As torder  FROM myorder WHERE orderdate::date = date '"+bydate+"'";
        Map<String, Object> result =  (Map<String, Object>) jdbcTemplate
                .queryForMap(sql, new Object[] {});
        long totalOrder = (long) result.get("torder");
        long totalPrice = 0;
        if(result.get("tprice") != null){
            totalPrice = (long) result.get("tprice");
        }
        UserStat res = new UserStat();
        res.setTotalOrder(totalOrder);
        res.setTotalPrice(totalPrice);
        return res;
    }
}
