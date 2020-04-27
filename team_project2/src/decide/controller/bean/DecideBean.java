package decide.controller.bean;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import decide.crawling.Crawling00;
import decide.model.dao.CrawlingDAO;
import decide.model.dao.FavListDAO;
import decide.model.dao.HistoryDAO;
import decide.model.dao.QandaDAO;
import decide.model.vo.CrawlingVo;
import decide.model.vo.FavListVO;
import decide.model.vo.HistoryVo;


@Controller
@RequestMapping("/decide/")
public class DecideBean {

	@Autowired
	private Crawling00 cr;
	@Autowired
	private CrawlingDAO crawlingDAO;
	@Autowired
	private QandaDAO qandaDAO;
	@Autowired
	private HistoryDAO historyDAO;
	@Autowired
	private FavListDAO favlistDAO;
	
	@RequestMapping("test.com")
	public String test() {
		return "decide/test";
	}
	
	@RequestMapping("main.com")
	public String main() {
		
		return "decide/main";
	}
	@RequestMapping("ajaxRoulette.com")
	public ResponseEntity<String> ajaxRoulette(String option) throws Exception{
		
		//해당질문에 대한 답 가져오기
		System.out.println("controller : " + option);
		String result = "";
		String[] foodList = {"오므라이스","김치볶음밥","연어덮밥",
				"수육","아귀찜","순두부찌개","콩나물국밥","해장국","스파게티","파스타","냉면",
				"칼국수","우동","콩국수","육개장","떡국","갈비탕","삼계탕","샌드위치","떡볶이",
				"햄버거","핫도그","쌀국수","마라탕"};
		if(option != null) {
			String opt[] = option.split(",");
//			for(int i =0; i < opt.length; i++) {
//				String selectList[] = qandaDAO.selectAns(opt[i]).split(",");
//				String resultList = "";
//				for(int j =0; j<foodList.length; j++) {
//					boolean flag = false;
//					for(int k =0; k<selectList.length; k++) {
//						if(foodList[j].equals(selectList[k])) {
//							flag = true;
//							break;
//						}
//					}
//			        if(flag) {
//			        	resultList += foodList[j]+",";
//			        }
//			    }
//				foodList = resultList.split(",");
//			}
			for(String roulette : foodList) {
				result += ","+ roulette;
			}
		}
		System.out.println("옵션선택으로 걸러진 음식들 :" + result);
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=UTF-8");
		
		
		return new ResponseEntity<String>(result, responseHeaders, HttpStatus.OK);
	}
	@RequestMapping("RouletteOption.com")
	public String RouletteOption() {
		
		
		return "decide/RouletteOption";
	}
	
	
	/// 검색 ////
	@RequestMapping("search.com")
	public String search(HttpServletRequest req, Model model) {
		
		String keyword = req.getParameter("keyword");
		if(req.getParameter("check") != null) {
			model.addAttribute("check", req.getParameter("check"));
		}else {
			model.addAttribute("check", 1);
		}
		model.addAttribute("keyword", keyword);
		
		return "decide/search";
	}
	
