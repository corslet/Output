package com.cy4db.output;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cy4db.output.dao.Impl.UserDaoImpl;
import com.cy4db.output.model.User;
import com.cy4db.output.service.UserService;
import com.cy4db.output.tools.Json;

@Controller

public class UserController 
{
	@Autowired
	public UserService userService;
	
	@RequestMapping(value="/fuck")
	public String User()
	{
		return "userinfo";
	}
	
	@RequestMapping(value="/adduser")
	public String addUser()
	{
		return "userAdd";
	}
	
	@RequestMapping(value="/edituser")
	public String editUser(HttpServletRequest request,String id)
	{
		User user = new User();
		request.setAttribute("id",id);
		user = userService.getUser(id);
		request.setAttribute("username",user.getUsername());
		request.setAttribute("password",user.getPassword());
		request.setAttribute("mine",user.getMine());
		request.setAttribute("org",user.getOrg());
		return "userEdit";
	}
	
	@ResponseBody
	@RequestMapping("/login")
	public Json login(String username,String password, HttpSession session, HttpServletRequest request) {
		Json j = new Json();
		User u = userService.login(username,password);
		
		if (u != null) {
			j.setSuccess(true);
			j.setMsg("登陆成功！");
			//session.setAttribute("user", u.getMine());
			session.setAttribute("sessionInfo", u);
			session.setAttribute("org", u.getOrg());
			j.setObj(u);
		} else {
			j.setMsg("用户名或密码错误！");
		}
		return j;
	}
	
	@ResponseBody
	@RequestMapping("/logout")
	public Json logout(HttpSession session) {
		Json j = new Json();
		if (session != null) {
			session.invalidate();
		}
		j.setSuccess(true);
		j.setMsg("注销成功！");
		return j;
	}
	
	@ResponseBody
	@RequestMapping("/findAllUser")
	public List<User> findAllUser()
	{
		List<User> list = new ArrayList<User>();
		list = userService.findAllUsers();
		return list;
	}
	
	@RequestMapping("/add")
	@ResponseBody
	public Json add(String username,String password,String org,String mine) {
		Json j = new Json();
		try {
			userService.add(username,password,org,mine);
			j.setSuccess(true);
			j.setMsg("添加成功！");
			j.setObj(username);
		} catch (Exception e) {
			j.setMsg(e.getMessage());
		}
		return j;
	}
	
	@RequestMapping("/edit")
	@ResponseBody
	public Json edit(String id,String username,String password,String mine,String org) {
		Json j = new Json();
		try {
			userService.edit(id,username,password,mine,org);
			j.setSuccess(true);
			j.setMsg("编辑成功！");
			j.setObj(username);
		} catch (Exception e) {
			// e.printStackTrace();
			j.setMsg(e.getMessage());
		}
		return j;
	}
}
