package member.model.vo;

import java.sql.Timestamp;

public class MemberVo {
	
	private String id;
	private String pw;
	private Timestamp reg;
	
	
	public Timestamp getReg() {
		return reg;
	}
	public void setReg(Timestamp reg) {
		this.reg = reg;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	

}
