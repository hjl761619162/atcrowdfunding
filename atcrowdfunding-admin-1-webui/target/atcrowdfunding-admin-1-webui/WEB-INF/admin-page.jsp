<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<html lang="UTF-8">

<%-- 样式 js 标题 --%>
<%@ include file="/WEB-INF/include-head.jsp" %>

    <link rel="stylesheet" href="css/pagination.css" />
    <script src="script/jquery.pagination.js"/>

    <script type="text/javascript">
        $(function() {
            // 对分页导航条显示进行初始化
            initPagination();

            //全选&全不选功能
            $("#summaryBox").click(function(){

                //获取当前#summaryBox的勾选状态
                //this代表当前多选框对象（DOM对象）
                //check true-勾选 false-没有勾选
                var checkStatus = this.check;
                //使用checkStatus设置.ietmBox的状态
                $(".itemBox").prop("checked",checkStatus);
            });
        });
        // 声明函数封装导航条初始化操作
        function initPagination() {
            // 声明变量存储总记录数
            var totalRecord = ${requestScope['PAGE-INFO'].total};
            // 声明变量存储分页导航条显示时的属性设置
            var paginationProperties = {
                num_edge_entries : 3,			//边缘页数
                num_display_entries : 5,		//主体页数
                callback : pageselectCallback,	//回调函数
                items_per_page : ${requestScope['PAGE-INFO'].pageSize},	//每页显示数据数量，就是pageSize
                current_page : ${requestScope['PAGE-INFO'].pageNum - 1},//当前页页码
                prev_text : "上一页",			//上一页文本
                next_text : "下一页"			//下一页文本
            };
            // 显示分页导航条
            $("#Pagination").pagination(totalRecord, paginationProperties);
        }

        // 在每一次点击“上一页”、“下一页”、“页码”时执行这个函数跳转页面
        function pageselectCallback(pageIndex, jq) {
            // pageIndex从0开始，pageNum从1开始
            var pageNum = pageIndex + 1;
            // 跳转页面
            window.location.href = "admin/query/for/search.html?pageNum="+pageNum+"&keyword=${param.keyword}";
            return false;
        }
    </script>

<body>
<%-- 顶部 --%>
<%@include file="/WEB-INF/include-nav.jsp" %>

<div class="container-fluid">
    <div class="row">

        <%-- 左侧导航栏 --%>
        <%@ include file="/WEB-INF/include-sidebar.jsp" %>

        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form action="admin/query/for/search.html" method="post" class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input  name="keyword"
                                        class="form-control has-success"
                                        type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning">
                            <i class="glyphicon glyphicon-search"></i> 查询
                        </button>
                    </form>
                    <button type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i
                            class=" glyphicon glyphicon-remove"></i> 删除
                    </button>
                    <button type="button" class="btn btn-primary" style="float:right;"
                            onclick="window.location.href='add.html'"><i class="glyphicon glyphicon-plus"></i> 新增
                    </button>
                    <br>
                    <hr style="clear:both;">
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
                                <c:if test="${empty requestScope['PAGE-INFO'].list}">
                                    <tr>
                                        <td style="text-align: center" colspan="6">抱歉！没有符合您要求的查询结果！</td>
                                    </tr>
                                </c:if>
                                <c:if test="${!empty requestScope['PAGE-INFO'].list}">
                                    <c:forEach items="${requestScope['PAGE-INFO'].list}" var="admin" varStatus="myStatus">
                                        <tr>
                                            <td>${myStatus.count}</td>
                                            <td><input class="itemBox" type="checkbox"></td>
                                            <td>${admin.loginAcct}</td>
                                            <td>${admin.userName}</td>
                                            <td>${admin.email}</td>
                                            <td>
                                                <button type="button" class="btn btn-success btn-xs"><i
                                                        class=" glyphicon glyphicon-check"></i></button>
                                                <button type="button" class="btn btn-primary btn-xs"><i
                                                        class=" glyphicon glyphicon-pencil"></i></button>
                                                <button type="button" class="btn btn-danger btn-xs"><i
                                                        class=" glyphicon glyphicon-remove"></i></button>
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
