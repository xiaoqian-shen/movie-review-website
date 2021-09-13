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
            String id = request.getParameter("id");
            PreparedStatement pst= conn.prepareStatement("select * from teacher where teacher_id='"+id+"'");
            ResultSet rs = pst.executeQuery();
            if(rs.next()) {
                PreparedStatement tmt = conn.prepareStatement("UPDATE teacher SET password=HEX(AES_ENCRYPT('"+id+"','key')) where teacher_id='"+id+"'");
                int rss = tmt.executeUpdate();
                if(rss!=0){
                    out.println("<script language='javascript'>alert('修改成功');window.location.href='a_pass.jsp';</script>");
                }
            }
            else {
                pst = conn.prepareStatement("select * from student where student_id='" + id + "'");
                rs = pst.executeQuery();
                if(rs.next()) {
                    PreparedStatement tmt = conn.prepareStatement("UPDATE student SET password=HEX(AES_ENCRYPT('"+id+"','key')) where student_id='"+id+"'");
                    int rss = tmt.executeUpdate();
                    if(rss!=0){
                        out.println("<script language='javascript'>alert('修改成功');window.location.href='a_pass.jsp';</script>");
                    }
                }
                else{
                    out.println("<script language='javascript'>alert('用户不存在');window.location.href='a_pass.jsp';</script>");
                }
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
</body>
</html>