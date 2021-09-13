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
        out.print("<script language='javaScript'> alert('无法修改');</script>");
    }
%>
<form method="post" class="form-x" action="s_doinfo.jsp" accept-charset="UTF-8">
    <tr>
        <td>学号：</td>
        <input name="student_id" onfocus="this.blur();" value="<%out.println(student.student_id);%>">
    </tr><br><br>
<tr>
    <td>姓名：</td>
    <input name="student_name" value="<%out.println(student.student_name);%>">
</tr><br><br>
<tr>
    <td>性别：</td>
    <input name="sex" value="<%out.println(student.sex);%>">
</tr><br><br>
<tr>
    <td>民族：</td>
    <input name="nation" value="<%out.println(student.nation);%>">
</tr><br><br>
<tr>
    <td>身份证号：</td>
    <input name="card_id" value="<%out.println(student.card_id);%>">
</tr><br><br>
<tr>
    <td>政治面貌：</td>
    <input name="status" value="<%out.println(student.status);%>">
</tr><br><br>
<tr>
    <td>生源地：</td>
    <input name="birth_place" value="<%out.println(student.place);%>">
</tr><br><br>
<tr>
    <td>学院：</td>
    <input name="department" value="<%out.println(student.department);%>">
</tr><br><br>
<tr>
    <td>班级：</td>
    <input name="class_id" value="<%out.println(student.class_id);%>">
</tr><br><br>
<tr>
    <td>电话：</td>
    <input name="phone_number" value="<%out.println(student.phone_number);%>">
</tr><br><br>
    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button></form>
</html>
