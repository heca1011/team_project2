package member.model.dao;

import java.util.List;

import member.model.vo.MemberVo;


/* 세팅 정보..
  DB : Oracle
  SID : ORCL
  IPADD : @nullmaster.iptime.org
  PORT : 3000
  ...
*/

public interface MemberDAO {
	
	
	//회원 가입
	public void insertMember(MemberVo vo) throws Exception;
	//아이디 비번 확인
	public int idPwCheck(MemberVo vo) throws Exception;
	//전체 회원 데이터 조회
	public List selectAll() throws Exception;
	//회원 한명의 비밀번호 조회
	public String selectMemberPw(String id) throws Exception;
	//회원 데이터 수정
	public void updateMember(MemberVo vo) throws Exception;
	//회원 데이터 삭제
	public void deleteMember(String id) throws Exception;
	//아이디 사용가능여부 조회
	public int idAvailCheck(String id) throws Exception;
}
