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
    request. setCharacterEncoding("UTF-8");
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        String username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态

        if (conn != null) {
            username = request.getParameter("username");
            password = request.getParameter("password");
            PreparedStatement pStmt = conn.prepareStatement("select AES_DECRYPT(UNHEX(password), 'key') as password from teacher where teacher_id = '" + username + "'");
            ResultSet rs = pStmt.executeQuery();
            if(rs.next())
            {
                if(password.equals(rs.getString("password"))){
                    session.setAttribute("username",username);
                    session.setAttribute("role","teacher");
                    response.sendRedirect("t_index.jsp");
                }
                else{
                    out.print("<script language='javaScript'> alert('密码错误');window.location.href='s_login.jsp';</script>");
                }
            }
            else
            {
                out.print("<script language='javaScript'> alert('账号错误');window.location.href='s_login.jsp';</script>");
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