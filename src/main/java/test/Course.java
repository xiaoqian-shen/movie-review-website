package test;

public class Course {
    public String course_id;
    public String course_name;
    public String credit;
    public String info;
    public String hour;
    public String teacher_name;
    public String start_day;
    public String start_time;
    public int flag=0;
    public void print_course(){
        System.out.print(course_id);
        System.out.print(course_name);
        System.out.print(credit);
        System.out.print(info);
        System.out.print(hour);
        System.out.println(teacher_name);
    }
}
