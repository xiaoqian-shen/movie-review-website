<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="test.Course"%>
<%@ page import="test.Score" %>
<%@ page import="java.util.TreeSet" %>
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
    int course_num;
    String course_name=null;
    if(request.getParameter("cid")!=null)
        course_num=Integer.parseInt(request.getParameter("cid"));
    else
        course_num=0;
    Object obj = session.getAttribute("username");
    if(obj == null){
        out.println("<script language='javascript'>alert('请先登录');window.location.href='t_login.jsp';</script>");
    }
    else{
        if(!session.getAttribute("role").toString().equals("teacher"))
            out.println("<script language='javascript'>alert('权限不够');window.location.href='home.jsp';</script>");
    }
    String username;
    List<Score> scores = new ArrayList();
    List<String> class_ids=new ArrayList();
    List<String> course_names=new ArrayList();
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        username = session.getAttribute("username").toString();
        if (conn != null) {
            PreparedStatement pStmt = conn.prepareStatement("select course_id,course_name,student_name,student_id,score,class_id from teaches natural join takes natural join course natural join student where teacher_id='"+username+"' order by class_id,course_name");
            ResultSet rs = pStmt.executeQuery();
            while(rs.next()){
                Score score=new Score();
                score.course_name=rs.getString("course_name");
                score.student_name=rs.getString("student_name");
                score.student_id=rs.getString("student_id");
                score.course_id=rs.getString("course_id");
                score.score=rs.getString("score");
                score.class_id=rs.getString("class_id");
                if(!class_ids.contains(score.class_id))
                    class_ids.add(score.class_id);
                if(!course_names.contains(score.course_name))
                    course_names.add(score.course_name);
                scores.add(score);
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
<form method="post" action="" id="listform">
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 内容列表</strong> <a href="" style="float:right; display:none;">添加字段</a></div>
        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">
                <if condition="$iscid eq 1">
                    <li>
                        <select name="cid" class="input" style="width:200px; line-height:17px;" onchange="window.location=this.value;">
                            <option value="">--选择课程--</option>
                            <%
                                course_name=course_names.get(0);
                                for(int i=0;i<course_names.size();i++){
                                    if(i==course_num){
                                        course_name=course_names.get(i);
                            %>
                            <option value="t_score.jsp?cid=<%=i%>" selected><%out.print(course_names.get(i));%></option>
                            <%
                                }else{
                            %>
                            <option value="t_score.jsp?cid=<%=i%>"><%out.print(course_names.get(i));%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </li>
                </if>
                <li>
                    <select style="width: 73px;" name="s_isvouch" class="input" onchange="changesearch()"  style="width:60px; line-height:17px;display:inline-block">
                        <option value="">--班级--</option>
                        <%
                            for(int i=0;i<class_ids.size();i++){
                        %>
                        <option value="0"><%out.print(class_ids.get(i));%></option>
                        <%
                            }
                        %>
                    </select>
                    &nbsp;&nbsp;
                </li>
                <li>
                    <input type="text" placeholder="请输入搜索关键字" name="keywords" class="input" style="width:250px; line-height:17px;display:inline-block" />
                    <a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()" > 搜索</a></li>
            </ul>
        </div>
        <table class="table table-hover text-center" style="max-width: 70%">
            <tr>
                <th width="100" style="text-align:left; padding-left:20px;"></th>
                <th>学号</th>
                <th>姓名</th>
                <th>成绩</th>
                <th width="310">操作</th>
            </tr>
            <volist name="list" id="vo">
                <%
                    for(int i=0;i<scores.size();i++){
                        Score score=scores.get(i);
                        if(score.course_name.equals(course_name))
                            {
                %>
                <tr>
                    <td style="text-align:left; padding-left:20px;"><input type="checkbox" name="id[]" value="" />
                        </td>
                    <td><%out.print(score.student_id);%></td>
                    <td><%out.print(score.student_name);%></td>
                    <%
                        if(score.score!=null){
                    %>
                    <td><font color="#00CC99"><%out.print(score.score);%></font></td>
                    <%
                        }else{
                    %>
                    <td>待录入</td>
                    <%
                        }
                    %>
                    <td><div class="button-group"> <a class="button border-main" href="t_score_change.jsp?student_id=<%=score.student_id%>&student_name=<%=score.student_name%>&score=<%=score.score%>&course_id=<%=score.course_id%>"><span class="icon-edit"></span> 修改</a></div></td>
                </tr>
                    <%
                    }
                        }
                    %>
                <tr>
                    <td colspan="8"><div class="pagelist"> <a href="">上一页</a> <span class="current">1</span><a href="">2</a><a href="">3</a><a href="">下一页</a><a href="">尾页</a> </div></td>
                </tr>
        </table>
    </div>
</form>
<script type="text/javascript">

    //搜索
    function changesearch(cid){
window.location.href="test.jsp?cid="+cid;
    }

    //单个删除
    function del(id,mid,iscid){
        if(confirm("您确定要删除吗?")){

        }
    }

    //全选
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

    //批量删除
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
            $("#listform").submit();
        }
        else{
            alert("请选择您要删除的内容!");
            return false;
        }
    }

    //批量排序
    function sorts(){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){

            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");
            return false;
        }
    }


    //批量首页显示
    function changeishome(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){

            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");

            return false;
        }
    }

    //批量推荐
    function changeisvouch(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){


            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");

            return false;
        }
    }

    //批量置顶
    function changeistop(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){

            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");

            return false;
        }
    }


    //批量移动
    function changecate(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){

            $("#listform").submit();
        }
        else{
            alert("请选择要操作的内容!");

            return false;
        }
    }

    //批量复制
    function changecopy(o){
        var Checkbox=false;
        $("input[name='id[]']").each(function(){
            if (this.checked==true) {
                Checkbox=true;
            }
        });
        if (Checkbox){
            var i = 0;
            $("input[name='id[]']").each(function(){
                if (this.checked==true) {
                    i++;
                }
            });
            if(i>1){
                alert("只能选择一条信息!");
                $(o).find("option:first").prop("selected","selected");
            }else{

                $("#listform").submit();
            }
        }
        else{
            alert("请选择要复制的内容!");
            $(o).find("option:first").prop("selected","selected");
            return false;
        }
    }

</script>
</body>
</html>