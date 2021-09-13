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
    <div class="panel-head"><strong><span class="icon-key"></span> 添加管理员</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="a_do_add.jsp">
            <div class="form-group">
                <div class="label">
                    <label for="sitename">管理员姓名：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="admin_name" size="50" placeholder="管理员名"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">管理员号：</label>
                </div>
                <div class="field">
                    <input type="text" class="input w50" name="admin_id" size="50" placeholder="管理员"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="password" size="50" placeholder="请输入密码" data-validate="required:请输入密码" />
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">再次输入密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="repassword" size="50" placeholder="请再次输入密码" data-validate="required:请再次输入密码,repeat#password:两次输入的密码不一致" />
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