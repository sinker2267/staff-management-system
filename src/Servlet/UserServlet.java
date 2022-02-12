package Servlet;

import model.User;
import util.DBHelper;
import util.MD5Util;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


public class UserServlet extends BaseServlet{
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
        request.getRequestDispatcher("/WEB-INF/StaffList.jsp").forward(request, response);
    }
    public List GetStaffData(HttpServletRequest request, HttpServletResponse response){
        String sql = "select * from user";
        List<User> list = DBHelper.queryAll(sql, User.class, null);
        return list;
    }
//    public void ToPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String target = (String) request.getSession().getAttribute("target");
//        request.getRequestDispatcher(target).forward(request, response);
//    }
}
