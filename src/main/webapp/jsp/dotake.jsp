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
    String username;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        if (conn != null) {
            username=(String)session.getAttribute("username");
            String s_id = request.getParameter("s_id");
            String c_id = request.getParameter("c_id");
            String action=request.getParameter("action");
            if(action.equals("take")) {
                PreparedStatement pst= conn.prepareStatement("select * from takes where student_id='"+s_id+"' and course_id='"+c_id+"'");
                ResultSet rs = pst.executeQuery();
                if(!rs.next()) {
                    PreparedStatement tmt = conn.prepareStatement("insert into takes (course_id,student_id) values('" + c_id + "','" + s_id + "')");
                    tmt.executeUpdate();
                }
            }
            else{
                PreparedStatement tmt = conn.prepareStatement("delete from takes where course_id = '"+c_id+"' and student_id = '"+s_id+"'");
                tmt.executeUpdate();
            }
            response.sendRedirect("s_course.jsp");
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