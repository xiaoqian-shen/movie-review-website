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
        out.println("<script language='javascript'>alert('请先登录');window.location.href='a_login.jsp';</script>");
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
            while(rs.next()){
                teacher.teacher_id=rs.getString("teacher_id");
                teacher.teacher_name=rs.getString("teacher_name");
                teacher.department_name=rs.getString("department_name");
                teacher.position=rs.getString("position");
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
        out.print("<script language='javaScript'> alert('无法修改');</script>");
    }
%>
<form method="post" class="form-x" action="t_doinfo.jsp" accept-charset="UTF-8">
    <tr>
        <td>教工号：</td>
        <input name="teacher_id" onfocus="this.blur();" value="<%out.println(teacher.teacher_id);%>">
    </tr><br><br>
    <tr>
        <td>姓名：</td>
        <input name="teacher_name" value="<%out.println(teacher.teacher_name);%>">
    </tr><br><br>
    <tr>
        <td>学院：</td>
        <input name="department_name" value="<%out.println(teacher.department_name);%>">
    </tr><br><br>
    <tr>
        <td>职位：</td>
        <input name="position" value="<%out.println(teacher.position);%>">
    </tr><br><br>
    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button></form>
</html>
