package com.createidea.scrumfriend.service.impediment;

import java.util.Date;
import java.util.List;

import com.createidea.scrumfriend.dao.impediment.ImpedimentDao;
import com.createidea.scrumfriend.to.ImpedimentTo;

public class ImpedimentServiceImpl implements ImpedimentService {

	private ImpedimentDao impedimentDao;
    
	@Override
	public List<ImpedimentTo> getAllImpediments(String projectId) {
		// TODO Auto-generated method stub
		return impedimentDao.getAllImpediments(projectId);
	}
	
	@Override
	public ImpedimentTo saveOrUpdateImpediment(ImpedimentTo impediment) {
		// TODO Auto-generated method stub
		if(impediment.getCreatedTime()==null)
			impediment.setCreatedTime(new Date());
		return impedimentDao.saveImpediment(impediment);
	}
	
	@Override
	public ImpedimentTo saveAnalyseImpediment(ImpedimentTo impediment) {
		// TODO Auto-generated method stub
		ImpedimentTo previousTo=impedimentDao.getImpediment(impediment.getId());
		previousTo.setReason(impediment.getReason());
		previousTo.setSolution(impediment.getSolution());
		previousTo.setStatus(1);
		previousTo.setFixedBy(impediment.getFixedBy());
		return impedimentDao.saveImpediment(previousTo);
		
	}
	
	@Override
	public ImpedimentTo saveResultImpediment(ImpedimentTo impediment) {
		// TODO Auto-generated method stub
		ImpedimentTo previousTo=impedimentDao.getImpediment(impediment.getId());
		previousTo.setResult(impediment.getResult());
		previousTo.setStatus(impediment.getStatus());
		previousTo.setFixedTime(new Date());
		return impedimentDao.saveImpediment(previousTo);
	}
	
	@Override
	public ImpedimentTo getImpediment(String impedimentId) {
		// TODO Auto-generated method stub
		return impedimentDao.getImpediment(impedimentId);
	}
	
	@Override
	public ImpedimentTo deleteImpediment(String impedimentId) {
		// TODO Auto-generated method stub
		ImpedimentTo impediment=impedimentDao.getImpediment(impedimentId);
		impediment.setStatus(4);
		return impedimentDao.saveImpediment(impediment);
	}
	
	public ImpedimentDao getImpedimentDao() {
		return impedimentDao;
	}

	public void setImpedimentDao(ImpedimentDao impedimentDao) {
		this.impedimentDao = impedimentDao;
	}

	

	

	

	


}
