package member.model.dao;

import java.util.List;

import member.model.vo.MemberVo;


/* ���� ����..
  DB : Oracle
  SID : ORCL
  IPADD : @nullmaster.iptime.org
  PORT : 3000
  ...
*/

public interface MemberDAO {
	public void insertMember(MemberVo vo) throws Exception;
	public int idPwCheck(MemberVo vo) throws Exception;
	public List selectAll() throws Exception;
	public String selectMemberPw(String id) throws Exception;
	public void updateMember(MemberVo vo) throws Exception;
	public void deleteMember(String id) throws Exception;
	public int idAvailCheck(String id) throws Exception;
}
