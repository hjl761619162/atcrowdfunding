<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="UTF-8">
<%@ include file="/WEB-INF/include-head.jsp" %>
<link rel="stylesheet" href="css/pagination.css"/>
<script type="text/javascript" src="script/jquery.pagination.js"></script>
<script type="text/javascript">
    $(function () {

        // 对分页导航条显示进行初始化
        initPagination();

        // 全选/全不选功能
        $("#summaryBox").click(function () {

            // 获取当前#summaryBox的勾选状态
            // this代表当前多选框对象（DOM对象）
            // checked属性为true时表示被勾选，为false时表示没有被勾选
            // 使用checkStatus设置.itemBox的状态
            $(".itemBox").prop("checked", this.checked);
        });

        // 给批量删除按钮绑定单击响应函数
        $("#batchRemoveBtn").click(function () {

            // 创建数组对象
            var adminIdArray = new Array();

            // 通过jQuery选择器定位到所有被选中itemBox，然后遍历
            $(".itemBox:checked").each(function () {

                <%-- <input adminId="${admin.id }" class="itemBox" type="checkbox"> --%>
                // this.adminId拿不到值，原因是：this作为DOM对象无法读取HTML标签本身没有的属性
                // 将this转换为jQuery对象调用attr()函数就能够拿到值
                var adminId = $(this).attr("adminId");

                // 调用数组对象的push()方法将数据存入数组
                adminIdArray.push(adminId);

            });

            // 将JSON数组转换为JSON字符串
            // var a = [1,2,3,4,5];					数组类型
            // var b = "[1,2,3,4,5]";				字符串类型
            // var c = {"userName":"tom"};			对象类型
            // var d = "{\"userName\":\"tom\"}";	字符串类型
            var requestBody = JSON.stringify(adminIdArray);

            // 发送Ajax请求将adminIdArray发送给handler方法
// 			$.ajax({
// 				"url":"admin/batch/remove.json",	// 服务器端接收请求的URL地址
// 				"type":"post",	// 设置请求方式为POST
// 				"contentType":"application/json;charset=UTF-8",	// 设置请求体内容类型，告诉服务器当前请求体发送的是JSON数据
// 				"data":requestBody,	// 请求体真正要发送给服务器的数据
// 				"dataType":"json",		// 把服务器端返回的数据当作JSON格式解析
// 				"success":function(response) {		// 服务器处理请求成功后执行的函数，响应体以参数形式传入当前函数
// 					alert(response);
// 				},
// 				"error":function(response) {	// 服务器处理请求失败后执行的函数，响应体以参数形式传入当前函数
// 					alert(response);
// 				}
// 			});
            $.ajax({
                "url": "admin/batch/remove.json",
                "type": "post",
                "contentType": "application/json;charset=UTF-8",
                "data": requestBody,
                "dataType": "json",
                "success": function (response) {
                    alert(response);
                },
                "error": function (response) {
                    alert(response);
                }
            });
        });

    });

    // 声明函数封装导航条初始化操作
    function initPagination() {

        // 声明变量存储总记录数
        var totalRecord = ${requestScope['PAGE-INFO'].total};

        // 声明变量存储分页导航条显示时的属性设置
        var paginationProperties = {
            num_edge_entries: 3,			//边缘页数
            num_display_entries: 5,		//主体页数
            callback: pageselectCallback,	//回调函数
            items_per_page: ${requestScope['PAGE-INFO'].pageSize},	//每页显示数据数量，就是pageSize
            current_page: ${requestScope['PAGE-INFO'].pageNum - 1},//当前页页码
            prev_text: "上一页",			//上一页文本
            next_text: "下一页"			//下一页文本
        };

        // 显示分页导航条
        $("#Pagination").pagination(totalRecord, paginationProperties);
    }

    // 在每一次点击“上一页”、“下一页”、“页码”时执行这个函数跳转页面
    function pageselectCallback(pageIndex, jq) {

        // pageIndex从0开始，pageNum从1开始
        var pageNum = pageIndex + 1;

        // 跳转页面
        window.location.href = "admin/query/for/search.html?pageNum=" + pageNum + "&keyword=${param.keyword}";

        return false;
    }

</script>
<body>

<%@ include file="/WEB-INF/include-nav.jsp" %>
<div class="container-fluid">
    <div class="row">
        <%@ include file="/WEB-INF/include-sidebar.jsp" %>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        <i class="glyphicon glyphicon-th"></i> 数据列表
                    </h3>
                </div>
                <div class="panel-body">
                    <form action="admin/query/for/search.html" class="form-inline" role="form" style="float: left;"
                          method="post">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input
                                        name="keyword"
                                        class="form-control has-success"
                                        type="text"
                                        placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning">
                            <i class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button
                            id="batchRemoveBtn"
                            type="button"
                            class="btn btn-danger"
                            style="float: right; margin-left: 10px;">
                        <i class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary"
                            style="float: right;" onclick="window.location.href='add.html'">
                        <i class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear: both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr>
                                <th width="30">#</th>
                                <th width="30"><input id="summaryBox" type="checkbox"></th>
                                <th>账号</th>
                                <th>名称</th>
                                <th>邮箱地址</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:if test="${empty requestScope['PAGE-INFO'].list }">
                                <tr>
                                    <td style="text-align: center;" colspan="6">抱歉！没有符合您要求的查询结果！</td>
                                </tr>
                            </c:if>
                            <c:if test="${!empty requestScope['PAGE-INFO'].list }">
                                <c:forEach items="${requestScope['PAGE-INFO'].list }"
                                           var="admin" varStatus="myStatus">
                                    <tr>
                                        <td>${myStatus.count }</td>
                                        <td><input adminId="${admin.id }" class="itemBox" type="checkbox"></td>
                                        <td>${admin.loginAcct }</td>
                                        <td>${admin.userName }</td>
                                        <td>${admin.email }</td>
                                        <td>
                                            <button type="button" class="btn btn-success btn-xs">
                                                <i class=" glyphicon glyphicon-check"></i>
                                            </button>
                                            <button type="button" class="btn btn-primary btn-xs">
                                                <i class=" glyphicon glyphicon-pencil"></i>
                                            </button>
                                            <button type="button" class="btn btn-danger btn-xs">
                                                <i class=" glyphicon glyphicon-remove"></i>
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td colspan="6" align="center">
                                    <div id="Pagination" class="pagination">
                                        <!-- 这里显示分页 -->
                                    </div>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>