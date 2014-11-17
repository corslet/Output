package com.cy4db.output.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="VER_V_SEP")
public class Virification 
{
	private String id;
	private String WELLNUM;
	private Date date;
	private String BZ;
	private String REASON;
	private String MINE;
	private String ORG;
	
	private String dizhireason;
	private Date dizhidate;
	private String gongyireason;
	private Date gongyidate;
	private String zuoyereason;
	private Date zuoyedate;
	private String gongjireason;
	private Date gongjidate;
	private String ceshireason;
	private Date ceshidate;
	
	@Column(name="地质原因")
	public String getDizhireason() {
		return dizhireason;
	}
	public void setDizhireason(String dizhireason) {
		this.dizhireason = dizhireason;
	}
	
	@Column(name="地质日期")
	public Date getDizhidate() {
		return dizhidate;
	}
	public void setDizhidate(Date dizhidate) {
		this.dizhidate = dizhidate;
	}
	
	@Column(name="工艺队原因")
	public String getGongyireason() {
		return gongyireason;
	}
	public void setGongyireason(String gongyireason) {
		this.gongyireason = gongyireason;
	}
	
	@Column(name="工艺队日期")
	public Date getGongyidate() {
		return gongyidate;
	}
	public void setGongyidate(Date gongyidate) {
		this.gongyidate = gongyidate;
	}
	
	@Column(name="作业原因")
	public String getZuoyereason() {
		return zuoyereason;
	}
	public void setZuoyereason(String zuoyereason) {
		this.zuoyereason = zuoyereason;
	}
	
	@Column(name="作业日期")
	public Date getZuoyedate() {
		return zuoyedate;
	}
	public void setZuoyedate(Date zuoyedate) {
		this.zuoyedate = zuoyedate;
	}
	
	@Column(name="工技原因")
	public String getGongjireason() {
		return gongjireason;
	}
	public void setGongjireason(String gongjireason) {
		this.gongjireason = gongjireason;
	}
	
	@Column(name="工技日期")
	public Date getGongjidate() {
		return gongjidate;
	}
	public void setGongjidate(Date gongjidate) {
		this.gongjidate = gongjidate;
	}
	
	@Column(name="测试原因")
	public String getCeshireason() {
		return ceshireason;
	}
	public void setCeshireason(String ceshireason) {
		this.ceshireason = ceshireason;
	}
	
	@Column(name="测试日期")
	public Date getCeshidate() {
		return ceshidate;
	}
	public void setCeshidate(Date ceshidate) {
		this.ceshidate = ceshidate;
	}
	
	@Column(name="矿名")
	public String getMINE() {
		return MINE;
	}
	public void setMINE(String mINE) {
		MINE = mINE;
	}
	
	@Column(name="队名")
	public String getORG() {
		return ORG;
	}
	public void setORG(String oRG) {
		ORG = oRG;
	}
	
	
	@Id
	@Column(name="VERID")
	public String getid() {
		return id;
	}
	public void setid(String vERID) {
		id = vERID;
	}
	
	@Column(name="井号")
	public String getWELLNUM() {
		return WELLNUM;
	}
	public void setWELLNUM(String wELLNUM) {
		WELLNUM = wELLNUM;
	}
	
	@Column(name="日期")
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	
	@Column(name="备注")
	public String getBZ() {
		return BZ;
	}
	public void setBZ(String bZ) {
		BZ = bZ;
	}
	
	@Column(name="原因")
	public String getREASON() {
		return REASON;
	}
	public void setREASON(String rEASON) {
		REASON = rEASON;
	}
	
	
}
