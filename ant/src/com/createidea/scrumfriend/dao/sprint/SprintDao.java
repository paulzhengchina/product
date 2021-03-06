package com.createidea.scrumfriend.dao.sprint;

import java.util.Date;
import java.util.List;

import com.createidea.scrumfriend.to.SprintTo;
import com.createidea.scrumfriend.to.StoryTo;


public interface SprintDao {

	public List<SprintTo> sprintsByStatus(int status);
	
	public void updateSprint(SprintTo sprint);

	public SprintTo getSprintById(String sprintId);

	public List<SprintTo> getSprintForProject(String projectId);

	public SprintTo createSprint(SprintTo sprint,String projectId);

	public List<SprintTo> getSprintsForProjectByStatus(String projectId,int status);

	public void deleteSprint(String sprintId);

	public SprintTo getCurrentSprint(String projectId, Date date);

	public List<SprintTo> getSprintsFinishedYesterday(Date today,Date twoDaysAgo);

	public List<SprintTo> getSprintWithNoChildrenForProject(String projectId);

}
