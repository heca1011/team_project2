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
	
	
	//ȸ�� ����
	public void insertMember(MemberVo vo) throws Exception;
	//���̵� ��� Ȯ��
	public int idPwCheck(MemberVo vo) throws Exception;
	//��ü ȸ�� ������ ��ȸ
	public List selectAll() throws Exception;
	//ȸ�� �Ѹ��� ��й�ȣ ��ȸ
	public String selectMemberPw(String id) throws Exception;
	//ȸ�� ������ ����
	public void updateMember(MemberVo vo) throws Exception;
	//ȸ�� ������ ����
	public void deleteMember(String id) throws Exception;
	//���̵� ��밡�ɿ��� ��ȸ
	public int idAvailCheck(String id) throws Exception;
}
