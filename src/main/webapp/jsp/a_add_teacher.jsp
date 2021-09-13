<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="../css/pintuer.css">
    <link rel="stylesheet" href="../css/admin.css">
    <script src="../js/jquery.js"></script>
    <script src="../js/pintuer.js"></script>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-key"></span> 添加教师</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="a_do_add_teacher.jsp">
            <div class="form-group">
                <div class="label">
                    <label for="sitename">教师姓名：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="teacher_name" size="50" placeholder="教师姓名"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">教工号：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="teacher_id" size="50" placeholder="教工号"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">学院：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="department_name" size="50" placeholder="学院" data-validate="required:请输入学院" />
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">职称：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="position" size="50" placeholder="职称" data-validate="required:请输入职称" />
                </div>
            </div>

            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit"> 提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body></html>