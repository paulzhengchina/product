<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>项目库</title>
<LINK rel="Bookmark" href="${pageContext.request.contextPath}/images/icon/ant.jpg" />
<LINK rel="Shortcut Icon" href="${pageContext.request.contextPath}/images/icon/shortcut.png" />
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/css/common.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/jquery-ui.css" />
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-1.6.2.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
	
<script type="text/javascript" >
	$(document).ready(function() {
		
		
		$("#loadcreateproject").click(function(){
			DIALOG = $(".project_dialog");
			DIALOG.dialog({autoOpen: false, 
				                    title: "创建项目",
					                modal: true,
					                width :550,
					                height:500,
	                                close: function() {}
	                                });
			DIALOG.dialog('open');
			DIALOG.html("");
			DIALOG.css('background','url("../images/loading.gif")  no-repeat  center rgba(0, 0, 0, 0)') ;
			customizeDialog();
			DIALOG.load("${pageContext.request.contextPath}/project/loadCreatePage.action",function(){DIALOG.css('background','none') ;});
			
			
		});
		
		$("#<s:property value='id'/>").click(function(){
			  $("#update<s:property value='id'/>").css("display","");
		  });
		  
		  $(".editProject").click(function(){
			DIALOG = $(".project_dialog");
			var projectId=$(this).attr("id");
			DIALOG.dialog({autoOpen: false, 
					                    title: "编辑项目信息",
						                modal: true,
						                width :540,
						                height:520,
		                                close: function() {}
		                                });
			DIALOG.dialog('open');
			DIALOG.html("");
			DIALOG.css('background','url("../images/loading.gif")  no-repeat  center rgba(0, 0, 0, 0)') ;
			customizeDialog();
			DIALOG.load("${pageContext.request.contextPath}/project/modifyProject.action?projectId="+projectId,function(){DIALOG.css('background','none') ;});
		   });
		  
			$(".setDefaultProject").click(
			   function(){
				   var currentItem=$(this);
				   $.ajax({
						  "url":"${pageContext.request.contextPath }/user/setDefaultProject.action",
						  "type":"post",
						  "data":{projectId:$(this).attr("id")},
						  "success":function(data,status){
							  if(data){									  
								  $(".defaultprojectoverview").removeClass("defaultprojectoverview");
								  currentItem.parents(".project_card").addClass("defaultprojectoverview");									  								  
							  }
						},
						"error":function(xhr,s1,s2){
							alert('系统出错');
						}
					});
			   }		
			);
			
			$("#setUsersOfProject<s:property value='id'/>").click(function(){
				DIALOG = $(".project_dialog");
				DIALOG.dialog({autoOpen: false, 
						                    title: "设置项目成员",
							                modal: true,
							                width :500,
							                height:300,
			                                close: function() {}
			                                });
				DIALOG.load("${pageContext.request.contextPath}/project/setUsersOfProject.action?projectId=<s:property value='id'/>").dialog('open');
				customizeDialog();
			   });
			
			 $.ajax({
				  "url":"${pageContext.request.contextPath }/user/getDefaultProject.action",
				  "type":"get",
				  "success":function(data,status){
					  if(data){	
						  $("#projectoverview"+data).addClass("defaultprojectoverview");									  								  
					  }
				}
				
			}); 
			
			 $(".deleteProject").click(
					   function(){
						   var project_card=$(this).parents(".project_card");
						   var project_id=$(this).attr("id");
						   DIALOG = $(".project_delete_dialog");
						   DIALOG.dialog({autoOpen: false, 
			                    title: "小蚂蚁看板提醒您：您确定退出该项目吗？",
				                modal: true,
				                resizable:false,
				                buttons:{
				                	"否" :function(){
				                		$(this).dialog("close"); 
				                		return false;
				                	},
				                	"是" :function(){
				                		  										   
										   $.ajax({
												  "url":"${pageContext.request.contextPath }/project/removeAMemberFromProject.action",
												  "type":"post",
												  "data":{projectId:project_id},
												  "success":function(data,status){
													  project_card.remove();
												},
												"error":function(xhr,s1,s2){
													alert('删除失败,请稍后再试!');
												}
											});
				                		$(this).dialog("close");
				                	}
				                }
				                
                                });
						   DIALOG.dialog("open");
						   customizeDialog();
						   
						   
					   }		
					);
			 
			// prepareTooltip();
			 	
	});
	
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
	<div class="content">
	    <div class="header">
			<p class="project_name">
			&nbsp;
			</p>
			<p class="page_info">项目列表</p>
		</div>
		<div class="addProject" >
			<div class="createitem" id="loadcreateproject"></div>
		</div>
		<s:iterator value="projects">
			<div class="project_card" id="projectoverview<s:property value='id'/>" >
	
					<div class="top_part">
					    <div id="<s:property value="id"/>" class="logo">
						    <s:if test="%{logo==null}">						     
						      <img src='${ pageContext.request.contextPath }/images/project_default_logo.png' />			
							</s:if>
							<s:else>
							  <img src='${ pageContext.request.contextPath }/<s:property  value="%{logo.path}"/>'  width="70px" height="80px" />
							</s:else>
						 </div>
						 <div class="top_part_right">
							 <div class="project_action_btns">
							        <a href="#" title="编辑"><img width="20" height="20"src="${ pageContext.request.contextPath }/images/icon/project_edit.png" id="<s:property value='id'/>" class="editProject"/></a>
							        <a href="#" title="设置为默认项目"><img width="20" height="20" src="${ pageContext.request.contextPath }/images/icon/project_set_default.png" id="<s:property value='id'/>" class="setDefaultProject"></img></a>
							        <a href="#" title="删除"><img width="20" height="20" src="${ pageContext.request.contextPath }/images/icon/project_delete.png" id="<s:property value='id'/>" class="deleteProject"></img></a>
						      </div>
						      <div class="project_name">
							       <a href='${ pageContext.request.contextPath }/project/viewProject.action?projectId=<s:property value="id"/>' title='<s:property value="name" />'>
									   <h4> <s:property value="name" /></h4>
									</a>
						      </div>
						</div>								
					</div>
					
					<div id="projectDescription" class="projectDescription" title='<s:property  value="description"/>'>
					    <p><s:property  value="description"/></p>
					</div>
					<div id="projectTime" class="projectTime">
						<span><s:date name="start_time" format="yyyy-MM-dd"/></span>至<span><s:date name="end_time" format="yyyy-MM-dd"/></span>
					</div>

			</div>	
		</s:iterator>
		<div class="clear"></div>
		<div class="project_dialog dialog"></div>
		<div class="project_delete_dialog" style="display:none"><p class="title">确定删除该项目吗？</p></div>
        </div>
        <div class="left_menu">
           <div class="logo">
              <img src="${ pageContext.request.contextPath }/images/icon/ant.jpg" title='首页'/>
           </div>
           <ul>
              <li>
               <a href="${ pageContext.request.contextPath }/project/listProject.action"><img src="${ pageContext.request.contextPath }/images/icon/projects_current.png" title='项目库'/></a>
              </li> 
              <li>
               <a href='<s:url value="/user/setting.action"></s:url>'><img src="${ pageContext.request.contextPath }/images/icon/setting.jpg" title="个人设置"/></a>
              </li>
              <li>
               <a href="${ pageContext.request.contextPath }/user/logout.action"><img src="${ pageContext.request.contextPath }/images/icon/back.png" title="退出"/></a>
              </li>
           </ul>
        </div>
        <div class="clear"></div>
</body>
		
</html>