<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>障碍库</title>
<LINK rel="Bookmark" href="${pageContext.request.contextPath}/images/icon/ant.jpg" />
<LINK rel="Shortcut Icon" href="${pageContext.request.contextPath}/images/icon/shortcut.png" />
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/css/common.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/jquery-ui.css" />
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-1.6.2.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
	

</head>
<body>
    <s:hidden name="projectId" value="%{projectId}"/>
	<div class="content">
	    <div class="header">
			<p class="project_name">
			<s:property value="project.name"/>
			</p>
			<p class="page_info">障碍列表</p>
		</div>
		<div class="create_impediment">
			
		</div>
		<s:iterator value="impediments">
			<div class="impediment_item">
			  <s:if test="status==0">
			      <div class="serverity_time">
			          <img title="" id="severity_legend_<s:property value='severity'/>" class="severity_legend" src="${pageContext.request.contextPath}/images/icon/impediment_serverity_<s:property value='severity'/>.png"/>
			          <p><s:date name="createdTime" format="yyyy-MM-dd" /> 创建   <span class="waiting">等待解决</span></p>
			          <div class="clear"></div>
			      </div>
			      <p class="column">标题</p>
				  <p class="column_content title"><s:property value="name"/></p>
				  <p class="column">描述</p>
				  <p class="column_content"><s:property value="description"/></p>
				  <div class="relative_users">
				     <div class="creater">
					     <P class="column">创建者</P>
					     <p class="column_content user_name"><s:property value="createdBy.name"/></p>
				     </div>				     
				  </div>
				  <button class="implement_btn analyse" id='<s:property value="id"/>'>分析方案</button>
				  <div class="operations">
				   <a href="#" title="查看" class="viewImpediment" id='<s:property value="id"/>'><img width="20" height="20"src="${ pageContext.request.contextPath }/images/icon/project_check.png" id="<s:property value='id'/>"/></a>
			       <a href="#" title="编辑"><img width="20" height="20"src="${ pageContext.request.contextPath }/images/icon/project_edit.png" id="<s:property value='id'/>" class="editImpediment"/></a>
				   <a href="#" title="删除"><img width="20" height="20" src="${ pageContext.request.contextPath }/images/icon/project_delete.png" id="<s:property value='id'/>" class="deleteImpediment"></img></a>
			      </div>
			  </s:if>
			  <s:if test="status==1">
			      <div class="serverity_time">
			          <img title="" id="severity_legend_<s:property value='severity'/>" class="severity_legend" src="${pageContext.request.contextPath}/images/icon/impediment_serverity_<s:property value='severity'/>.png"/>
			          <p><s:date name="createdTime" format="yyyy-MM-dd" /> 创建   <span class="on_going">进行中</span></p>
			          <div class="clear"></div>
			      </div>
			      <p class="column">标题</p>
				  <p class="column_content title"><s:property value="name"/></p>
				  <p class="column">原因分析</p>
				  <p class="column_content"><s:property value="reason"/></p>
				  <p class="column">方案</p>
				  <p class="column_content"><s:property value="solution"/></p>
				  <div class="relative_users">
				     <div class="creater">
					     <P class="column">创建者</P>
					     <p class="column_content user_name"><s:property value="createdBy.name"/></p>
				     </div>
				     <div class="performer">
					     <P class="column">负责人</P>
					     <p class="column_content user_name"><s:property value="fixedBy.name"/></p>
				     </div>					     
				  </div>
				  <button class="implement_btn complete" id='<s:property value="id"/>'>完成</button>
				  <div class="operations">
				   <a href="#" title="查看" class="viewImpediment" id='<s:property value="id"/>'><img width="20" height="20"src="${ pageContext.request.contextPath }/images/icon/project_check.png" id="<s:property value='id'/>"/></a>
			       <a href="#" title="编辑"><img width="20" height="20"src="${ pageContext.request.contextPath }/images/icon/project_edit.png" id="<s:property value='id'/>" class="editImpediment"/></a>
			  </div>
			  </s:if>
			  <s:if test="status==2||status==3">
			      <div class="serverity_time">
			          <img title="" id="severity_legend_<s:property value='severity'/>" class="severity_legend" src="${pageContext.request.contextPath}/images/icon/impediment_serverity_<s:property value='severity'/>.png"/>
			          <p><s:date name="createdTime" format="yyyy-MM-dd" /> -- <s:date name="fixedTime" format="yyyy-MM-dd" /> <span class="completed">结束</span></p>
			          <div class="clear"></div>
			      </div>
			      <p class="column">标题</p>
				  <p class="column_content title"><s:property value="name"/></p>
				  <p class="column">方案</p>
				  <p class="column_content"><s:property value="solution"/></p>
				  <p class="column">结果</p>
				  <p class="column_content"><s:property value="result"/></p>
				  <div class="relative_users">
				     <div class="creater">
					     <P class="column">创建者</P>
					     <p class="column_content user_name"><s:property value="createdBy.name"/></p>
				     </div>
				     <div class="performer">
					     <P class="column">负责人</P>
					     <p class="column_content user_name"><s:property value="fixedBy.name"/></p>
				     </div>					     
				  </div>
				  <div class="final_status">
				     <img src="${pageContext.request.contextPath}/images/icon/impediment_final_status_<s:property value='status'/>.png"/>
				  </div>
				  <button class="implement_btn view" id='<s:property value="id"/>'>查看</button>
				  <div class="operations">
				   <a href="#" title="查看" class="viewImpediment" id='<s:property value="id"/>'><img width="20" height="20"src="${ pageContext.request.contextPath }/images/icon/project_check.png" id="<s:property value='id'/>"/></a>
			       <a href="#" title="编辑"><img width="20" height="20"src="${ pageContext.request.contextPath }/images/icon/project_edit.png" id="<s:property value='id'/>" class="editImpediment"/></a>       
			      </div>
			  </s:if>
			  
			</div>
		</s:iterator>
		<div class="clear"></div>
		<div class="impediment_dialog dialog"></div>
		<div class="delete_dialog dialog" style="display:none"><p class="title">确定删除该障碍吗？</p></div>
        </div>
        <div class="left_menu">
           <div class="logo">
              <img src="${ pageContext.request.contextPath }/images/icon/ant.jpg" title='首页'/>
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
              <li><a href='<s:url value="/sprint/loadKanban.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img
					src="${ pageContext.request.contextPath }/images/icon/kanban.png"
					title="看板" />
					</a>
			  </li>
			  <li>
               <a href='<s:url value="/story/viewStoriesOfProject.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img src="${ pageContext.request.contextPath }/images/icon/story.png" title="需求库" /></a>
              </li>
              <li>
                <a href='<s:url value="/sprint/listSprints.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img src="${ pageContext.request.contextPath }/images/icon/plan.png" title="计划" /></a>
              </li>
              <li>
                <a href='<s:url value="/impediment/showimpediments.action"><s:param name="projectId" value="%{projectId}"/></s:url>'><img src="${ pageContext.request.contextPath }/images/icon/impediment_current.png" title="障碍"/></a>
              </li>
              <li>
              <li>
               <a href="${ pageContext.request.contextPath }/project/listProject.action"><img src="${ pageContext.request.contextPath }/images/icon/project.png" title='项目库'/></a>
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
<script type="text/javascript" >
	$(document).ready(function() {
		
		var severities=["紧急","高","一般","低"];
		$(".severity_legend").each(function(){
			if($(this).attr('id')=='severity_legend_0')
				$(this).attr('title',severities[0]);
			if($(this).attr('id')=='severity_legend_1')
				$(this).attr('title',severities[1]);
			if($(this).attr('id')=='severity_legend_2')
				$(this).attr('title',severities[2]);
			if($(this).attr('id')=='severity_legend_3')
				$(this).attr('title',severities[3]);
		});
		
		$(".create_impediment").click(function(){
			var projectId=$("#projectId").val();
			DIALOG = $(".impediment_dialog");
			DIALOG.dialog({autoOpen: false, 
				                    title: "添加障碍",
					                modal: true,
					                width :550,
					                height:400,
	                                close: function() {}
	                                });
			DIALOG.dialog('open');
			DIALOG.html("");
			DIALOG.css('background','url("../images/loading.gif")  no-repeat  center rgba(0, 0, 0, 0)') ;
			customizeDialog();
			DIALOG.load("${pageContext.request.contextPath}/impediment/createimpediment.action?projectId="+projectId,function(){DIALOG.css('background','none') ;});
		});
		
		$(".implement_btn").click(function(){
			var impedimentId=$(this).attr("id");
			var url;
			var width;
			var height;
			if($(this).attr("class").substring(14)=='analyse'){
				url="${pageContext.request.contextPath}/impediment/analyseimpediment.action?impedimentId="+impedimentId;
			    width="640";
				height="450";
			}
			if($(this).attr("class").substring(14)=='complete'){
				url="${pageContext.request.contextPath}/impediment/completeImpediment.action?impedimentId="+impedimentId;
				width="640";
				height="300";
			}
			else if($(this).attr("class").substring(14)=='view'){
				url="${pageContext.request.contextPath}/impediment/viewImpediment.action?impedimentId="+impedimentId;
				width="900";
				height="650";
			}
			DIALOG = $(".impediment_dialog");
			DIALOG.dialog({autoOpen: false, 
				                    title: "",
					                modal: true,
					                width :width,
					                height:height,
	                                close: function() {}
	                                });
			DIALOG.dialog('open');
			DIALOG.html("");
			DIALOG.css('background','url("../images/loading.gif")  no-repeat  center rgba(0, 0, 0, 0)') ;
			customizeDialog();
			DIALOG.load(url,function(){DIALOG.css('background','none') ;});

		});
		
		$(".viewImpediment").click(function(){
			var impedimentId=$(this).attr("id");
			var url="${pageContext.request.contextPath}/impediment/viewImpediment.action?impedimentId="+impedimentId;
			var width="900";
			var height="650";
			DIALOG = $(".impediment_dialog");
			DIALOG.dialog({autoOpen: false, 
				                    title: "",
					                modal: true,
					                width :width,
					                height:height,
	                                close: function() {}
	                                });
			
			DIALOG.dialog('open');
			DIALOG.html("");
			DIALOG.css('background','url("../images/loading.gif")  no-repeat  center rgba(0, 0, 0, 0)') ;
			customizeDialog();
			DIALOG.load(url,function(){DIALOG.css('background','none') ;});
		});
		
		
		$(".editImpediment").click(function(){
			var impedimentId=$(this).attr("id");
			DIALOG = $(".impediment_dialog");
			DIALOG.dialog({autoOpen: false, 
				                    title: "编辑障碍",
					                modal: true,
					                width :620,
					                height:500,
	                                close: function() {}
	                                });
			DIALOG.dialog('open');
			DIALOG.html("");
			DIALOG.css('background','url("../images/loading.gif")  no-repeat  center rgba(0, 0, 0, 0)') ;
			customizeDialog();
			DIALOG.load("${pageContext.request.contextPath}/impediment/editImpediment.action?impedimentId="+impedimentId,function(){DIALOG.css('background','none') ;});
		});
		
		$(".deleteImpediment").click(function(){
			   var impedimentId=$(this).attr("id");
			   DIALOG = $(".delete_dialog");
			   DIALOG.dialog({autoOpen: false, 
               title: "小蚂蚁看板提醒您：您确定删除该项目吗？",
	           modal: true,
	           resizable:false,
	           buttons:{
	               "否" :function(){
	                		$(this).dialog("close"); 
	                		return false;
	                	},
	                "是" :function(){  										   
							   $.ajax({
									  "url":"${pageContext.request.contextPath }/impediment/deleteImpediment.action",
									  "type":"post",
									  "data":{impedimentId:impedimentId},
									  "success":function(data,status){
										  $("#"+impedimentId).parent(".impediment_item").remove();
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
			   
		});
		
		
		
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
</html>