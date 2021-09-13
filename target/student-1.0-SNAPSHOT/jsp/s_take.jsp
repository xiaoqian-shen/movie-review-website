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
    List<Course> courses = new ArrayList();
    String username;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        username = session.getAttribute("username").toString();
        if (conn != null) {
            PreparedStatement pStmt = conn.prepareStatement("select course_name,credit,teacher_name,start_day,start_time,info from takes natural join student natural join course natural join teaches join teacher using(teacher_id) where student_id='" + username + "'");
            ResultSet rs = pStmt.executeQuery();
            while(rs.next()){
                Course course=new Course();
                course.course_name=rs.getString("course_name");
                course.credit=rs.getString("credit");
                course.info=rs.getString("info");
                course.start_day=rs.getString("start_day");
                course.start_time=rs.getString("start_time");
                course.teacher_name=rs.getString("teacher_name");
                courses.add(course);
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
        <div class="panel-head"><strong class="icon-reorder"> 已选课程</strong></div>
        <div class="padding border-bottom">
        </div>
        <table class="table table-hover text-center">
            <tr>
                <th>课程名称</th>
                <th>学分</th>
                <th>考核方式</th>
                <th>开课时间</th>
                <th>上课时间</th>
                <th>任课教师</th>
            </tr>
            <%
                int i=0;
                for(i=0;i<courses.size();i++){
                    Course score=courses.get(i);
            %>
            <tr>
                <td><%out.print(score.course_name);%></td>
                <td><%out.print(score.credit);%></td>
                <td><%out.print(score.info);%></td>
                <td><%out.print(score.start_day);%></td>
                <td><%out.print(score.start_time);%></td>
                <td><%out.print(score.teacher_name);%></td>
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

    function del(id){
        if(confirm("您确定要删除吗?")){

        }
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