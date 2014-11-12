<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="/struts-dojo-tags" prefix="sx"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>创建阶段</title>		
<link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/css/common.css">
<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery.form.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.validate.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$( "#sttm" ).datepicker({showButtonPanel: true,dateFormat : "yy-mm-dd"});
		$( "#endtm" ).datepicker({showButtonPanel: true,dateFormat : "yy-mm-dd"});
		    
		$("#sbm_button").click(function(){
			 $("#createSprintNode").validate({
					rules: {					
						'sprint.name': {
							required: true
						},
						'sprint.startTime': {
							required: true,
							dateISO:true
						},
						'sprint.endTime': {
							required: true,
							dateISO:true
						}
						
					},
					messages: {
						'sprint.name': {
							required: "请输入名称！"
						},
						'sprint.startTime': {
							required: "请选择开始时间！",
							dateISO:"请输入正确的时间格式：yyyy-mm-dd"
						},
						'sprint.endTime': {
							required: "请选择结束时间！",
							dateISO:"请输入正确的时间格式：yyyy-mm-dd"
						}
					}
				});
			 if($("form").valid()){ 
				 $("#sbm_button").prop("disabled","disabled");
				 $("#sbm_button").css("background","gray");				
				 }
			 else{
				 return false;
			 }
				
		    var options={
		    			url: "${ pageContext.request.contextPath }/sprint/createSprintNode.action",
		    			type: "post",
		    			dataType : "json", 
		    			success : function(data){
		    				var zTree = $.fn.zTree.getZTreeObj("treeDemo");
		    				var newNode = { name:data.sprintNode.name,id:data.sprintNode.id,pId:data.sprintNode.pId};
		    				newNode.checked = zTree.getSelectedNodes()[0].checked;
		    				zTree.addNodes(zTree.getSelectedNodes()[0], newNode);
		    				DIALOG = $(".sprint_dialog");
		    				DIALOG.dialog("close");
		    				
		    			},
		    			error:function(XMLHttpRequest, textStatus, errorThrown){
							alert(textStatus);
						} 
				}
		    
		    $("form").ajaxSubmit(options);		   
			return false;
			});
			
		});
</script>
</head>
<body>
	<s:form name="createSprintNode" action="createSprintNode" method="POST"
		theme="simple">
		<s:hidden name="projectId" value="%{projectId}" />
		<s:hidden name="sprintId" value="%{sprintId}" />
		<p class="title">创建阶段</p>
			<table>
				<tr>
				    <td class="row_name">
				                  名称
				    </td>
					<td>
					 <s:textfield name="sprint.name" size="53" placeholder="输入阶段名称"></s:textfield>
					</td>
				</tr>
				<tr>
					 <td class="row_name">
					  开始时间
					 </td>
					 <td>
						<s:textfield name="sprint.startTime" id="sttm" placeholder="yyyy-mm-dd"></s:textfield>
					 </td>
				</tr>
					<td class="row_name">
						结束时间
					</td>
					<td>
					    <s:textfield name="sprint.endTime" id="endtm" placeholder="yyyy-mm-dd"></s:textfield>
				    </td>
				</tr>
				<tr>
				    <td class="row_name">
				    </td>
					<td><button id="sbm_button" class="submit">确定</button></td>
				</tr>
			</table>
	</s:form>
</body>
</html>