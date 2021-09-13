package test;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;
public class Search {
    static final String driver="com.mysql.jdbc.Driver";
    static final String url="jdbc:mysql://localhost:3306/student?serverTimezone=UTC";
    static final String username="root";
    static final String password="root";
    public void search_student(){
        try {
            Connection conn = DriverManager.getConnection(url, username, password);
            if (conn != null) {
                PreparedStatement pStmt = conn.prepareStatement("select * from student");
                ResultSet rs = pStmt.executeQuery();
                Student student=new Student();
                while(rs.next()){
                    student.student_id=rs.getString("student_id");
                    student.student_name=rs.getString("student_name");
                    student.card_id=rs.getString("card_id");
                    student.place=rs.getString("birth_place");
                    student.department=rs.getString("department");
                    student.class_id=rs.getString("class_id");
                    student.phone_number=rs.getString("phone_number");
                    student.sex=rs.getString("sex");
                    student.status=rs.getString("status");
                    student.nation=rs.getString("nation");
                    student.print_student();
                }
            }
            else{
                System.out.println("连接失败！");
            }
        }catch (SQLException e){
            e.printStackTrace();
            System.out.println("数据库查询失败");
        }
    }
    public void search_course(){
        try {
            Connection conn = DriverManager.getConnection(url, username, password);
            if (conn != null) {
                PreparedStatement pStmt = conn.prepareStatement("select * from teacher natural join teaches as t right join course on course.course_id=t.course_id");
                ResultSet rs = pStmt.executeQuery();
                List<Course> courses = new ArrayList();
                rs.getRow();
                while(rs.next()){
                    Course course=new Course();
                    course.course_id=rs.getString("course_id");
                    course.course_name=rs.getString("course_name");
                    course.credit=rs.getString("credit");
                    course.info=rs.getString("info");
                    course.hour=rs.getString("hour");
                    course.teacher_name=rs.getString("teacher_name");
                    course.print_course();
                    courses.add(course);
                }
            }
            else{
                System.out.println("连接失败！");
            }
        }catch (SQLException e){
            e.printStackTrace();
            System.out.println("数据库查询失败");
        }
    }
}
