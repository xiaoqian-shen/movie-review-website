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
            String course_name = request.getParameter("course_name");
            String course_id = request.getParameter("course_id");
            String credit = request.getParameter("credit");
            String info = request.getParameter("info");
            String start_day = request.getParameter("start_day");
            String start_time = request.getParameter("start_time");
            String teacher_name = request.getParameter("teacher_name");

            PreparedStatement tmt = conn.prepareStatement("UPDATE course SET course_name='"+course_name+"', credit = '"+credit+"', info='"+info+"', start_day='"+start_day+"', start_time='"+start_time+"' where course_id='"+course_id+"'");
            int rst1 = tmt.executeUpdate();

            PreparedStatement tmt1=conn.prepareStatement("select teacher_id from teacher where teacher_name='"+teacher_name+"'");
            ResultSet rst2=tmt1.executeQuery();
            if(rst2.next()) {
                String teacher_id = rst2.getString("teacher_id");

                tmt1=conn.prepareStatement("select course_id from teaches where course_id='"+course_id+"'");
                rst2=tmt1.executeQuery();

                PreparedStatement tmt2;
                if(rst2.next()) {
                    tmt2 = conn.prepareStatement("UPDATE teaches SET teacher_id='" + teacher_id + "' where course_id='" + course_id + "'");
                }else{
                    tmt2 = conn.prepareStatement("INSERT INTO teaches(course_id,teacher_id) VALUES('"+course_id+"','"+teacher_id+"')");
                }
                int rst3 = tmt2.executeUpdate();
                if (rst3 != 0) {
                    out.println("<script language='javascript'>alert('修改成功');window.location.href='a_course.jsp';</script>");
                } else {
                    out.println("<script language='javascript'>alert('修改失败');window.location.href='a_course.jsp';</script>");
                }
            }
            else{
                out.println("<script language='javascript'>alert('查无此人');window.location.href='a_course.jsp';</script>");
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
        out.println("<script language='javascript'>alert('数据库操作错误');window.location.href='a_course.jsp';</script>");
    }
%>
</body>
</html>