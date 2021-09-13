<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="test.Course"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>教务管理系统</title>
    <link rel="stylesheet" href="../css/pintuer.css">
    <link rel="stylesheet" href="../css/admin.css">
    <script src="../js/jquery.js"></script>
</head>
<%
    Object obj = session.getAttribute("username");
    if(obj == null){
        out.println("<script language='javascript'>alert('请先登录');window.location.href='t_login.jsp';</script>");
    }
    else{
        if(!session.getAttribute("role").toString().equals("teacher"))
            out.println("<script language='javascript'>alert('权限不够');window.location.href='home.jsp';</script>");
    }
%>
<body style="background-color:#f2f9fd;">
<div class="header bg-main">
    <div class="logo margin-big-left fadein-top">
        <h1><img src="../imgs/jlu.jpg" class="radius-circle rotate-hover" height="50" alt="" />教务管理中心</h1>
    </div>
    <div class="head-l"><a class="button button-little bg-green" href="" target="_blank"><span class="icon-home"></span> 前台首页</a> &nbsp;&nbsp;<a href="##" class="button button-little bg-blue"><span class="icon-wrench"></span> 清除缓存</a> &nbsp;&nbsp;<a class="button button-little bg-red" href="t_login.jsp"><span class="icon-power-off"></span> 退出登录</a> </div>
</div>
<div class="leftnav">
    <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
    <h2><span class="icon-user"></span>基本信息</h2>
    <ul style="display:block">
        <li><a href="t_info.jsp" target="right"><span class="icon-caret-right"></span>个人信息</a></li>
        <li><a href="pass.jsp" target="right"><span class="icon-caret-right"></span>修改密码</a></li>
    </ul>
    <h2><span class="icon-pencil-square-o"></span>教学管理</h2>
    <ul>
        <li><a href="t_course.jsp" target="right"><span class="icon-caret-right"></span>教授课程</a></li>
        <li><a href="t_score.jsp" target="right"><span class="icon-caret-right"></span>成绩录入</a></li>
    </ul>
</div>
<script type="text/javascript">
    $(function(){
        $(".leftnav h2").click(function(){
            $(this).next().slideToggle(200);
            $(this).toggleClass("on");
        })
        $(".leftnav ul li a").click(function(){
            $("#a_leader_txt").text($(this).text());
            $(".leftnav ul li a").removeClass("on");
            $(this).addClass("on");
        })
    });
</script>
<ul class="bread">
    <li><a href="{:U('Index/info')}" target="right" class="icon-home"> 首页</a></li>
    <li><a href="##" id="a_leader_txt">信息</a></li>
</ul>
<div class="admin">
    <iframe scrolling="auto" rameborder="0" src="t_info.jsp" name="right" width="100%" height="100%"></iframe>
</div>
<div style="text-align:center;">
    <p>来源:<a href="http://down.admin5.com/" target="_blank">A5源码</a></p>
</div>
</body>
</html>