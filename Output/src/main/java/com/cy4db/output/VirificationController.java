package com.cy4db.output;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cy4db.output.model.Virification;
import com.cy4db.output.service.TVifificationService;
import com.cy4db.output.service.VirificationService;
import com.cy4db.output.tools.Json;

@Controller
public class VirificationController 
{
	@Autowired
	private VirificationService virificationService;
	
	@Autowired
	private TVifificationService tVirificationService;
	
	@RequestMapping(value="/virification")
	public String Virification()
	{
		return "reason";
	}
	
	@RequestMapping(value = "/editPage",method = RequestMethod.GET)
	public String editPage(HttpServletRequest request, String id) 
	{
		Virification virification = new Virification();
		virification = virificationService.getVirification(id);
		request.setAttribute("id",id);
		request.setAttribute("wellnum", virification.getWELLNUM());
		return "checkedit";
	}
	
	@ResponseBody 
	@RequestMapping(value = "/getall", method = RequestMethod.POST)
	public Map getStorefront(int page,int rows) 
	{
		Map<String,Object> model = new HashMap<String,Object>();
		List<Virification> list =new ArrayList<Virification>();
		list = virificationService.findAllBypage(page, rows);
		long count = virificationService.countAll();
		model.put("total",count);
		model.put("rows",list);
		return model;
	}
	
	@ResponseBody 
	@RequestMapping(value = "/getteambypage", method = RequestMethod.POST)
	public Map getTeamByPage(int page,int rows, HttpSession session, HttpServletRequest request) 
	{
		String team = session.getAttribute("org").toString();
		Map<String,Object> model = new HashMap<String,Object>();
		List<Virification> list =new ArrayList<Virification>();
		list = virificationService.findWellByTeam(team, page, rows);
		long count = virificationService.countByTeam(team);
		model.put("total",count);
		model.put("rows",list);
		return model;
	}
	
	@ResponseBody 
	@RequestMapping(value = "/getteambypage1", method = RequestMethod.POST)
	public Map getWellByPage(int page,int rows, HttpSession session, HttpServletRequest request) 
	{
		String team = session.getAttribute("org").toString();
		Map<String,Object> model = new HashMap<String,Object>();
		List<Virification> list =new ArrayList<Virification>();
		list = virificationService.findWellByTeam(team, page, rows);
		long count = virificationService.countByTeam(team);
		model.put("total",count);
		model.put("rows",list);
		return model;
	}
	
	@ResponseBody 
	@RequestMapping(value = "/getbymine", method = RequestMethod.GET)
	public List<Virification> getbyMine(String mine) 
	{
		List<Virification> list =new ArrayList<Virification>();
		list = virificationService.findWellByMine(mine);
		return list;
	}
	
	@ResponseBody 
	@RequestMapping(value = "/addreason", method = RequestMethod.POST)
	public Json addreason(String id,String reason) 
	{
		Json j = new Json();
		try {
			tVirificationService.addReason(id, reason);
			j.setSuccess(true);
			j.setMsg("添加成功！");
			j.setObj(reason);
		} catch (Exception e) {
			// e.printStackTrace();
			j.setMsg(e.getMessage());
		}
		return j;
	}
}
