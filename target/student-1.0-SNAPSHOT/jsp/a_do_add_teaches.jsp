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
            String teacher_name = request.getParameter("teacher_name");
            String course_name = request.getParameter("course_name");
            PreparedStatement pst= conn.prepareStatement("select teacher_id from teacher where teacher_name='"+teacher_name+"'");
            ResultSet rs = pst.executeQuery();
            String teacher_id;
            String course_id;
            if(rs.next()) {
                teacher_id = rs.getString("teacher_id");
                pst = conn.prepareStatement("select course_id from course where course_name='" + course_name + "'");
                rs = pst.executeQuery();
                if (rs.next()) {
                    course_id = rs.getString("course_id");
                    PreparedStatement tmt = conn.prepareStatement("insert into teaches (teacher_id,course_id) values('" + teacher_id + "','" + course_id + "')");
                    int rss = tmt.executeUpdate();
                    if (rss != 0) {
                        out.println("<script language='javascript'>alert('添加成功');window.location.href='a_course.jsp';</script>");
                    }
                }
            }
            else{
                out.print("<script language='javascript'>alert('课程或教师不存在');window.location.href='a_course.jsp';</script>");
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
        out.print("<script language='javascript'>alert('添加失败');window.location.href='a_course.jsp';</script>");
    }
%>
</body>
</html>