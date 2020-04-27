package member.controller.bean;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import member.model.dao.MemberDAOImpl;
import member.model.vo.MemberVo;

@Controller
@RequestMapping("/member/")
public class MemberBean {

	@Autowired
	private MemberDAOImpl memberDAO = null;
	
	@RequestMapping("signupForm.com")
	public String signupForm() {
		
		return "decide/signupForm";
	}

	
	@RequestMapping("main.com")
	public String main() {
		
		return "decide/main";
	}
	
	
	@RequestMapping("loginForm.com")
	public String loginForm() {
		
		return "decide/loginForm";
	}
	
	
	@RequestMapping("signupPro.com")
	public String signupPro(MemberVo vo) throws Exception{
		
		memberDAO.insertMember(vo);
		
		return "decide/main";
	}
	
	@RequestMapping("loginPro.com")
	public String loginPro(MemberVo vo, Model model, HttpSession session) throws Exception{

		int result = memberDAO.idPwCheck(vo);
		
		if(result == 1) {
			session.setAttribute("memId", vo.getId());
		}
		
		model.addAttribute("result", result);
		
		
		return "decide/loginPro";
	}
	
	@RequestMapping("logout.com")
	public String logout(HttpSession session) {
		
		session.removeAttribute("memId");
		
		return "decide/main";
	}

	@RequestMapping("modifyForm.com")
	public String modifyForm(Model model, HttpSession session) throws Exception{
		
		MemberVo vo = new MemberVo();
		vo = memberDAO.selectMember((String)session.getAttribute("memId"));
		model.addAttribute("vo", vo);
		
		return "decide/modifyForm";
	}
	
	@RequestMapping("modifyPro.com")
	public String modifyPro(MemberVo vo) throws Exception{
		
		memberDAO.updateMember(vo);
		
		return "decide/main";
	}
	
	@RequestMapping("deleteMemberForm.com")
	public String deleteMemberForm() {

		return "decide/deleteMemberForm";
	}
	
	@RequestMapping("deleteMemberPro.com")
	public String deleteMemberPro(MemberVo vo, String id, Model model, HttpSession session) throws Exception{
		
		int result = memberDAO.idPwCheck(vo);
		if(result == 1) {
			memberDAO.deleteMember(id);
			session.removeAttribute("memId");
		}
		model.addAttribute("result", result);
		
		return "decide/deleteMemberPro";
	}
	
	
	@RequestMapping("memberlist.com")
	public String memberlist(Model model) throws Exception{
		
		List member_list = new ArrayList();
		member_list = memberDAO.selectAll();
		model.addAttribute("member_list", member_list);
		
		return "decide/memberlist";
	}
	
	@RequestMapping("idAvailCheck.com")
	public String idAvailCheck(Model model, String id) throws Exception{
		
		int result = memberDAO.idAvailCheck(id);
		model.addAttribute("result", result);
		model.addAttribute("id", id);
		
		return "decide/idAvailCheck";
	}
	
	
	@RequestMapping("ajaxIdAvail.com")
	//@ResponseBody
	public ResponseEntity<String> ajaxIdAvail(String id) throws Exception{
		String result = "";
		int check = memberDAO.idAvailCheck(id);
		if(check == 0) {
			result = "사용가능";
		}else{
			result = "사용 불가능";
		}
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=UTF-8");
		
		
		return new ResponseEntity<String>(result, responseHeaders, HttpStatus.OK);
	
	}
	
	@RequestMapping("myPage.com")
	public String myPage() {
		
		return "decide/myPage";
	}
	
	
}
