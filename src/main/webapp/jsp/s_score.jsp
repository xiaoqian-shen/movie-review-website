<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="test.Course"%>
<%@ page import="test.Score" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="../css/pintuer.css">
    <link rel="stylesheet" href="../css/admin.css">
    <script src="../js/jquery.js"></script>
    <script src="../js/pintuer.js"></script>
</head>
<body>
<%
    Object obj = session.getAttribute("username");
    if(obj == null){
        out.println("<script language='javascript'>alert('请先登录');window.location.href='a_login.jsp';</script>");
    }
    else{
        if(!session.getAttribute("role").toString().equals("student"))
            out.println("<script language='javascript'>alert('权限不够');window.location.href='home.jsp';</script>");
    }
    String username;
    List<Score> scores = new ArrayList();
    float gpa=0;
    float credit_gained=0;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        username = session.getAttribute("username").toString();
        if (conn != null) {
            PreparedStatement pStmt = conn.prepareStatement("select GPA, course_name,credit,score from takes natural join student natural join course where student_id='" + username + "' and score is not null");
            ResultSet rs = pStmt.executeQuery();
            while(rs.next()){
                Score score=new Score();
                score.course_name=rs.getString("course_name");
                score.credit=rs.getString("credit");
                credit_gained+=rs.getFloat("credit");
                score.score=rs.getString("score");
                scores.add(score);
                gpa=rs.getFloat("GPA");
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
<form method="post" action="">
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 成绩查询</strong></div>
        <div class="padding border-bottom">
            <ul class="search">
                <li>
                    <button type="button"  class="button border-green" id="checkall"><span class="icon-check"></span> 全选</button>
                    <button type="submit" class="button border-red" onclick="del()"><span class="icon-trash-o"></span> 批量删除</button>
                </li>
                <p style="margin-top: 12px;margin-left: 810px;width: 200px;">总学分:<%out.print(String.format("%.1f",credit_gained));%>&nbsp&nbsp均分:<%out.print(String.format("%.2f",gpa));%></p>
            </ul>
        </div>
        <table class="table table-hover text-center" style="width: 70%">
            <tr>
                <th width="120">ID</th>
                <th>课程名称</th>
                <th>学分</th>
                <th>成绩</th>
            </tr>
            <%
                int i=0;
                for(i=0;i<scores.size();i++){
                    Score score=scores.get(i);
            %>
            <tr>
                <td><input type="checkbox" name="id[]" value="1" />
                    <%out.print(i+1);%></td>
                <td><%out.print(score.course_name);%></td>
                <td><%out.print(score.credit);%></td>
                <td><%out.print(score.score);%></td>
            </tr>
            <%
                }
            %>
            <tr>
                <td colspan="8"><div class="pagelist"> <a href="">上一页</a> <span class="current">1</span><a href="">2</a><a href="">3</a><a href="">下一页</a><a href="">尾页</a> </div></td>
            </tr>
        </table>
    </div>
</form>
<script type="text/javascript">

    function del(){
        alert('还想删成绩，做梦');
        window.location.href='s_score.jsp'
    }

    $("#checkall").click(function(){
        $("input[name='id[]']").each(function(){
            if (this.checked) {
                this.checked = false;
            }
            else {
                this.checked = true;
            }
        });
    })

    function DelSelect(){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){
            var t=confirm("您确认要删除选中的内容吗？");
            if (t==false) return false;
        }
        else{
            alert("请选择您要删除的内容!");
            return false;
        }
    }

</script>
</body></html>