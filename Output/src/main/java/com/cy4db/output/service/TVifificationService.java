package com.cy4db.output.service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cy4db.output.dao.Impl.TVirificationDaoImpl;
import com.cy4db.output.model.TVirification;

@Service
public class TVifificationService 
{
	@Autowired
	private TVirificationDaoImpl tVirificationDaoImpl;
	
	@Transactional
	public void addReason(String id,String reason)
	{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("reason", reason);
		params.put("id", id);
		tVirificationDaoImpl.executeSql("update VERIFICATION_SEP set reason=:reason where VERID = :id", params);
	}
}
