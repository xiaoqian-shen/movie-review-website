<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String username;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        if (conn != null) {
            String teacher_id = request.getParameter("teacher_id");
            String teacher_name = request.getParameter("teacher_name");
            String department_name = request.getParameter("department_name");
            String position = request.getParameter("position");
            password=teacher_id;
            PreparedStatement pst= conn.prepareStatement("select teacher_id from teacher where teacher_id='"+teacher_id+"'");
            ResultSet rs = pst.executeQuery();
            if(!rs.next()) {
                PreparedStatement tmt = conn.prepareStatement("insert into teacher (teacher_id,teacher_name,department_name,position,password) values('" + teacher_id + "','" + teacher_name + "','"+department_name+"','"+position+"',HEX(AES_ENCRYPT('"+password+"','key')))");
                int rss = tmt.executeUpdate();
                if(rss!=0){
                    out.println("<script language='javascript'>alert('添加成功');window.location.href='a_teacher.jsp';</script>");
                }
            }
            else{
                out.println("<script language='javascript'>alert('该账户已存在');window.location.href='a_add_teacher.jsp';</script>");
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
        out.println("<script language='javascript'>alert('数据库操作失败');window.location.href='a_add_teacher.jsp';</script>");
    }
%>
</body>
</html>