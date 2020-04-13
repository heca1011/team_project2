package decide.controller.bean;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import decide.crawling.Crawling00;
import decide.model.dao.CrawlingDAO;
import decide.model.vo.CrawlingVo;


@Controller
@RequestMapping("/decide/")
public class DecideBean {

	@Autowired
	private Crawling00 cr;
	@Autowired
	private CrawlingDAO crawlingDAO;
	
	@RequestMapping("search.com")
	public String search(HttpServletRequest req) {
		
		
		
		return "decide/search";
	}
	
	@RequestMapping("foodSelect.com")
	public String foodSelect(String url, Model model){
		CrawlingVo vo = new CrawlingVo();
		
		try {
			boolean check = crawlingDAO.checkURL(url);
			if(check) {
				cr.crawling(url);			
			}				
			vo = crawlingDAO.selectAll(url);

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
		boolean check = favCheck();
		model.addAttribute("favData", check);
		
		return "decide/foodSelect";
	}
	
	@RequestMapping("randomResult.com")
	public String randomResult() {
		
		return "decide/randomResult";
	}
	
	@RequestMapping("sadari.com")
	public String sadari() {
		
		return "decide/sadari";
	}
	
	@RequestMapping("favList.com")
	public String favList() {
		
		
		
		
		return "decide/favList";
	}
	
	public boolean favCheck() {
		boolean check = false;
		
		return check;
	}
	
	public void ajax() {
		boolean check = favCheck();
		if(check) {
			deletefav();
		}else {
			insertfav();
		}
	}
	
	public void insertfav() {
		
	}
	
	public void deletefav() {
		
	}
	
}
