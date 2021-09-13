<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- 引入图标和页面css文件 -->
    <link rel="stylesheet" href="icon.css">
    <link rel="stylesheet" href="../css/login.css">
    <title>LOGIN</title>
    <style>
        a{ text-decoration:none}
    </style>
</head>
<%session.invalidate();%>
<body>
<div class="image">
    <img src="../imgs/background.jpg" alt="">
</div>
<div class="login">
    <div class="header">
        教务管理系统
    </div>
    <div class="header" style="font-size: 25px;">
        <a class="header" style="color:#80b2ff" href="s_login.jsp">学生登录</a>
    </div>
    <div class="header" style="font-size: 25px;">
        <a class="header" style="color:#80b2ff" href="t_login.jsp">教师登录</a>
    </div>
    <div class="header" style="font-size: 25px;">
        <a class="header" style="color:#80b2ff" href="a_login.jsp">管理员登录</a>
    </div>

</div>
</body>

</html>