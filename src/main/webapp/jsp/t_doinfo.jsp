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
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        String username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态

        if (conn != null) {
            String teacher_id = request.getParameter("teacher_id");
            String teacher_name = request.getParameter("teacher_name");
            String department_name = request.getParameter("department_name");
            String position = request.getParameter("position");

            PreparedStatement tmt = conn.prepareStatement("UPDATE teacher SET teacher_name='"+teacher_name+"', position = '"+position+"', department_name='"+department_name+"' WHERE teacher_id = '" + teacher_id + "'");
            int rst = tmt.executeUpdate();
            if (rst != 0) {
                out.println("<script language='javascript'>alert('修改成功');window.location.href='t_info.jsp';</script>");
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