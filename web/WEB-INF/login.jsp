<%--
  Created by IntelliJ IDEA.
  User: 17864
  Date: 2022/2/10
  Time: 20:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>登陆</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/libs/particles/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/base.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/assets/css/login.css" />
</head>
<body>
<!-- particles.js container -->
<div id="particles-js"></div>
<div id="wrapper">
    <div>
        <img src="${pageContext.request.contextPath}/static/assets/img/logo.png" style=""/>
        <h2>与世界分享你的知识、经验和见解</h2>
    </div>
    <nav class="switch_nav">
        <a id="switch_signup" class="switch_btn" onclick="">注册</a>
        <a href="javascript:;" id="switch_login" class="switch_btn on">登陆</a>
        <div class="switch_bottom" id="switch_bottom"></div>
    </nav>
    <div id="login">
        <form style="margin-left: 20px" onsubmit="return false">
            <ul class="group_input">
                <li style="margin-left: 3px">
                    <input type="text" class="mobile required" id="mobile" name="mobile" placeholder="手机号或邮箱" />
                </li>
                <li style="margin-left: 3px">
                    <input type="password" class="psd required" id="psd" name="psd" placeholder="密码" />
                </li>
            </ul>
            <button type="submit" class="submit_btn" id="btnSubmit" onclick="login_btn()">登陆</button>
        </form>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/assets/libs/jquery-1.12.4/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/libs/particles/particles.min.js"></script>
<script src="${pageContext.request.contextPath}/static/assets/libs/particles/js/app.js"></script>
<!-- <script src="${pageContext.request.contextPath}/static/assets/libs/particles/js/lib/stats.js"></script> -->
<script>
    var form = document.getElementsByTagName('form')[0];
    form.addEventListener('submit',function(e){
        e.preventDefault();
    });
    var count_particles, stats, update;
    stats = new Stats;
    stats.setMode(0);
    stats.domElement.style.position = 'absolute';
    stats.domElement.style.left = '0px';
    stats.domElement.style.top = '0px';
    document.body.appendChild(stats.domElement);
    count_particles = document.querySelector('.js-count-particles');
    update = function() {
        stats.begin();
        stats.end();
        if (window.pJSDom[0].pJS.particles && window.pJSDom[0].pJS.particles.array) {
            count_particles.innerText = window.pJSDom[0].pJS.particles.array.length;
        }
        requestAnimationFrame(update);
    };
    requestAnimationFrame(update);
</script>
<script>
    $(function(){
        //为表单的必填文本框添加提示信息（选择form中的所有后代input元素）
        // $("form :input.required").each(function () {
        //     //通过jquery api：$("HTML字符串") 创建jquery对象
        //     var $required = $("<strong class='high'>*</strong>");
        //     //添加到this对象的父级对象下
        //     $(this).parent().append($required);
        // });
        // var errorMsg = $(".error-msg").text();
        //为表单元素添加失去焦点事件
        $("form :input").blur(function(){
            var $parent = $(this).parent();
            $parent.find(".msg").remove(); //删除以前的提醒元素（find()：查找匹配元素集中元素的所有匹配元素）
            //验证手机号
            if($(this).is("#mobile")){
                var mobileVal = $.trim(this.value);
                // var regMobile = /^1[3|4|5|7|8][0-9]{9}$/;
                if(mobileVal == ""){
                    var errorMsg = " 请输入手机号或邮箱！";
                    $parent.append("<span class='msg onError'>" + errorMsg + "</span>");
                } else{
                    var okMsg=" 输入正确";
                    $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                }
            }
            //验证密码
            if($(this).is("#psd")){
                var psdVal = $.trim(this.value);
                var regPsd = /^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/;
                if(psdVal== "" || !regPsd.test(psdVal)){
                    var errorMsg = " 密码为6-20位字母、数字的组合！";
                    $parent.append("<span class='msg onError'>" + errorMsg + "</span>");
                }
                else{
                    var okMsg=" 输入正确";
                    $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                }
            }
        }).keyup(function(){
            //triggerHandler 防止事件执行完后，浏览器自动为标签获得焦点
            $(this).triggerHandler("blur");
        }).focus(function(){
            $(this).triggerHandler("blur");
        });
    })
    function login_btn(){
        var mobile = $("#mobile").val();
        var psd = $("#psd").val();

        console.info(mobile+" " + psd);
        if(mobile == '' ||  psd == ''){
            return;
        }
        console.info(mobile+" "+psd);
        $.ajax({
            url: "UserServlet?method=loginCheck",
            type: "POST",
            data: {"moblie":mobile,"psd":psd},
            success:function (str){
                if(str == 1){
                    alert("登录成功");
                    window.location.href = "UserServlet?method=ToMain";
                }
                else{
                    alert("登录失败，请重新登录");
                }
            },
            error:function (){
                alert("请求失败");
            }
        })
    }
</script>

<script>
    $("#switch_signup").click(function (){
        window.location.href = "UserServlet?method=ToRegister";
    })
</script>
</body>
</html>

