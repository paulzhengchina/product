<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><s:property value="project.name" /></title>
<LINK rel="Shortcut Icon" href="${pageContext.request.contextPath}/images/icon/shortcut.png" />
<link rel="stylesheet" type="text/css"
	href="${ pageContext.request.contextPath }/css/common.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/jquery-ui.css" />
<script type="text/javascript"
	src="${ pageContext.request.contextPath }/js/jquery-1.6.2.js"></script>
<script type="text/javascript"
	src="${ pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/scrum-shrink.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/rgraph/RGraph.common.core.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/rgraph/RGraph.common.dynamic.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/rgraph/RGraph.common.tooltips.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/rgraph/RGraph.common.effects.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/rgraph/RGraph.line.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/rgraph/RGraph.common.key.js"></script>


<script>
	$(document).ready(function() {
		
		createProjectBurnDown();
		createTeamVelocity();
		$(".add_member").click(function(){
			DIALOG = $(".addMemeberDialog");
			DIALOG.dialog({autoOpen: false, 
				                    title: "添加项目成员",
					                modal: true,
					                width :360,
					                height:220,
	                                close: function() {}
	                                });
			DIALOG.load("${pageContext.request.contextPath}/project/loadAddMemeberForProject.action?projectId="+$("#projectId").val()).dialog('open'); 
			customizeDialog();
		});
		
	   $(".remove_memeber").click(function(){
		   var id=$(this).attr("id");
		   $.ajax({
				  "url":"${pageContext.request.contextPath }/project/removeAMemberFromProject.action",
				  "type":"post",
				  "data":{userId:$(this).attr("id"),projectId:$("#projectId").val()},
				  "success":function(data,status){
					  if(data){									  
						  $("#"+id).parent().remove();
						  								  								  
					  }
				},
				"error":function(xhr,s1,s2){
					alert('系统出错');
				}
			});
	   });
	   
	   
		
	});
	
	function createProjectBurnDown(){
		$.ajax({
			  "url":"${pageContext.request.contextPath }/statistics/projectBurnDownChart.action",
			  "type":"post",
			  "data":{userId:$(this).attr("id"),projectId:$("#projectId").val()},
			  "success":function(data,status){
				    var line = new RGraph.Line('cvs', data.totalPointOfPoject, data.remainingPointOfProject);
			        line.Set('chart.curvy', true);
			        line.Set('chart.curvy.tickmarks', true);
			        line.Set('chart.curvy.tickmarks.fill', null);
			        line.Set('chart.curvy.tickmarks.stroke', '#aaa');
			        line.Set('chart.curvy.tickmarks.stroke.linewidth', 2);
			        line.Set('chart.curvy.tickmarks.size', 1);
			        line.Set('chart.linewidth', 1);
			        line.Set('chart.hmargin', 5);
			        line.Set('key', ['总工作量','剩余工作量']);
		            line.Set('key.position', 'gutter');
		            line.Set('key.interactive', true);
			        line.Set('chart.labels', data.sprintsEndDate);
			        line.Set('chart.tooltips',changeFloatArrayToStringArray(data.totalPointOfPoject),changeFloatArrayToStringArray(data.remainingPointOfProject));
			        line.Set('chart.tickmarks', 'circle');
			        RGraph.Effects.Line.jQuery.Trace(line);
			},
			"error":function(xhr,s1,s2){
				alert('系统出错');
			}
		});
		
	}
	
	function createTeamVelocity(){
		$.ajax({
			  "url":"${pageContext.request.contextPath }/statistics/teamVelocity.action",
			  "type":"post",
			  "data":{userId:$(this).attr("id"),projectId:$("#projectId").val()},
			  "success":function(data,status){
				    var line = new RGraph.Line('velocity_cvs', data.completedPointOfSprint);
			        line.Set('chart.curvy', true);
			        line.Set('chart.curvy.tickmarks', true);
			        line.Set('chart.curvy.tickmarks.fill', null);
			        line.Set('chart.curvy.tickmarks.stroke', '#aaa');
			        line.Set('chart.curvy.tickmarks.stroke.linewidth', 2);
			        line.Set('chart.curvy.tickmarks.size', 1);
			        line.Set('chart.linewidth', 1);
			        line.Set('chart.hmargin', 5);
			        line.Set('key', ['完成工作量']);
		            line.Set('key.position', 'gutter');
		            line.Set('key.interactive', true);
			        line.Set('chart.labels', substrSprintNames(data.sprintNames) );
			        line.Set('chart.tooltips',changeFloatArrayToStringArray(data.completedPointOfSprint));
			        line.Set('chart.tickmarks', 'circle');
			        RGraph.Effects.Line.jQuery.Trace(line);
			},
			"error":function(xhr,s1,s2){
				alert('系统出错');
			}
		});
		
	}
	
	function changeFloatArrayToStringArray(floatArray){
		var stringArray=new Array();
		if(floatArray!=null){
			for(var i=0;i<floatArray.length;i++){
				stringArray[i]=floatArray[i].toString();
			}
		}		
		return stringArray;
	}
	
	function substrSprintNames(sprintNames){
		var substringArray=new Array();
		if(sprintNames!=null)
			{
			for(var i=0;i<sprintNames.length;i++)
				{
				substringArray[i]=sprintNames[i].substring(0,4);
				}
			}
		return substringArray;
	}
	function customizeDialog(){
		$(".ui-dialog-titlebar button").remove();
		$(".ui-dialog-titlebar").html("<img src='${pageContext.request.contextPath}/images/icon/dialog_close.png'/>");
		$(".ui-dialog-titlebar img").css("position","absolute");
		$(".ui-dialog-titlebar img").css("right","2px");
		$(".ui-dialog-titlebar img").css("height","17px");
		$(".ui-dialog-titlebar img").css("width","17px");
		$(".ui-dialog-titlebar img").css("cursor","pointer");
		$(".ui-dialog-titlebar img").live('click',function(){
			DIALOG.dialog('close');
		});
	}
