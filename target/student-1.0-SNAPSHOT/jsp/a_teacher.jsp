<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="test.Teacher"%>
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
        if(!session.getAttribute("role").toString().equals("admin"))
            out.println("<script language='javascript'>alert('权限不够');window.location.href='home.jsp';</script>");
    }
    String username=request.getParameter("username");
    List<Teacher> teachers = new ArrayList();
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        username = session.getAttribute("username").toString();
        if (conn != null) {
            PreparedStatement pStmt = conn.prepareStatement("select * from teacher");
            ResultSet rs = pStmt.executeQuery();
            while(rs.next()){
                Teacher teacher=new Teacher();
                teacher.teacher_id=rs.getString("teacher_id");
                teacher.teacher_name=rs.getString("teacher_name");
                teacher.department_name=rs.getString("department_name");
                teacher.position=rs.getString("position");
                teachers.add(teacher);
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
        out.print("2");
    }

%>
<form method="post" action="">
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 管理课程</strong></div>
        <div class="padding border-bottom">
            <ul class="search">
                <li>
                    <a type="button"  class="button border-green" href="a_add_teacher.jsp"><span class="icon-check"></span> 添加</a>
                    <button type="submit" class="button border-red" onclick="myfunction()"><span class="icon-trash-o"></span> 批量删除</button>
                </li>
            </ul>
        </div>
        <table class="table table-hover text-center">
            <tr>
                <th width="70">ID</th>
                <th>姓名</th>
                <th>学院</th>
                <th>职称</th>
                <%--<th width="120">留言时间</th>--%>
                <th width="120">操作</th>
            </tr>
            <%
                int i=0;
                for(i=0;i<teachers.size();i++){
                    Teacher teacher=teachers.get(i);
            %>
            <tr>
                <td><input type="checkbox" name="id[]" value="1" />
                    <%out.print(teacher.teacher_id);%></td>
                <td><%out.print(teacher.teacher_name);%></td>
                <td><%out.print(teacher.department_name);%></td>
                <td><%out.print(teacher.position);%></td>
                <td><div class="button-group"> <a class="button border-blue" href="a_change_teacher.jsp?teacher_id=<%=teacher.teacher_id%>&teacher_name=<%=teacher.teacher_name%>&department_name=<%=teacher.department_name%>&position=<%=teacher.position%>"><span class="icon-cog"></span>修改</a> </div></td>
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
    function myfunction(){
        alert('疯了吧,还想全删了?别做梦了');
        window.location.href='a_teacher.jsp';
    }

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