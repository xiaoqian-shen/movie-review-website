<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="test.Student"%>
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
        if(!session.getAttribute("role").toString().equals("student"))
            out.println("<script language='javascript'>alert('权限不够');window.location.href='home.jsp';</script>");
    }
    Student student=new Student();
    String username;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        if (conn != null) {
            username = session.getAttribute("username").toString();
            PreparedStatement pStmt = conn.prepareStatement("select * from student where student_id = '" + username + "'");
            ResultSet rs = pStmt.executeQuery();
            while(rs.next()){
                student.student_id=rs.getString("student_id");
                student.student_name=rs.getString("student_name");
                student.card_id=rs.getString("card_id");
                student.place=rs.getString("birth_place");
                student.department=rs.getString("department_name");
                student.class_id=rs.getString("class_id");
                student.phone_number=rs.getString("phone_number");
                student.sex=rs.getString("sex");
                student.status=rs.getString("status");
                student.nation=rs.getString("nation");
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
    <td>姓名：<%out.println(student.student_name);%></td>
</tr><br><br>
<tr>
    <td>学号：<%out.println(student.student_id);%></td>
</tr><br><br>
<tr>
    <td>性别：<%out.println(student.sex);%></td>
</tr><br><br>
<tr>
    <td>民族：<%out.println(student.nation);%></td>
</tr><br><br>
<tr>
<tr>
    <td>身份证号：<%out.println(student.card_id);%></td>
</tr><br><br>
<tr>
    <td>政治面貌：<%out.println(student.status);%></td>
</tr><br><br>
<tr>
    <td>生源地：<%out.println(student.place);%></td>
</tr><br><br>
<tr>
    <td>学院：<%out.println(student.department);%></td>
</tr><br><br>
<tr>
    <td>班级：<%out.println(student.class_id);%></td>
</tr><br><br>
<tr>
    <td>电话：<%out.println(student.phone_number);%></td>
</tr><br><br>
<td><div class="button-group"> <a style="margin-left: 10px;" class="button border-blue" href="s_change_info.jsp"><span class="icon-cog"></span>修改</a> </div></td>
</html>
