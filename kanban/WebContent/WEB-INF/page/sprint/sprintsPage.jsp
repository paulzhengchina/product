<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>计划安排</title>
<LINK rel="Shortcut Icon" href="${pageContext.request.contextPath}/images/icon/shortcut.png" />
<link rel="stylesheet" type="text/css"href="${ pageContext.request.contextPath }/css/common.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/ztree/zTreeStyle.css" type="text/css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/jquery-ui.css" />
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-1.6.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/ztree/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/ztree/jquery.ztree.exedit-3.5.js"></script>

	<style type="text/css">
    

	</style>
</head>
<body>
	<s:hidden name="projectId" value="%{projectId}"></s:hidden>
	<div class="content">
		<div class="header">
			<p class="project_name">
				<s:property value="%{project.name}" />
			</p>
			<p class="page_info">计划</p>
		</div>
		<div class="sprints_overview">
			<s:iterator value="sprints" var="sprint">
			    <div class="parent_sprint">
			        <div class="operations">
			           <a href="#" title="编辑"><img src="${ pageContext.request.contextPath }/images/icon/edit.png" id="<s:property value='%{#story.id}'/>" class="editStory"/></a>
					   <a href="#" title="删除"><img src="${ pageContext.request.contextPath }/images/icon/delete.png" id="<s:property value='%{#story.id}'/>" class="deleteStory"></img></a>
			        </div>
			        <div class="name">
			           <s:property value='%{#sprint.name}' />
			        </div>
			        
			        <div class="date">
			            <s:date name="%{#sprint.startTime}" format="yyyy/MM/dd" /> - <s:date name="%{#sprint.endTime}" format="yyyy/MM/dd" />
			        </div>
			        
			        <div class="child_sprints">
						<s:if test="%{#sprint.subSprints!=null}">
						
							<s:iterator value="%{#sprint.subSprints}">
							    <div class="child_sprint" id="<s:property value='id'/>">
							        <div class="info">
                                      <div class="child_name">
                                           <s:property value='name' />
                                      </div>
										
									  <div class="date">
										<s:date name="startTime" format="yyyy/MM/dd" />
										-
										<s:date name="endTime" format="yyyy/MM/dd" />
									  </div>
									</div>
									
									<div class="child_operations">
									  <div class="flag">
									    ...
									  </div>
									  
									  <ul class="operation_items">
									     <li><a href="#">查看</a></li>
									     <li><a href="#">编辑</a></li>
									     <li><a href="#">删除</a></li>
									  </ul>
									</div>
									<div class="clear"></div>
								</div>
							</s:iterator>
							
						</s:if>
						<div class="clear"></div>
					</div>
					
				</div>
			</s:iterator>
		</div>
	</div>
	<div class="left_menu">
		<jsp:include page="../menu.jsp" flush="true"></jsp:include>
	</div>

</body>
<SCRIPT type="text/javascript">
	$(document)
			.ready(
					function() {
						initialCurrentMenuItem("menu_item_plan");
						prepareNodes();
						rMenu = $("#rMenu");

						$("#menu_item_help")
								.click(
										function() {
											DIALOG = $(".sprint_dialog");
											DIALOG.dialog({
												autoOpen : false,
												title : "设置项目成员",
												modal : true,
												width : 500,
												height : 640,
												close : function() {
												}
											});
											DIALOG
													.load(
															"${pageContext.request.contextPath}/helppages/plan.html")
													.dialog('open');
											customizeDialog();
										});
					});
</SCRIPT>
</html>