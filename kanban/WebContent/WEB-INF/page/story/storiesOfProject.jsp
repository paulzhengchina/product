<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>需求库-<s:property value="project.name" /></title>
<LINK rel="Shortcut Icon" href="${pageContext.request.contextPath}/images/icon/shortcut.png" />
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/css/common.css">
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/jquery-ui.css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/jquery.jscrollpane.css" />
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/multi-select/jquery.multiselect.css" />
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-1.6.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jscrollpane/jquery.jscrollpane.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jscrollpane/jquery.mousewheel.js"></script>
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/freewall.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/scrum-shrink.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.multiselect.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.multiselect.zh-cn.js"></script>

<script>
	function calculateStoryCardSize(point){
		if(!point||point==0)
			return 1;
		else if(point==1)
			return 1;
		else if(point>1 && point<=3)
			return 2;
		else if(point>3 && point <=6)
			return 3;
		else if(point>6 && point<=13)
			return 4;
		else 
			return 5;
		
	}
	
</script>
</head>
<body>

<div class="content">
    <div class="header">
       <p class="project_name"><s:property value="%{project.name}"/></p>
       <p class="page_info">需求列表</p>
       <select name="filter" multiple="multiple" style="width:300px">
		<optgroup label="优先级">
			<option value="priority0" selected="selected">必须有</option>
			<option value="priority1" selected="selected">应该有</option>
			<option value="priority2" selected="selected">可以有</option>
			<option value="priority3" selected="selected">不会有（但想）</option>
	    </optgroup>
		<optgroup label="状态">
			<option value="status0" selected="selected">等待</option>
			<option value="status1">完成</option>
			<option value="status2">移除</option>
		</optgroup>
	 </select>
                 
    </div>

	<div class="project_stories" id='project_stories' style="position: relative;">
			<s:hidden name="projectId" value="%{projectId}" />
			<div id="storieslist">
			  <div class="addStory">
			    
			  </div>
			  <s:iterator value="%{stories}" var="story">
			    <script>
			     var cardSize = calculateStoryCardSize('<s:property value="%{#story.point}"/>');
			     var priority='<s:property value="%{#story.priority}"/>';
			     var status='<s:property value="%{#story.status}"/>';
			     var className='story_card size'+cardSize+' priority'+priority+' status'+status;
			     var rel='<s:property value="%{#story.id}"/>';
			     document.write("<div class='"+className+"'rel='"+rel+ "'>");
				 </script>
				  <h2><s:property value="%{#story.name}"/></h2>
				  <p class="value" title="商业价值"><s:property value="%{#story.businessValue}"/></p>
				  <s:property value="%{#story.dod}" escapeHtml="false"/>
				  <p class="point" title="工作量"><s:property value="%{#story.point}"/></p>
				  <p class="priorityNum" title="优先级"><s:property value="%{#story.priorityNum}"/></p>
				  <div class="operations">
				     <a href="#" title="编辑"><img width="20" height="20"src="${ pageContext.request.contextPath }/images/icon/project_edit.png" id="<s:property value='%{#story.id}'/>" class="editStory"/></a>
					 <a href="#" title="删除"><img width="20" height="20" src="${ pageContext.request.contextPath }/images/icon/project_delete.png" id="<s:property value='%{#story.id}'/>" class="deleteStory"></img></a>
				  </div>
				</div>
			 </s:iterator>		
	</div>

    <div class="story_dialog dialog"></div>
    <div class="delete_dialog dialog" style="display:none"><p class="title">确定删除该需求吗？</p></div>	
</div>
<div class="left_menu">
          <jsp:include page="../menu.jsp" flush="true"></jsp:include>
</div>
</body>
<script>
	$(document).ready(function() {
		
		initialCurrentMenuItem("menu_item_story");
		
		showToolTipForContent();
		
		$(".value").next('p').wrap("<div class='acceptance_criteria'></div>");
		
		$(".value").next().jScrollPane();
		
		var allStoryCards=$(".story_card");
		removeDeletedStoryCards();
		var wall = new freewall("#storieslist");
		wall.reset({
			//selector: '.addStory .brick',
			animate: false,
			cellW: 200,
			cellH: 50,
			gutterY: 16,
			gutterX: 16,
			delay: 30,
			onResize: function() {
				wall.refresh($(window).width() -100, $(window).height() - 30);
			}
		});
		wall.fitWidth();
		// caculator width and height for IE7;
		//wall.fitZone($(window).width() - 30 , $(window).height() - 30);
		
		$(".addStory").click(function(){
			DIALOG = $(".story_dialog");
			DIALOG.dialog({
				autoOpen : false,
				title : "添加需求",
				modal : true,
				width : 560,
				height : 580,
				close : function() {
					wall.fitWidth();
				}
			});
			DIALOG.dialog('open');
			DIALOG.html("");
			DIALOG.css('background','url("../images/loading.gif")  no-repeat  center rgba(0, 0, 0, 0)') ;
			customizeDialog();
			var projectId = $("#projectId").val();
			DIALOG.load("${pageContext.request.contextPath}/story/loadCreateStory.action?projectId="+ projectId,function(){DIALOG.css('background','none') ;});
		});
		
		
		$(".editStory").live('click',function(){
			DIALOG = $(".story_dialog");
			DIALOG.html('<img class="loading" src="../images/loading.gif"/>');
			DIALOG.dialog({
				autoOpen : false,
				title : "编辑需求",
				modal : true,
				width :560,
				height : 580,
				close : function() {
					
				}
			});
			var storyId=$(this).attr('id');
			DIALOG.dialog('open');
			DIALOG.html("");
			DIALOG.css('background','url("../images/loading.gif")  no-repeat  center rgba(0, 0, 0, 0)') ;
			customizeDialog();
			DIALOG.load("${pageContext.request.contextPath}/story/loadEditStory.action?storyId="+ storyId,function(){DIALOG.css('background','none') ;});
		});
		
		$(".deleteStory").live('click',function(){
			 var storyId=$(this).attr("id");
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
									  "url":"${pageContext.request.contextPath }/story/deleteStory.action",
									  "type":"post",
									  "data":{storyId:storyId},
									  "success":function(data,status){
										  location.reload();
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
		
		
		var allDetachedStoryCards;
		$("select").multiselect({
			 selectedList: 5,
			 close: function(){
				 if ($('input[name=filter[]]:checked').length < 1) {  
					     
					   }  
				 else {  
					    allDetachedStoryCards=$('input[name=filter[]]:not(:checked)');  
					    $('input[name=filter[]]:not(:checked)').each(function() {
					    	$("."+$(this).val()).remove();
					    });
					    wall.refresh($(window).width() -100, $(window).height() - 30);
					   }   
			   },
			  beforeclose: function(){
				  $(".story_card").each(function(){$(this).remove()});
				  if(allStoryCards){
					  allStoryCards.each(function() {
					  $("#storieslist").append($(this));
					  wall.refresh($(window).width() -100, $(window).height() - 30);
					    });
				  }
			}
		});
		
		});
	function removeDeletedStoryCards(){
		$(".status2").each(function(){$(this).remove()});
		$(".status1").each(function(){$(this).remove()});
	}
	
	
	
</script>
</html>