	/// 음식점 정보 ///
	@RequestMapping("foodSelect.com")
	public String foodSelect(FavListVO favVo,String url, Model model, HttpSession session){
		CrawlingVo vo = new CrawlingVo();
		try {
			boolean check = crawlingDAO.checkURL(url);
			if(check) {
				cr.crawling(url);			
			}				
			vo = crawlingDAO.selectAll(url);
			////////////////////////방문기록 저장, 좋아요 등록/////////////////////////
			if(session.getAttribute("memId") != null) {
				String id = (String)session.getAttribute("memId");
				HistoryVo Hvo = new HistoryVo();
				SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
				Date time = new Date();
				int date = Integer.parseInt(format1.format(time));
				Hvo.setUrl(url);
				Hvo.setDay(date);
				Hvo.setId(id);
				if(historyDAO.checkHistory(Hvo) == 0) {
					Hvo.setAddress(vo.getAddress());
					Hvo.setName(vo.getName());
					
					historyDAO.insertHistory(Hvo);
				}
				
				// 가게이름
				favVo.setName(vo.getName());
				//가게 주소
				favVo.setAddress(vo.getAddress());
				// 사이트 주소
				favVo.setUrl(vo.getUrl());
				favVo.setId(id);
				try {			
					boolean check1 = favCheck(favVo);
					model.addAttribute("favData", check1);
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
			///////////////////////////////////////////////////////
			if(vo.getMenu() != null) {				
				String[] menu = vo.getMenu().split(",");
				model.addAttribute("menu", menu);
			}
			if(vo.getPrice() != null) {
				String[] price = vo.getPrice().split("원");
				model.addAttribute("price", price);				
			}		
			model.addAttribute("vo", vo);
			
		}catch(Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("url", url);
		
		return "decide/foodSelect";
	}
	
	// 랜덤결과값 (js단으로 나누어 삭제예정)
	@RequestMapping("randomResult.com")
	public String randomResult() {
		
		return "decide/randomResult";
	}
	
	////////////// 사다리 ///////////////////
	
	@RequestMapping("sadariSelect.com")
	public String sadariSelect() {
		return "decide/sadariSelect";
	}	
	@RequestMapping("sadari.com")
	public String sadari() {		
		return "decide/sadari";
	}
	@RequestMapping("nomalSadari.com")
	public String nomalSadari() {
		return "decide/nomalSadari";
	}
	
	@RequestMapping("sadariResult.com")
	public String sadariResult(HttpServletRequest request, Model model) {
		String[] sel = request.getParameterValues("select");
		int j = 0;
		String x = null;
		for(int i = sel.length-1; i>=0; i -= 1) {
			j = (int)Math.floor(Math.random() * i);
			x = sel[i];
			sel[i] = sel[j];
			sel[j] = x;
		}
		int nNum = sel.length;
		
		model.addAttribute("select", sel);
		model.addAttribute("nNum", nNum);
		
		return "decide/sadariResult";
	}
	
	/////////////////////////////////////////////
	
	//////////////// 즐겨찾기 ///////////////////
	//해당 아이디에 이 매장이 저장되어있는지 DB에서 체크한다.
		//ajax 에 저장 하러 감
		public boolean favCheck(FavListVO favVo) throws Exception{
			boolean check = false;
			int count = favlistDAO.countfav(favVo);			
			if(count == 1) {				
					check = true;
				}else{			
					check = false;		
				}
			return check;
		}
		
		//ajax실행
		@RequestMapping("success.com")
		public void ajax(FavListVO favVo, String text, HttpSession session) throws Exception {
			favVo.setId((String)session.getAttribute("memId"));
			boolean check = favCheck(favVo);					
				if(text.equals("♥")) {
					 deleteFav(favVo);				 
					}else {
					insertFav(favVo);
				 }							
		}	
		//즐겨찾기 추가
		public void insertFav(FavListVO favVo) throws Exception {			
			favlistDAO.insertfav(favVo);			
		}
		//즐겨찾기 해제
		public void deleteFav(FavListVO favVo) throws Exception {
			favlistDAO.deletefav(favVo);
		}
		
		@RequestMapping("fav.com")
		public void ajax(FavListVO favVo, HttpSession session) throws Exception {
			favVo.setId((String)session.getAttribute("memId"));
			deleteFav(favVo);				
		}	

		@RequestMapping("favList.com")
		public String searchFav(Model model, HttpSession session) throws Exception{
			String id = (String)session.getAttribute("memId");
			List list = favlistDAO.searchName(id);
		
			System.out.println(list);
			
			model.addAttribute("vo", list);
			
			return "decide/favList";
		}
	//////////////////////////////////////////////////
	
	
	@RequestMapping("qanda.com")
	public String qanda() {
		
		
		return "decide/qanda";
	}
	
	@RequestMapping("ajaxQA.com")
	public ResponseEntity<String> ajaxQA(String ansList) throws Exception{
		
		String result = "";
		//음식전체목록
		String[] foodList = {"비빔밥","스시","죽","김밥","라면","덮밥","볶음밥","제육볶음","순대",
				"순대국밥","짜장면","볶음밥","짜장밥","짬뽕","짬뽕밥","잔치국수","불고기","찜닭"
				,"닭볶음탕","부대찌개","김치찌개","카레","오므라이스","김치볶음밥","연어덮밥",
				"수육","아귀찜","순두부찌개","콩나물국밥","해장국","스파게티","파스타","냉면",
				"칼국수","우동","콩국수","육개장","떡국","갈비탕","삼계탕","샌드위치","떡볶이",
				"햄버거","핫도그","쌀국수","마라탕"};
		
		if(ansList != "") {
			String ans[] = ansList.split(",");
			for(int i =0; i < ans.length; i++) {
				//해당질문에 대한 답 가져오기
				String selectList[] = qandaDAO.selectAns(ans[i]).split(",");
				String resultList = "";
				
				for(int j =0; j<foodList.length; j++) {
					boolean flag = false;
					for(int k =0; k<selectList.length; k++) {
						if(foodList[j].equals(selectList[k])) {
							flag = true;
							break;
						}
					}
			        if(flag) {
			        	resultList += foodList[j]+",";
			        }
			    }
				foodList = resultList.split(",");
			}
		}
		int foodLen = foodList.length;
		int index = 0;
		if(foodLen > 0) {
			index = (int)Math.floor(Math.random() * foodLen);
		}
		result = foodList[index];
		
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=UTF-8");
		
		
		return new ResponseEntity<String>(result, responseHeaders, HttpStatus.OK);
		//									결과값					상태정보(201:created)
		//											헤더정보			생성작업요청받앗으며
		//															성공햇다는 의미
		
	}
	
	@RequestMapping("history.com")
	public String history(Model model, HttpSession session) {
		if(session.getAttribute("memId") != null) {
			String id = (String)session.getAttribute("memId");
			SimpleDateFormat format1 = new SimpleDateFormat ("yyyyMMdd");
			Date today_ = new Date();
			Calendar cal = Calendar.getInstance();
			
			int today = Integer.parseInt(format1.format(today_));
			cal.add(cal.DATE, -1);
			int yesterday = Integer.parseInt(format1.format(cal.getTime()));
			cal.add(cal.DATE, -1);
			int twoAgo = Integer.parseInt(format1.format(cal.getTime()));
	
			List history = new ArrayList();
			try {
				history = historyDAO.viewHistory(id);			
			}catch (Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("today", today);
			model.addAttribute("yesterday", yesterday);
			model.addAttribute("twoAgo", twoAgo);
			model.addAttribute("history", history);
			
			return "decide/history";
		}
		return "decide/main";
	}
	
	@RequestMapping("myPage.com")
	public String myPage() {
		
		return "decide/myPage";
	}
	
	
}
