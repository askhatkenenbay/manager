package olibek.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.util.List;

@Controller
@SessionAttributes("home")
public class MyController {
    @Autowired
    MyService myService;
    private final int limit = 10;

    @RequestMapping(value = "/")
    public String showLoginPage(ModelMap model,HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        model.put("order", myService.today(offset(0), limit));
        session.setAttribute("isOlibek",false);
        session.setAttribute("pageNum", 0);
        request.setCharacterEncoding("utf-8");
        return "home";
    }

    @RequestMapping(value = "/", method = RequestMethod.POST, params = {"phoneNum", "price", "address"})
    public String createUser(HttpSession session, HttpServletRequest request, ModelMap model) {
        int pageNum = (int) session.getAttribute("pageNum");
        boolean res =myService.createUser(request.getParameter("phoneNum"), request.getParameter("price"), request.getParameter("address"),request.getParameter("comment"));
        if(res){
            model.put("message","СОЗДАН");
        }else{
            model.put("message","ОШИБКА");
        }
        model.put("order", myService.today(offset(pageNum), limit));
        return "home";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET, params = {"phoneNum"})
    public String getUser(HttpSession session, HttpServletRequest request, ModelMap model) {
        int pageNum = (int) session.getAttribute("pageNum");
        model.put("order", myService.today(offset(pageNum), limit));
        String phoneNum = request.getParameter("phoneNum");
        if(phoneNum != null && !phoneNum.isBlank()){
            try{
                int phone = Integer.parseInt(request.getParameter("phoneNum"));
                if(phone == 2589){
                    session.setAttribute("isOlibek",true);
                }
            }catch (Exception ignored){

            }
        }
        UserStat user = myService.getUser(request.getParameter("phoneNum"));
        if(user != null){
            model.put("info", user);
        }else{
            model.put("message", "no info found");
        }
        return "home";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET, params = {"stat"})
    public String getStat(HttpSession session, HttpServletRequest request, ModelMap model) {
        int pageNum = (int) session.getAttribute("pageNum");
        model.put("order", myService.today(offset(pageNum), limit));
        model.put("stat", myService.getStat());
        //session.setAttribute("message", "get");
        return "home";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET, params = {"bydate"})
    public String byDate(HttpSession session, HttpServletRequest request, ModelMap model) {
        int pageNum = (int) session.getAttribute("pageNum");
        model.put("order", myService.today(offset(pageNum), limit));
        String date = request.getParameter("bydate");
        if(date != null && !date.isBlank()){
            model.put("bydate",myService.getByDate(date));
        }else{
            model.put("err","Ошибка");
        }
        return "home";
    }


    @RequestMapping(value = "/", method = RequestMethod.GET, params = {"export"})
    public String export(HttpSession session, ModelMap model) {
        int pageNum = (int) session.getAttribute("pageNum");
        model.put("order", myService.today(offset(pageNum), limit));
        myService.exportTxt();
        return "home";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET, params = {"before"})
    public String before(HttpSession session, ModelMap model) {

        int pageNum = (int) session.getAttribute("pageNum");
        if (pageNum - 1 >= 0) {
            model.put("order", myService.today(offset(pageNum - 1), limit));
            session.setAttribute("pageNum", --pageNum);
        }else{
            model.put("order", myService.today(offset(pageNum), limit));
        }

        return "home";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET, params = {"after"})
    public String after(HttpSession session, ModelMap model) {
        int pageNum = (int) session.getAttribute("pageNum");
        List<MyModel> list = myService.today(offset(pageNum + 1), limit);
        if (list != null && list.size() != 0) {
            model.put("order",list);
            session.setAttribute("pageNum", ++pageNum);
        }else{
            model.put("order", myService.today(offset(pageNum), limit));
        }
        session.setAttribute("pageNum", pageNum);
        return "home";
    }

    private int offset(int pageNum) {
        return pageNum * limit;
    }
}