</script>
</head>
<body>
	<s:hidden name="projectId" value="%{project.id}"></s:hidden>
	<div class="content">
		<div class="header">
			<p class="project_name">
				<s:property value="%{project.name}" />
			</p>
			<p class="page_info">详情</p>
		</div>
		<div class="project_overview">
			<div class="general_info">
				<table class="project_detail">
					<tr class="odd_row">
						<td class="table_name">项目简介</td>
						<td colspan="2"></td>
					</tr>
					<tr class="even_row name_logo">
						<td class="empty" rowspan="4"></td>
						<td class="second_col"><s:if test="%{project.logo==null}">
								<img src='${ pageContext.request.contextPath }/images/project_default_logo.png'>
							</s:if> <s:else>
								<img
									src='${ pageContext.request.contextPath }/<s:property  value="%{project.logo.path}"/>'
									width="60px" height="80px" id="projectLogo">
							</s:else></td class="third_col">
						<td><s:property value="%{project.name}" /></td>
					</tr>
					<tr class="odd_row calendar">
						<td class="second_col">开始时间</td>
						<td class="third_col"><img
							src="${ pageContext.request.contextPath }/images/icon/calendar.png" />
						<s:date name="%{project.start_time}" format="yyyy-MM-dd" /></td>
					</tr>
					<tr class="even_row calendar">
						<td class="second_col">结束时间</td>
						<td class="third_col"><img
							src="${ pageContext.request.contextPath }/images/icon/calendar.png" />
						<s:date name="%{project.end_time}" format="yyyy-MM-dd" /></td>
					</tr>
					<tr class="odd_row description">
						<td class="second_col">项目描述</td>
						<td class="third_col"><s:property
								value="%{project.description}" /></td>
					</tr>
				</table>
			</div>
			<div class="project_burndown">
			   <h1>项目燃尽图</h1>
			   <canvas id="cvs" width="500" height="250">[No canvas support]</canvas>
			</div>
			<div class="clear"/>
		</div>
		<div class="member_overview">
			<div class="member_list">
			    <table>
			       <tr>
			          <td class="table_name">项目成员</td>
					  <td></td>
			       </tr>
			       <tr class="even_row members_tr">
			          <td class="empty"></td>
					  <td class="member_list_td">
					    <s:iterator value="%{project.users}" var="user">
					      <div class="member_info">
					         <img src="${ pageContext.request.contextPath }/images/icon/close_delete.png" class="remove_memeber" id='<s:property value="%{#user.id}"/>'/>
					         <s:if test="%{#user.photo!=null}">
					            <img class="photo" src='${ pageContext.request.contextPath }/<s:property  value="%{#user.photo.path}"/>'/>
					         </s:if>
					         <s:else>
					            <img class="photo" src="${ pageContext.request.contextPath }/images/icon/default_member_photo.jpg"/>
					         </s:else>
					         <s:if test="%{#user.name!=null}">
					          <p><s:property value="%{#user.name}"/></p>
					         </s:if>
					         <s:else>
					          <p><s:property value="%{#user.email}"/></p>
					         </s:else>
					         
					      </div>	           
	                    </s:iterator>
	                      <div class="add_member">
	                         <img src="${ pageContext.request.contextPath }/images/add_member.png"/>
	                      </div>
					  </td>
			       </tr>
			    </table>
			</div>
			<div class="velocity">
			   <h1>团队生产力</h1>
			   <canvas id="velocity_cvs" width="500" height="250">[No canvas support]</canvas>
			</div>
		    <div class="addMemeberDialog dialog"/>
		</div>
		
	</div>
	<div class="left_menu">
		<div class="logo">
			<img src="${ pageContext.request.contextPath }/images/icon/ant.jpg"
				title='首页' />
		</div>
		<ul> 
		     
		      <li>
		       <s:if test="%{project.logo==null}">
                 <a href='<s:url value="/project/viewProject.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img src='${ pageContext.request.contextPath }/images/icon/project_default.png'  title='<s:property  value="%{project.name}"/>'></a>
               </s:if>
               <s:else>
               <a href='<s:url value="/project/viewProject.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img src='${ pageContext.request.contextPath }/<s:property  value="%{project.logo.path}"/>' style="width:40px;margin:5px 0px;" title='<s:property  value="%{project.name}"/>'/></a>
               </s:else>
              </li>
		    <li><a
				href='<s:url value="/sprint/loadKanban.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img
					src="${ pageContext.request.contextPath }/images/icon/kanban.png"
					title="看板" /></a></li>
			<li><a
				href='<s:url value="/story/viewStoriesOfProject.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img
					src="${ pageContext.request.contextPath }/images/icon/story.png"
					title="需求库" /></a></li>
			<li><a
				href='<s:url value="/sprint/listSprints.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img
					src="${ pageContext.request.contextPath }/images/icon/plan.png"
					title="计划" /></a></li>
			<li><a
				href='<s:url value="/impediment/showimpediments.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img
					src="${ pageContext.request.contextPath }/images/icon/impediment.jpg"
					title="障碍" /></a></li>
			<li><a
				href="${ pageContext.request.contextPath }/project/listProject.action"><img
					src="${ pageContext.request.contextPath }/images/icon/project.png"
					title='项目库' /></a></li>
			<li>
               <a href='<s:url value="/user/setting.action"></s:url>'><img src="${ pageContext.request.contextPath }/images/icon/setting.jpg" title="个人设置"/></a>
             </li>
			
			<li><a
				href="${ pageContext.request.contextPath }/user/logout.action"><img
					src="${ pageContext.request.contextPath }/images/icon/back.png"
					title="退出" /></a></li>
		</ul>
	</div>
</body>
</html>