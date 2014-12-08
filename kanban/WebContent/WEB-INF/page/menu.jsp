<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<html>
<div class="logo">
	<img src="${ pageContext.request.contextPath }/images/icon/ant.jpg"
		title='首页' />
</div>
<ul>
	<li><s:if test="%{project.logo==null}">
			<a href='<s:url value="/project/viewProject.action"><s:param name="projectId" value="%{projectId}"/></s:url>'>
			   <img src='${ pageContext.request.contextPath }/images/icon/project_default.png' title='<s:property  value="%{project.name}"/>'>
			</a>
		</s:if>
		<s:else>
			<a href='<s:url value="/project/viewProject.action"><s:param name="projectId" value="%{projectId}"/></s:url>'>
			   <img src='${ pageContext.request.contextPath }/<s:property  value="%{project.logo.path}"/>' style="width: 40px; margin: 5px 0px;" title='<s:property  value="%{project.name}"/>' />
			</a>
		</s:else>
	</li>
	
	<li>
	    <a href='<s:url value="/sprint/loadKanban.action"><s:param name="projectId" value="%{projectId}"/></s:url>'>
		   <img src="${ pageContext.request.contextPath }/images/icon/kanban.png" title="看板" /> 
		</a>
	</li>
	
	<li>
	    <a href='<s:url value="/story/viewStoriesOfProject.action"><s:param name="projectId" value="%{projectId}"/></s:url>'>
		   <img src="${ pageContext.request.contextPath }/images/icon/story_current.png" title="需求库" />
		</a>
	</li>
	
	<li>
	    <a href='<s:url value="/sprint/listSprints.action"><s:param name="projectId" value="%{projectId}"/></s:url>'>
		  <img src="${ pageContext.request.contextPath }/images/icon/plan.png" title="计划" />
		</a>
	</li>
	
	<li>
	    <a href='<s:url value="/impediment/showimpediments.action"><s:param name="projectId" value="%{projectId}"/></s:url>'>
	       <img src="${ pageContext.request.contextPath }/images/icon/impediment.jpg" title="障碍" />
	    </a>
	</li>

	<li>
	    <a href="${ pageContext.request.contextPath }/project/listProject.action">
	       <img src="${ pageContext.request.contextPath }/images/icon/project.png" title='项目库' />
	    </a>
	</li>

	<li>
	    <a href='<s:url value="/user/setting.action"></s:url>'>
	       <img src="${ pageContext.request.contextPath }/images/icon/setting.jpg" title="个人设置" />
	    </a>
	</li>
	
	<li>
	    <a href="${ pageContext.request.contextPath }/user/logout.action">
	       <img src="${ pageContext.request.contextPath }/images/icon/back.png" title="退出" />
	    </a>
	</li>
</ul>
</html>