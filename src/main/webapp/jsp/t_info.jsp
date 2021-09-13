<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="test.Teacher"%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="../css/pintuer.css">
    <link rel="stylesheet" href="../css/admin.css">
</head>
<body>

</body>
<%
    Object obj = session.getAttribute("username");
    if(obj == null){
        out.println("<script language='javascript'>alert('请先登录');window.location.href='t_login.jsp';</script>");
    }
    else{
        if(!session.getAttribute("role").toString().equals("teacher"))
            out.println("<script language='javascript'>alert('权限不够');window.location.href='home.jsp';</script>");
    }
    Teacher teacher=new Teacher();
    String username;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        if (conn != null) {
            username = session.getAttribute("username").toString();
            PreparedStatement pStmt = conn.prepareStatement("select * from teacher where teacher_id = '" + username + "'");
            ResultSet rs = pStmt.executeQuery();
            while(rs.next()) {
                teacher.teacher_id = rs.getString("teacher_id");
                teacher.teacher_name = rs.getString("teacher_name");
                teacher.department_name = rs.getString("department_name");
                teacher.position = rs.getString("position");
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
        out.print("<script language='javaScript'> alert('没有权限');</script>");
    }
%>
<tr>
    <td>姓名：<%out.println(teacher.teacher_name);%></td>
</tr><br><br>
<tr>
    <td>工号：<%out.println(teacher.teacher_id);%></td>
</tr><br><br>
<tr>
    <td>学院：<%out.println(teacher.department_name);%></td>
</tr><br><br>
<tr>
    <td>职位：<%out.println(teacher.position);%></td>
</tr><br><br>
<td><div class="button-group"> <a style="margin-left: 10px;" class="button border-blue" href="t_change_info.jsp"><span class="icon-cog"></span>修改</a> </div></td>
</html>
