package com.createidea.scrumfriend.dao.story;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Hibernate;
import org.hibernate.HibernateException;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateCallback;

import com.createidea.scrumfriend.dao.BaseDaoImpl;
import com.createidea.scrumfriend.to.ProjectTo;
import com.createidea.scrumfriend.to.SprintTo;
import com.createidea.scrumfriend.to.StoryTo;
import com.sun.mail.imap.protocol.Status;

public class StoryDaoImpl extends BaseDaoImpl implements  StoryDao {

	@Override
	public List<StoryTo> storysByStatus(int status) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("status", status));
		detachedCriteria.addOrder(Order.asc("priority"));
		return this.getHibernateTemplate().findByCriteria(detachedCriteria);
	}
	
	@Override
	public void updateStory(StoryTo story) {
		// TODO Auto-generated method stub
		this.getHibernateTemplate().saveOrUpdate(story);
	}

	@Override
	public StoryTo getStoryById(String card_id) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("id", card_id));
		List storiesList=this.getHibernateTemplate().findByCriteria(detachedCriteria);
		if(storiesList!=null && storiesList.size()>0)
		   return (StoryTo)this.getHibernateTemplate().findByCriteria(detachedCriteria).get(0);
		else 
		   return null;
	}

	@Override
	public List<StoryTo> getActiveStoriesForProject(String projectId) {
		// TODO Auto-generated method stub
		ArrayList statusList=new ArrayList<Integer>();
		statusList.add(0);
		statusList.add(1);
		statusList.add(2);
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		detachedCriteria.add(Restrictions.in("status", statusList));
		detachedCriteria.addOrder(Order.asc("priorityNum"));
		detachedCriteria.addOrder(Order.asc("priority"));
		detachedCriteria.addOrder(Order.desc("businessValue"));
		return this.getHibernateTemplate().findByCriteria(detachedCriteria);
	}

	@Override
	public String createStory(StoryTo story) {
		// TODO Auto-generated method stub
		return (String)this.getHibernateTemplate().save(story);
	}

	@Override
	public List<StoryTo> getStoriesForProjectByStatus(String projectId, int status) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		detachedCriteria.add(Restrictions.eq("status", status));
		detachedCriteria.addOrder(Order.desc("priority"));
		return this.getHibernateTemplate().findByCriteria(detachedCriteria);
		
	}

	@Override
	public float calculateTotalPointsForProject(ProjectTo project) {
		// TODO Auto-generated method stub
         final String sql="select sum(point) as point from story where project_id='"+project.getId()+"'"+"and status in (0,1)";
		 return calculateStoryPoint(sql);
	}

	@Override
	public float calculateCompletedPointForProject(ProjectTo project) {
		// TODO Auto-generated method stub
		final String sql="select sum(point) as point from story where status=1 and project_id='"+project.getId()+"'";
		return calculateStoryPoint(sql);
	}

	@Override
	public float calculateRemainingPointForProject(ProjectTo project) {
		// TODO Auto-generated method stub
		final String sql="select sum(point) as point from story where status=0 and project_id='"+project.getId()+"'";
		return calculateStoryPoint(sql);
	}
	

	@Override
	public float calculateCommittedStoryPoint(String sprintId) {
		// TODO Auto-generated method stub
		final String sql="select sum(point) as point from story where sprint_id='"+sprintId+"'" +"and status in (0,1)";
		return calculateStoryPoint(sql);
	}

	@Override
	public float calculateCompletedStoryPoint(String sprintId) {
		// TODO Auto-generated method stub
		final String sql="select sum(point) as point from story where status=1 and sprint_id='"+sprintId+"'";
		return calculateStoryPoint(sql);
	}
	
	public float calculateStoryPoint(final String sql) {
		return (Float) this.getHibernateTemplate().execute(
				new HibernateCallback() {
					public Float doInHibernate(Session session) throws HibernateException, SQLException {
						SQLQuery query = session.createSQLQuery(sql).addScalar("point", Hibernate.FLOAT);
						Object count = query.uniqueResult();
						if(count==null)
							return Float.valueOf(0);
						else
						    return (Float) count;
					}
				});
	}

	@Override
	public List<StoryTo> getStoriesForSprintByStatus(String sprintId, int status) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("sprint.id", sprintId));
		detachedCriteria.add(Restrictions.eq("status", status));
		detachedCriteria.addOrder(Order.desc("priority"));
		return this.getHibernateTemplate().findByCriteria(detachedCriteria);
	}

	@Override
	public List<StoryTo> getStoriesOfProjectByPager(String projectId, int page,
			int rp) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.addOrder(Order.desc("priority"));
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		return this.getHibernateTemplate().findByCriteria(detachedCriteria, (page-1)*rp, rp);
	}

	@Override
	public List<StoryTo> getStoriesWithNameByPager(String projectId,String nameKeyWord,
			int page, int rp) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		detachedCriteria.add(Restrictions.ilike("name", nameKeyWord, MatchMode.ANYWHERE));
		return this.getHibernateTemplate().findByCriteria(detachedCriteria, (page-1)*rp, rp);
	}

	@Override
	public List<StoryTo> getStoriesWithSortByPager(String projectId,String nameKeyWord,
			int page, int rp, String sortname, String sortorder) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		if("desc".equals(sortorder)){
			detachedCriteria.addOrder(Order.desc(sortname));
		}
		else {
			detachedCriteria.addOrder(Order.asc(sortname));
		}
		return this.getHibernateTemplate().findByCriteria(detachedCriteria, (page-1)*rp, rp);
	}

	@Override
	public List getStoriesForProjectBySearchWithName(String projectId,
			String query) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("project.id", projectId));
		if(query!=null && !("".equals(query)))
		detachedCriteria.add(Restrictions.ilike("name", query, MatchMode.ANYWHERE));
		return this.getHibernateTemplate().findByCriteria(detachedCriteria);

	}

	@Override
	public List<StoryTo> getStoriesForKanban(String sprintId) {
		// TODO Auto-generated method stub
		DetachedCriteria detachedCriteria = DetachedCriteria.forClass(StoryTo.class);
		detachedCriteria.add(Restrictions.eq("sprint.id", sprintId));
		detachedCriteria.add(Restrictions.in("status", new Integer[]{0,1} ));
		detachedCriteria.addOrder(Order.desc("priority"));
		return this.getHibernateTemplate().findByCriteria(detachedCriteria);
	}

	
}
