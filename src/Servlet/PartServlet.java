package Servlet;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import model.Part;
import model.User;
import util.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class PartServlet extends BaseServlet{
    public void ToPartList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GetPartData(request,response);
        request.getRequestDispatcher("/WEB-INF/PartList.jsp").forward(request, response);
    }
    public void GetPartData(HttpServletRequest request, HttpServletResponse response){
        String sql = "select * from part";
        List<Part> list = DBHelper.queryAll(sql, Part.class, null);
//        for (User user : list) {
//            System.out.println(user.getPart()+" "+user.getUserName());
//        }
        request.setAttribute("part",list);
    }
    public void test(HttpServletRequest request, HttpServletResponse response){
        System.out.println("haoye");
    }
    public void  selectById(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        //System.out.println(id);
        String sql = "select * from part where id = ?";
        List<Part> list = DBHelper.queryAll(sql, Part.class, id);
        Part part = list.get(0);

        responseObject(JSON.toJSONString(part),response);
        //System.out.println(list.get(0).getPartName()+" "+list.get(0).getPartLeader());
        //request.setAttribute("selectById`",list);
        //ToPartList(request, response);
    }
}
