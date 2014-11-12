package com.createidea.scrumfriend.dao.project;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.ForEach;

import com.createidea.scrumfriend.dao.BaseDaoImpl;
import com.createidea.scrumfriend.dao.user.UserDao;
import com.createidea.scrumfriend.to.ProjectTo;
import com.createidea.scrumfriend.to.UserTo;

public class ProjectDaoImpl extends BaseDaoImpl implements  ProjectDao {

	@Override
	public void saveProject(ProjectTo project) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().save(project);
	}

	@Override
	public List<ProjectTo> getProject(String userId){
		// TODO Auto-generated method stub
		List<ProjectTo> projects=this.getHibernateTemplate().find("from ProjectTo where user.id=?",userId+"and status=1");
		return projects;
	}

	@Override
	public void deleteProject(ProjectTo project) {
		
		this.getHibernateTemplate().delete(project);
	}

	@Override
	public ProjectTo getProjectById(String id) {
		ProjectTo projectTo = (ProjectTo) this.getHibernateTemplate().get(ProjectTo.class, id);
		return projectTo;
	}
	
	public void updateProject(ProjectTo projectTo){
		
		this.getHibernateTemplate().update(projectTo);
	}
}
