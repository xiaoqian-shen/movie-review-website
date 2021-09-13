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
    String username;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态
        if (conn != null) {
            String admin_id = request.getParameter("admin_id");
            String admin_name = request.getParameter("admin_name");
            password=request.getParameter("password");
            PreparedStatement pst= conn.prepareStatement("select * from administer where admin_id='"+admin_id+"'");
            ResultSet rs = pst.executeQuery();
            if(!rs.next()) {
                PreparedStatement tmt = conn.prepareStatement("insert into administer (admin_name,admin_id,password) values('" + admin_name + "','" + admin_id + "',HEX(AES_ENCRYPT('"+password+"','key')))");
                int rss = tmt.executeUpdate();
                if(rss!=0){
                    out.println("<script language='javascript'>alert('添加成功');window.location.href='a_add.jsp';</script>");
                }
            }
            else{
                out.println("<script language='javascript'>alert('该账户已存在');window.location.href='a_add.jsp';</script>");
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
        out.println("<script language='javascript'>alert('数据库操作失败');window.location.href='a_add.jsp';</script>");
    }
%>
</body>
</html>