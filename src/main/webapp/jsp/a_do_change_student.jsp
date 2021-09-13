<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String username;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        if (conn != null) {
            String student_id = request.getParameter("student_id");
            String student_name = request.getParameter("student_name");
            String department_name = request.getParameter("department_name");
            String sex = request.getParameter("sex");
            String birth_place = request.getParameter("birth_place");
            PreparedStatement tmt = conn.prepareStatement("UPDATE student SET student_name='"+student_name+"',department_name='"+department_name+"',sex='"+sex+"',birth_place='"+birth_place+"' where student_id='"+student_id+"'");
            int rss = tmt.executeUpdate();
            if(rss!=0){
                out.println("<script language='javascript'>alert('修改成功');window.location.href='a_student.jsp';</script>");
            }
        }
        else{
            out.print("连接失败！");
        }
    }catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.print("1");
    }catch (SQLException e){
        e.printStackTrace();
        out.println("<script language='javascript'>alert('数据库操作错误');window.location.href='a_teacher.jsp';</script>");
    }
%>
</body>
</html>