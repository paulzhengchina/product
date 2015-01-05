package com.createidea.scrumfriend.service.sprint;

import java.util.List;

import com.createidea.scrumfriend.to.SprintTo;
import com.createidea.scrumfriend.to.StoryTo;
import com.createidea.scrumfriend.to.TreeNodeTo;

public interface SprintService {
	
	
	public TreeNodeTo updateSprint(SprintTo sprint);
	
	public void deleteSprint(String sprintId);

	public SprintTo createSprint(SprintTo sprint, String projectId, String sprintId);

	public List<SprintTo> getSprintsForProject(String projectId);
	
	public SprintTo getSprintById(String sprintId);

	public SprintTo getCurrentSprint(String projectId);

	public TreeNodeTo createSprintNode(SprintTo sprint, String projectId,String sprintId);
	
	public  List<SprintTo> getParentSprints(String projectId);

	
}
