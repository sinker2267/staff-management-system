package Servlet;

import com.alibaba.fastjson.JSON;
import com.sun.xml.internal.ws.client.ClientSchemaValidationTube;
import model.Part;
import model.User;
import util.DBHelper;
import util.MD5Util;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


public class UserServlet extends BaseServlet{
    private List<User> users;
    public void ToRegister(HttpServletRequest request, HttpServletResponse response){
        try {
            request.getRequestDispatcher("/WEB-INF/register.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void ToLogin(HttpServletRequest request, HttpServletResponse response){
        try {
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        } catch (ServletException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public void loginCheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String moblie = request.getParameter("moblie");
        String psd = MD5Util.encode(request.getParameter("psd"));
        String sql = "select * from user where user_moblie = ? and user_psd = ?";
        List<User> list = DBHelper.queryAll(sql, User.class, moblie, psd);
        if(list.size() != 0){
            HttpSession session = request.getSession();
            session.setAttribute("moblie",moblie);
            session.setAttribute("psd",psd);
            session.setAttribute("name",list.get(0).getUserName());
            responseObject(1, response);
        }
        else{
            responseObject(0, response);
        }
    }
    public void registerCheck(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String moblie = request.getParameter("moblie");
        String psd = MD5Util.encode(request.getParameter("psd"));
        String sql = "select * from user where user_name = ? and user_moblie = ?";
        List<User> list = DBHelper.queryAll(sql, User.class, name, moblie);
        if(list.size() != 0){
            responseObject(0, response);
            return;
        }
        else {
            String inserSql = "insert into user (user_name, user_moblie, user_psd)values(?,?,?)";
            int row = DBHelper.deal(inserSql, name, moblie, psd);
            if(row == 1){
                HttpSession session = request.getSession();
                session.setAttribute("moblie",moblie);
                session.setAttribute("psd",psd);
                session.setAttribute("name",name);
                responseObject(1, response);
            }
            else{
                responseObject(0, response);
            }
        }
    }
    public void ToMain(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/main.jsp").forward(request, response);
    }
    public void ToStaffList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GetStaffData(request,response);
        request.getRequestDispatcher("/WEB-INF/StaffList.jsp").forward(request, response);
    }
    public void GetStaffData(HttpServletRequest request, HttpServletResponse response){
        if(this.users==null){
            String sql = "select * from user";
            List<User> list = DBHelper.queryAll(sql, User.class, null);
            request.setAttribute("user",list);
        }
        else{
            request.setAttribute("user",this.users);
        }

    }
    public void selectById(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        //System.out.println(id);
        String sql = "select * from user where id = ?";
        List<User> list = DBHelper.queryAll(sql, User.class, id);
        User part = list.get(0);
        responseObject(JSON.toJSONString(part),response);
    }
    public void updateStaff(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("userId"));
        String name = request.getParameter("userName");
        String moblie = request.getParameter("userMobile");
        String part = request.getParameter("uaerPart");
//        System.out.println(id+" "+name+" "+moblie+" "+part);
        String sql = "update user set user_name=?,user_moblie=?,user_part=? where id=?";
        int res = DBHelper.deal(sql,name,moblie,part,id);
        ToStaffList(request,response);
    }
    public void deleteById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String sql = "delete from user where id = ?";
        int res = DBHelper.deal(sql,id);
        ToStaffList(request,response);
    }
    public void selectUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("inputName");
        String moblie = request.getParameter("inputMoblie");
        String part = request.getParameter("inputPart");
        if(name==null && moblie == null && part==null) return;
        String sql = "select * from user where ";
        boolean flag = false;
        List<String> list = new ArrayList<>();
        if(name != null && name.length() > 0){
            if(flag ==  true) sql+=" and ";
            sql += "user_name = ?";
            flag = true;
            list.add(name);
        }
        if(moblie != null && moblie.length() > 0){
            if(flag ==  true) sql+=" and ";
            sql += "user_moblie = ?";
            flag = true;
            list.add(moblie);
        }
        if(part != null && part.length() > 0){
            if(flag ==  true) sql+=" and ";
            sql += "user_part = ?";
            flag = true;
            list.add(part);
        }
        this.users = DBHelper.queryAll(sql,User.class,list.toArray());
        for (User re : this.users) {
            System.out.println(re.getUserName());
        }
        responseObject(1,response);
        ToStaffList(request,response);
        //request.getRequestDispatcher("/WEB-INF/StaffList.jsp").forward(request, response);
    }
}
