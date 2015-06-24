package com.createidea.scrumfriend.dao.sprint;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.createidea.scrumfriend.dao.BaseDaoImpl;
import com.createidea.scrumfriend.to.ProjectTo;
import com.createidea.scrumfriend.to.SprintTo;
import com.createidea.scrumfriend.to.StoryTo;

public class SprintDaoImpl extends BaseDaoImpl implements  SprintDao {

	@Override
	public List<SprintTo> sprintsByStatus(int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateSprint(SprintTo sprint) {		
		this.getHibernateTemplate().saveOrUpdate(sprint);
		
	}

	@Override
	public SprintTo getSprintById(String sprintId) {
		SprintTo sprintTo = (SprintTo) this.getHibernateTemplate().get(SprintTo.class, sprintId);
		return sprintTo;
	}

	@Override
	public List<SprintTo> getSprintForProject(String projectId) {
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(SprintTo.class);
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		detachedCriteria.addOrder(Order.asc("startTime"));
		return (List<SprintTo>) this.getHibernateTemplate().findByCriteria(detachedCriteria);
	}

	@Override
	public SprintTo createSprint(SprintTo sprint,String projectId) {
		sprint.setProject(new ProjectTo(projectId));
		String id=(String)this.getHibernateTemplate().save(sprint);
		return getSprintById(id);
	}

	@Override
	public List<SprintTo> getSprintsForProjectByStatus(String projectId,
			int status) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteSprint(String sprintId) {
		SprintTo sprint = new SprintTo();
		sprint.setId(sprintId);
		this.getHibernateTemplate().delete(sprint);
		
	}

	@Override
	public SprintTo getCurrentSprint(String projectId, Date date) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(SprintTo.class);
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		detachedCriteria.add(Restrictions.le("startTime", getPureDateOfToday()));
		detachedCriteria.add(Restrictions.ge("endTime", getLatestDateOfToday()));
		List<SprintTo> sprints=(List<SprintTo>) this.getHibernateTemplate().findByCriteria(detachedCriteria);
		List<SprintTo> sprintsWithChild=new ArrayList<SprintTo>();
		if(sprints!=null&&sprints.size()>0){
			for(SprintTo sprint :sprints ){
				if(sprint.getSubSprints()!=null&&sprint.getSubSprints().size()>0)
					sprintsWithChild.add(sprint);
			}
			if(sprintsWithChild.size()>0)
			   sprints.removeAll(sprintsWithChild);
			if(sprints.size()>0)
				return sprints.get(0);
			else 
				return null;
		}
		else
			return null;
	}
    
	public Date getPureDateOfToday(){
		Calendar time=Calendar.getInstance();
		time.set(Calendar.HOUR_OF_DAY, 23);
		time.set(Calendar.MINUTE, 59);
		time.set(Calendar.SECOND, 59);
		return time.getTime();
	}
	
	public Date getLatestDateOfToday(){
		Calendar time=Calendar.getInstance();
		time.set(Calendar.DATE,time.get(Calendar.DATE)-1);
		time.set(Calendar.HOUR_OF_DAY, 23);
		time.set(Calendar.MINUTE, 59);
		time.set(Calendar.SECOND,59);		
		return time.getTime();
	}
	
	public Date getEarlistTimeOfToday(){
		Calendar time=Calendar.getInstance();
		time.set(Calendar.HOUR, 0);
		time.set(Calendar.MINUTE, 0);
		time.set(Calendar.SECOND, 1);
		return time.getTime();
	}
	
	@Override
	public List<SprintTo> getSprintsFinishedYesterday(Date today,Date twoDaysAgo) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(SprintTo.class);
		detachedCriteria.add(Restrictions.gt("endTime", twoDaysAgo));
		detachedCriteria.add(Restrictions.lt("endTime", today));
		return (List<SprintTo>) this.getHibernateTemplate().findByCriteria(detachedCriteria);
	}

	@Override
	public List<SprintTo> getSprintWithNoChildrenForProject(String projectId) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(SprintTo.class);
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		detachedCriteria.add(Restrictions.isNull("parentSprint"));
		detachedCriteria.addOrder(Order.asc("startTime"));
		return (List<SprintTo>) this.getHibernateTemplate().findByCriteria(detachedCriteria);
	}
	
}
