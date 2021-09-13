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
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        String username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态

        if (conn != null) {
            String score=request.getParameter("score");
            String student_id=request.getParameter("student_id");
            String course_id=request.getParameter("course_id");

            PreparedStatement tmt = conn.prepareStatement("UPDATE takes set score='"+score+"' where student_id='"+student_id+"' and course_id='"+course_id+"'");
            int rst = tmt.executeUpdate();
            if (rst != 0) {
                out.println("<script language='javascript'>alert('修改成功');window.location.href='t_score.jsp';</script>");
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
        out.print("2");
    }
%>
</body>
</html>