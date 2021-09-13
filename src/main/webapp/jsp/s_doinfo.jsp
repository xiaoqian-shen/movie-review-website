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
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
        String username = "root";  //数据库用户名
        String password = "root";  //数据库用户密码
        Connection conn = DriverManager.getConnection(url, username, password);  //连接状态

        if (conn != null) {
            username = session.getAttribute("username").toString();
            String student_name = request.getParameter("student_name");
            String birth_place = request.getParameter("birth_place");
            String student_id = request.getParameter("student_id");
            String sex = request.getParameter("sex");
            String nation = request.getParameter("nation");
            String status = request.getParameter("status");
            String department = request.getParameter("department");
            String class_id = request.getParameter("class_id");
            String phone_number = request.getParameter("phone_number");
            String card_id = request.getParameter("card_id");

            PreparedStatement tmt = conn.prepareStatement("UPDATE student SET student_name='"+student_name+"', birth_place = '"+birth_place+"', sex='"+sex+"', nation='"+nation+"', status='"+status+"', department_name='"+department+"', class_id='"+class_id+"',phone_number='"+phone_number+"',card_id='"+card_id+"' WHERE student_id = '" + username + "'");
            int rst = tmt.executeUpdate();
            if (rst != 0) {
                out.println("<script language='javascript'>alert('修改成功');window.location.href='s_info.jsp';</script>");
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
        out.println("<script language='javascript'>alert('数据库操作失败');window.location.href='s_info.jsp';</script>");
    }
%>
</body>
</html>