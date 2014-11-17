package com.cy4db.output.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cy4db.output.dao.Impl.UserDaoImpl;
import com.cy4db.output.model.User;
import com.cy4db.output.model.Virification;


@Service
public class UserService 
{
	@Autowired
	private UserDaoImpl userDaoImpl;
	
	@Transactional
	public User login(String username,String password) {
		User user = new User();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", username);
		params.put("pwd", password);
		User t = userDaoImpl.get("from User t where t.username = :name and t.password = :pwd", params);
		if (t != null) {
			BeanUtils.copyProperties(t, user);
			return user;
		}
		return null;
	}
	
	@Transactional
	public List<User> findAllUsers()
	{
		List<User> list = new ArrayList<User>();
		list = userDaoImpl.find("from User");
		return list;
	}
	
	@Transactional
	synchronized public void add(String username,String password,String org,String mine) throws Exception {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("name", username);
		if (userDaoImpl.count("select count(*) from User t where t.username = :name", params) > 0) {
			throw new Exception("登录名已存在！");
		} else {
			User u = new User();
			String uid = UUID.randomUUID().toString().replace("-", "");
			u.setPassword(password);
			u.setId(uid);
			u.setOrg(org);
			u.setMine(mine);
			u.setUsername(username);;
			userDaoImpl.save(u);
		}
	}
	
	@Transactional
	public void edit(String id,String username,String password,String mine,String org)
	{
		User user = new User();
		user.setId(id);
		user.setUsername(username);
		user.setPassword(password);
		user.setOrg(org);
		user.setMine(mine);
		userDaoImpl.update(user);
	}
	
	@Transactional
	public void delete(String id)
	{
		User user = new User();
		user.setId(id);
		userDaoImpl.delete(user);
	}
	
	@Transactional
	public User getUser(String id)
	{
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("id", id);
		User user = new User();
		user = userDaoImpl.get("from User where ID =:id",params);
		return user;
	}
}
