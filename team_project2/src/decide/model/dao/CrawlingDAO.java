package decide.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import decide.model.vo.CrawlingVo;

public class CrawlingDAO {
	
	private SqlSessionTemplate sqlSession = null;
	public void setSqlSession(SqlSessionTemplate sqlSseion) {
		this.sqlSession = sqlSseion;
	}
	
	public void insertBasic(CrawlingVo vo) throws Exception{
		sqlSession.insert("crawling.insertBasic", vo);
	}
	public void updateMenu(CrawlingVo vo) throws Exception{
		sqlSession.update("crawling.updateMenu", vo);
	}
	public void updatePrice(CrawlingVo vo) throws Exception{
		sqlSession.update("crawling.updatePrice", vo);
	}
	public boolean checkURL(String url) throws Exception{
		int i = sqlSession.selectOne("crawling.checkURL", url);
		boolean check = true;
		if(i == 1) {
			check = false;
		}
		return check;
	}
	public CrawlingVo selectAll(String url) throws Exception{
		CrawlingVo vo = sqlSession.selectOne("crawling.selectAll", url);
		
		return vo;
	}
	
	
	
}
