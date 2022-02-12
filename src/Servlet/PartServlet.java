package Servlet;

import model.Part;
import model.User;
import util.DBHelper;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
}
