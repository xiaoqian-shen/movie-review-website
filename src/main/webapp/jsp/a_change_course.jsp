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
    String course_name = request.getParameter("course_name");
    String credit = request.getParameter("credit");
    String info = request.getParameter("info");
    String start_day = request.getParameter("start_day");
    String start_time = request.getParameter("start_time");
    String teacher_name = request.getParameter("teacher_name");
    String course_id = request.getParameter("course_id");
%>
<form method="post" class="form-x" action="a_do_course.jsp" accept-charset="UTF-8">
    <tr>
        <td>课程名称：</td>
        <input name="course_name" value="<%out.println(course_name);%>">
    </tr><br><br>
    <tr>
        <td>课程号：</td>
        <input name="course_id" value="<%out.println(course_id);%>">
    </tr><br><br>
    <tr>
        <td>学分：</td>
        <input name="credit" value="<%out.println(credit);%>">
    </tr><br><br>
    <tr>
        <td>考核方式：</td>
        <input name="info" value="<%out.println(info);%>">
    </tr><br><br>
    <tr>
        <td>开课日期：</td>
        <input name="start_day" value="<%out.println(start_day);%>">
    </tr><br><br>
    <tr>
        <td>上课时间：</td>
        <input name="start_time" value="<%out.println(start_time);%>">
    </tr><br><br>
    <tr>
        <td>任课教师：</td>
        <input name="teacher_name" value="<%out.println(teacher_name);%>">
    </tr><br><br>
    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button></form>
</html>
