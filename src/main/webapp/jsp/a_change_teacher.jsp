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
        out.println("<script language='javascript'>alert('请先登录');window.location.href='s_login.jsp';</script>");
    }
    String teacher_id = request.getParameter("teacher_id");
    String teacher_name = request.getParameter("teacher_name");
    String department_name = request.getParameter("department_name");
    String position = request.getParameter("position");
%>
<form method="post" class="form-x" action="a_do_change_teacher.jsp" accept-charset="UTF-8">
    <tr>
        <td>教工号：</td>
        <input name="teacher_id" onfocus="this.blur();" value="<%out.println(teacher_id);%>">
    </tr><br><br>
    <tr>
        <td>教师名称：</td>
        <input name="teacher_name" value="<%out.println(teacher_name);%>">
    </tr><br><br>
    <tr>
        <td>学院：</td>
        <input name="department_name" value="<%out.println(department_name);%>">
    </tr><br><br>
    <tr>
        <td>职位：</td>
        <input name="position" value="<%out.println(position);%>">
    </tr><br><br>
    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button></form>
</html>
