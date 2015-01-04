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
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
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
			<p class="create_item">+创建障碍</p>
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
				   <a href="#" title="查看" class="viewImpediment" id='<s:property value="id"/>'><img src="${ pageContext.request.contextPath }/images/icon/view.png" id="<s:property value='id'/>"/></a>
			       <a href="#" title="编辑"><img src="${ pageContext.request.contextPath }/images/icon/edit.png" id="<s:property value='id'/>" class="editImpediment"/></a>
				   <a href="#" title="删除"><img src="${ pageContext.request.contextPath }/images/icon/delete.png" id="<s:property value='id'/>" class="deleteImpediment"></img></a>
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
				   <a href="#" title="查看" class="viewImpediment" id='<s:property value="id"/>'><img src="${ pageContext.request.contextPath }/images/icon/view.png" id="<s:property value='id'/>"/></a>
			       <a href="#" title="编辑"><img src="${ pageContext.request.contextPath }/images/icon/edit.png" id="<s:property value='id'/>" class="editImpediment"/></a>
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
				   <a href="#" title="查看" class="viewImpediment" id='<s:property value="id"/>'><img src="${ pageContext.request.contextPath }/images/icon/view.png" id="<s:property value='id'/>"/></a>
			       <a href="#" title="编辑"><img src="${ pageContext.request.contextPath }/images/icon/edit.png" id="<s:property value='id'/>" class="editImpediment"/></a>       
			      </div>
			  </s:if>
			  
			</div>
		</s:iterator>
		<div class="clear"></div>
		<div class="impediment_dialog dialog"></div>
		<div class="delete_dialog dialog" style="display:none"><p class="title">确定删除该障碍吗？</p></div>
        </div>
        <div class="left_menu">
            <jsp:include page="../menu.jsp" flush="true"></jsp:include>
        </div>
        <div class="clear"></div>
</body>
<script type="text/javascript" >
	$(document).ready(function() {
		
		initialCurrentMenuItem("menu_item_impediment");
		
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
		
		$(".create_item").click(function(){
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
		
		$("#menu_item_help").click(function(){
			DIALOG = $(".impediment_dialog");
			DIALOG.dialog({autoOpen: false, 
					                    title: "设置项目成员",
						                modal: true,
						                width :500,
						                height:640,
		                                close: function() {}
		                                });
			DIALOG.load("${pageContext.request.contextPath}/helppages/impediment.html").dialog('open');
			customizeDialog();
		});
		
		
		showToolTipForContent();
		
	});
	
	
</script>	
</html>