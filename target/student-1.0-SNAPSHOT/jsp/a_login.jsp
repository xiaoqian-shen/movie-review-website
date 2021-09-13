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
</head>
<%session.invalidate();%>
<body>
<div class="image">
    <img src="../imgs/background.jpg" alt="">
</div>
<div class="login">
    <div class="header">
        管理员登录
    </div>
    <form method="post" action="a_dologin.jsp">
        <div class="input">
            <div class="input-border">
                <input type="text" class="border" name="username" placeholder="用户名" required="required">
            </div>
            <div class="input-border">
                <input type="password" class="border" name="password" placeholder="密码" required="required">
            </div>
        </div>
        <input class="btn-login" type="submit" value="login">
    </form>
    <div class="prompt">
        <p>第三方登录</p>
    </div>
    <div class="icon">
        <!--        <p>第三方登录</p>-->
        <i class="iconfont icon-qq"><img src="../images/微信.svg" alt=""></i>
        <i class="iconfont icon-weibo"><img src="../images/微博.svg" alt=""></i>
        <i class="iconfont icon-weixin"><img src="../images/QQ.svg" alt=""></i>
        <p><a href="./register.jsp">注册账户</a></p>
    </div>
</div>
</body>

</html>