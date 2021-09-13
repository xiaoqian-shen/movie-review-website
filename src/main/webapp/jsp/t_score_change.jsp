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
        out.println("<script language='javascript'>alert('请先登录');window.location.href='t_login.jsp';</script>");
    }
    else{
        if(!session.getAttribute("role").toString().equals("teacher"))
            out.println("<script language='javascript'>alert('权限不够');window.location.href='home.jsp';</script>");
    }
    String score=request.getParameter("score");
    String student_id=request.getParameter("student_id");
    String student_name=request.getParameter("student_name");
    String course_id=request.getParameter("course_id");
%>
<form method="post" class="form-x" action="t_dochange.jsp?student_id=<%=student_id%>&course_id=<%=course_id%>" accept-charset="UTF-8">
    <tr>
        <td>姓名：</td>
        <%out.println(student_name);%>
    </tr><br><br>
    <tr>
        <td>分数：</td>
        <input name="score" value="<%out.println(score);%>">
    </tr><br><br>
    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button></form>
</html>
