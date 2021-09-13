<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="test.Student"%>
<%@ page import="test.Course" %>
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
        if(!session.getAttribute("role").toString().equals("admin"))
            out.println("<script language='javascript'>alert('权限不够');window.location.href='home.jsp';</script>");
    }
    String student_id = request.getParameter("student_id");
    String student_name = request.getParameter("student_name");
    String department_name = request.getParameter("department_name");
    String sex = request.getParameter("sex");
    String birth_place = request.getParameter("birth_place");
%>
<form method="post" class="form-x" action="a_do_change_student.jsp" accept-charset="UTF-8">
    <tr>
        <td>学号：</td>
        <input name="student_id" onfocus="this.blur();" value="<%out.println(student_id);%>">
    </tr><br><br>
    <tr>
        <td>姓名：</td>
        <input name="student_name" value="<%out.println(student_name);%>">
    </tr><br><br>
    <tr>
        <td>性别：</td>
        <input name="sex" value="<%out.println(sex);%>">
    </tr><br><br>
    <tr>
        <td>学院：</td>
        <input name="department_name" value="<%out.println(department_name);%>">
    </tr><br><br>
    <tr>
        <td>出生地：</td>
        <input name="birth_place" value="<%out.println(birth_place);%>">
    </tr><br><br>
    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button></form>
</html>
