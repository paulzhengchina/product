package com.createidea.scrumfriend.service.story;

import java.util.List;

import com.createidea.scrumfriend.to.ProjectTo;
import com.createidea.scrumfriend.to.StoryTo;

public interface StoryService {
	
	public List<StoryTo> getStoriesForProjectByStatus(String projectId,int status);
	
	public void updateStory(StoryTo story);

	public void updateStoryStatus(String card_id, String box_id, String sprintId,String user);

	public StoryTo createStory(StoryTo story, String projectId);

	public List<StoryTo> getActiveStoriesForProject(String projectId);

	public float calculateTotalPointsForProject(ProjectTo project);

	public float calculateCompletedPointForProject(ProjectTo project);

	public float calculateRemainingPointForProject(ProjectTo project);

	public List<StoryTo> getStoriesForSprintByStatus(String sprintId, int status);
	
	public List<StoryTo> getStoriesOfProjectByPager(String projectId,int page,int rp, String qtype, String sortname, String sortorder);

	public List getStoriesForProjectBySearchWithName(String projectId,
			String query);
	
	public StoryTo getStoryById(String storyId);

	public void updateStoryStatus(String storyId, int storyStatus);

	public List<StoryTo> getStoriesForKanban(String sprintId);

	
}
