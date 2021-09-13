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
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        String username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态

        if (conn != null) {
            username = session.getAttribute("username").toString();
            password = request.getParameter("mpass");
            String password1 = request.getParameter("newpass");

            PreparedStatement pStmt = conn.prepareStatement("select AES_DECRYPT(UNHEX(password), 'key') as password from student where student_id = '" + username + "'");
            ResultSet rs = pStmt.executeQuery();
            if(!rs.next()){

                out.println("<script language='javascript'>alert('原始密码不正确');window.location.href='pass.jsp';</script>");
            }
            else{
                if(password.equals(password1))
                {
                    out.println("<script language='javascript'>alert('新密码不能与旧密码一致');window.location.href='pass.jsp';</script>");
                }
                else {
                    PreparedStatement tmt = conn.prepareStatement("UPDATE student SET password =HEX(AES_ENCRYPT('"+password1+"','key')) WHERE student_id = '"+username+"'");
                    int rst = tmt.executeUpdate();
                    if (rst != 0) {
                        out.println("<script language='javascript'>alert('修改成功');window.location.href='pass.jsp';</script>");
                    }
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