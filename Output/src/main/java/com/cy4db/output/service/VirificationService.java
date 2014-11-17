package com.cy4db.output.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cy4db.output.dao.Impl.VirificationDaoImpl;
import com.cy4db.output.model.Virification;

@Service
public class VirificationService 
{
	@Autowired
	private VirificationDaoImpl virificationDaoImpl;
	
	@Transactional
	public List<Virification> findAllVirification()
	{
		List<Virification> list = new ArrayList<Virification>();
		list = virificationDaoImpl.find("from Virification");
		return list;
	}
	
	@Transactional
	public List<Virification> findAllBypage(int page,int rows)
	{
		List<Virification> list = new ArrayList<Virification>();
		list = virificationDaoImpl.find("from Virification", page, rows);
		return list;
	}
	
	@Transactional
	public List<Virification> findnoReason(int page,int rows)
	{
		List<Virification> list = new ArrayList<Virification>();
		list = virificationDaoImpl.find("from Virification where reason is null", page, rows);
		return list;
	}
	
	@Transactional
	public List<Virification> findbydate(int page,int rows,Date date)
	{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("date",date);
		List<Virification> list = new ArrayList<Virification>();
		list = virificationDaoImpl.find("from Virification where date=:date",params,page, rows);
		return list;
	}
	
	@Transactional
	public List<Virification> findhaveReason(int page,int rows)
	{
		List<Virification> list = new ArrayList<Virification>();
		list = virificationDaoImpl.find("from Virification where reason is not null", page, rows);
		return list;
	}
	
	@Transactional
	public long countAll()
	{
		long count = virificationDaoImpl.count("select count(*) from Virification");
		return count;
	}
	
	@Transactional
	public long countByTeam(String team)
	{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("team", team);
		long count = virificationDaoImpl.count("select count(*) from Virification where ORG=:team",params);
		return count;
	}
	
	@Transactional
	public List<Virification> findWellByMine(String mine)
	{
		List<Virification> list = new ArrayList<Virification>();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("mine", mine);
		list = virificationDaoImpl.find("from Virification where MINE = :mine", params);
		return list;
	}
	
	@Transactional
	public List<Virification> findWellByTeam(String team,int page,int rows)
	{
		List<Virification> list = new ArrayList<Virification>();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("team", team);
		list = virificationDaoImpl.find("from Virification where ORG = :team",params,page,rows);
		return list;
	}
	
	@Transactional
	public Virification getVirification(String id)
	{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		Virification virification = new Virification();
		virification = virificationDaoImpl.get("from Virification where id =:id",params);
		return virification;
	}
}
