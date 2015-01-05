package com.createidea.scrumfriend.service.sprint;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.createidea.scrumfriend.dao.sprint.SprintDao;
import com.createidea.scrumfriend.dao.story.StoryDao;
import com.createidea.scrumfriend.to.SprintTo;
import com.createidea.scrumfriend.to.TreeNodeTo;

public class SprintServiceImpl implements SprintService {
	private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	private SprintDao sprintDao;
	private StoryDao storyDao;

	public SprintDao getSprintDao() {
		return sprintDao;
	}

	public void setSprintDao(SprintDao sprintDao) {
		this.sprintDao = sprintDao;
	}
    
	public StoryDao getStoryDao() {
		return storyDao;
	}

	public void setStoryDao(StoryDao storyDao) {
		this.storyDao = storyDao;
	}

	

	@Override
	public TreeNodeTo updateSprint(SprintTo sprint) {
		TreeNodeTo node=new TreeNodeTo();
		if(sprint.getParentSprint()!=null&&"".equals(sprint.getParentSprint().getId())){
			sprint.setParentSprint(null);
		}
		if(sprint.getParentSprint()==null){
			SprintTo previousSprint=sprintDao.getSprintById(sprint.getId());
			sprint.setSubSprints(previousSprint.getSubSprints());
		}
	    sprintDao.updateSprint(sprint);
	    node.setName("<Strong>"+sprint.getName()+"</Strong>"+" : "+dateFormat.format(sprint.getStartTime())+"--"+dateFormat.format(sprint.getEndTime()));
		return node;
		
	}


	@Override
	public SprintTo createSprint(SprintTo sprint, String projectId ,String parentSprintId) {
		
		if(parentSprintId!=null&&parentSprintId.length()>30){
			SprintTo parentSprintTo=new SprintTo();
			parentSprintTo.setId(parentSprintId);
			sprint.setParentSprint(parentSprintTo);
		}
		return sprintDao.createSprint(sprint,projectId);
		
	}

	@Override
	public List<SprintTo> getSprintsForProject(String projectId) {
		return sprintDao.getSprintForProject(projectId);
		
	}

	@Override
	public void deleteSprint(String sprintId) {
		sprintDao.deleteSprint(sprintId);
		
	}

	@Override
	public SprintTo getSprintById(String sprintId) {
		return sprintDao.getSprintById(sprintId);
	}

	
	@Override
	public SprintTo getCurrentSprint(String projectId) {
		// TODO Auto-generated method stub
		return sprintDao.getCurrentSprint(projectId,new Date());
	}

	@Override
	public List<TreeNodeTo> prepareSprintTreeNodes(String projectId) {
		// TODO Auto-generated method stub
		TreeNodeTo rootNode=prepareRootNode();
		List sprintNodes=new ArrayList<TreeNodeTo>();
		sprintNodes.add(rootNode);
		List<SprintTo> sprints=sprintDao.getSprintForProject(projectId);
		if(sprints!=null&&sprints.size()>0){
			for(SprintTo sprint : sprints){
				TreeNodeTo node=new TreeNodeTo();
				node.setId(sprint.getId());
				node.setName("<span class='sprint_name'>"+sprint.getName()+"</span>"+" : "+dateFormat.format(sprint.getStartTime())+"--"+dateFormat.format(sprint.getEndTime()));
				if(sprint.getParentSprint()==null){
					node.setpId("0");
					node.setOpen(true);
				}					
				else {
					node.setpId(sprint.getParentSprint().getId());
					node.setOpen(false);
				}
				sprintNodes.add(node);
			}
		}
		return sprintNodes;
	}
	
    private TreeNodeTo prepareRootNode(){
    	TreeNodeTo rootNode=new TreeNodeTo();
    	rootNode.setId("0");
    	rootNode.setpId("-1");
    	rootNode.setName("阶段列表");
    	rootNode.setOpen(true);
    	return rootNode;
    }

	@Override
	public TreeNodeTo createSprintNode(SprintTo sprint, String projectId,String sprintId) {
		// TODO Auto-generated method stub
		sprint=createSprint(sprint, projectId, sprintId);
		TreeNodeTo node=new TreeNodeTo();
		node.setId(sprint.getId());
		node.setName("<Strong>"+sprint.getName()+"</Strong>"+" : "+dateFormat.format(sprint.getStartTime())+"--"+dateFormat.format(sprint.getEndTime()));
		if(sprint.getParentSprint()==null){
			node.setpId("0");
			node.setOpen(true);
		}					
		else {
			node.setpId(sprint.getParentSprint().getId());
			node.setOpen(false);
		}
		return node;
	}

	@Override
	public List<SprintTo> getParentSprints(String projectId) {
		// TODO Auto-generated method stub
		return sprintDao.getParentSprints(projectId);
	}

	  
}
