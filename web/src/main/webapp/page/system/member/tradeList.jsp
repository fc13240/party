<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="../../include/tag.jsp" %>
<!DOCTYPE html>
<html lang="zh">
<head>
    <title>个人中心</title>
    <link rel="stylesheet" href="${ctx}/themes/default/css/common/list.css">
    <link rel="stylesheet" href="${ctx}/themes/default/css/common/table.css">
    <%@include file="../../include/commonFile.jsp" %>
</head>
<!--头部-->
<%@include file="../../include/header.jsp" %>
<div class="index-outside">
    <%@include file="../../include/sidebar.jsp" %>
    <!--内容-->
    <section>
        <div class="section-main">
            <%@include file="memberIndex.jsp" %>
            <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                <ul class="layui-tab-title">
                    <li><span class="title f18 ml5 mr5">收益明细</span></li>
                    <li><span class="title f18 ml5 mr5">提现明细</span></li>
                    <li class="layui-this"><span class="title f18 ml5 mr5">交易明细</span></li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item"></div>
                    <div class="layui-tab-item"></div>
                    <div class="layui-tab-item layui-show">
                        <form class="layui-form" action="${ctx}/order/order/tradeList.do" id="myForm" method="post">
                            <input type="hidden" name="pageNo" id="pageNo" value="${page.page}" />
                        </form>
                        <div class="my-act-list-content">
                            <ul class="num">
                                <div class="r">
                                    <li style="cursor: pointer;" class="r"><a class="layui-btn layui-btn-danger layui-btn-small" id="btnExport">导出EXCEL</a></li>
                                </div>
                                <p class="cl"></p>
                            </ul>
                            <div class="cl">
                                <table class="layui-table">
                                    <colgroup>
                                        <col>
                                        <col>
                                        <col>
                                        <col>
                                        <col>
                                        <col>
                                    </colgroup>
                                    <thead>
                                    <tr>
                                        <th>订单名称</th>
                                        <th>订单类型</th>
                                        <th>金额</th>
                                        <th>订单状态</th>
                                        <th>支付方式</th>
                                        <th>下单时间</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:if test="${page.totalCount == 0}">
                                        <tr>
                                            <td colspan="6">
                                                <div class="f16 tc">还没有明细记录</div>
                                            </td>
                                        </tr>
                                    </c:if>
                                    <c:forEach var="orderForm" items="${orderForms}">
                                        <tr>
                                            <td title="${orderForm.title}" onclick="openDialogShow('订单详情','${ctx}/order/order/orderInfo.do?id=${orderForm.id}','450px','570px')">
                                                <div class="member-name ellipsis-1 blue" style="cursor: pointer">${orderForm.title}</div>
                                            </td>
                                            <td>${orderForm.typeName}</td>
                                            <td>￥${orderForm.payment}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${orderForm.status == 0}">
                                                        <span>审核中</span>
                                                    </c:when>
                                                    <c:when test="${orderForm.status == 1}">
                                                        <span>待支付</span>
                                                    </c:when>
                                                    <c:when test="${orderForm.status == 2}">
                                                        <span style="color: red;">已支付</span>
                                                    </c:when>
                                                    <c:when test="${orderForm.status == 3}">
                                                        <span>其它</span>
                                                    </c:when>
                                                    <c:when test="${orderForm.status == 4}">
                                                        <span>已退款</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div>
                                                    <c:choose>
                                                        <c:when test="${orderForm.paymentWay == 1}">微信</c:when>
                                                        <c:when test="${orderForm.paymentWay == 0}">支付宝</c:when>
                                                    </c:choose>
                                                </div>
                                            </td>
                                            <td><fmt:formatDate value="${orderForm.createDate}" pattern="yyyy-MM-dd HH:mm"/></td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="page-content">
                            <c:if test="${page.totalCount > 0}">
                                <div class="l page-totalcount">
								<span class="f14 red">共<b id="totalCount">${page.totalCount}</b>条记录
								</span>
                                </div>
                            </c:if>
                            <div id="page_content" class="page-container"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<!--底部-->
<%@include file="../../include/footer.jsp" %>
<script type="text/javascript" charset="utf-8" src="${ctx}/script/common/list.js"></script>
<script type="text/javascript">

    $(function () {
        //加载分页
        loadPage("page_content", '${page.totalPages}', '${page.page}', '#myForm');


        $("#btnExport").click(function () {
            layer.confirm('确认要导出Excel吗?', {
                icon: 3,
                title: '系统提示'
            }, function (index) {
                var url = "${ctx}/order/order/exportTradeOrder.do";
                var action = $("#myForm").attr("action");
                $("#myForm").attr("action", url);
                $("#myForm").submit();
                $("#myForm").attr("action", action);
                top.layer.close(index);
            });
        });
    })
</script>
</body>
</html>