package moonboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.CookieManager;
import utils.JSFunction;

@WebServlet("*.log")
public class LogController extends HttpServlet {
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		String uri = req.getRequestURI();
		int lastSlash = uri.lastIndexOf("/");
		String commandStr = uri.substring(lastSlash);
		
		if(commandStr.equals("/main.log")) {
			main(req, resp);
		}
		if(commandStr.equals("/signup.log")) {
			signup(req, resp);
		}
		else if(commandStr.equals("/signupAction.log")) {
			signupAction(req, resp);
		}
		else if(commandStr.equals("/overlap.log")) {
			overLap(req, resp);
		}
		if(commandStr.equals("/login.log")) {
			login(req, resp);
		}
		else if(commandStr.equals("/loginAction.log")) {
			loginAction(req, resp);
		}
		if(commandStr.equals("/logout.log")) {
			logout(req, resp);
		}
		if(commandStr.equals("/idfind.log")) {
			idfind(req, resp);
		}
		else if(commandStr.equals("/idfindAction.log")) {
			idfindAction(req, resp);
		}
		if(commandStr.equals("/passfind.log")) {
			passfind(req, resp);
		}
		else if(commandStr.equals("/passfindAction.log")) {
			passfindAction(req, resp);
		}
		
	}
	protected void main(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		req.getRequestDispatcher("./MOONBOARD/Main.jsp").forward(req, resp);
	}
	
	protected void signup(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		req.getRequestDispatcher("./MOONBOARD/SignUp.jsp").forward(req, resp);
	}
	
	protected void signupAction(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		String citizencode = req.getParameter("citizencode");
		String pass = req.getParameter("pass");
		String name = req.getParameter("name");
		String birth = req.getParameter("birth");
		String zipcode = req.getParameter("zipcode");
		String compaddr = req.getParameter("compaddr1");
		String compaddr2 = req.getParameter("compaddr2");
		String email = req.getParameter("email1")+"@"+req.getParameter("email2");
		String mobile =req.getParameter("mobile1")+"-"+req.getParameter("mobile2")+"-"+req.getParameter("mobile3");
		String tel = req.getParameter("tel1")+"-"+req.getParameter("tel2")+"-"+req.getParameter("tel3");
		String code = (String)session.getAttribute("CODE");
		
		MemberShipDTO dto = new MemberShipDTO();
		dto.setCitizencode(citizencode);
		dto.setPass(pass);
		dto.setName(name);
		dto.setBirth(birth);
		dto.setZipcode(zipcode);
		dto.setCompaddr(compaddr);
		dto.setCompaddr2(compaddr2);
		dto.setEmail(email);
		dto.setMobile(mobile);
		dto.setTel(tel);
		dto.setCode(code);
		
		MemberShipDAO dao = new MemberShipDAO();
		int result = dao.insertMember(dto);
		dao.close();
		
		if(result==1) {
			JSFunction.alertLocation(resp, "회원가입이 완료되었습니다.", "./main.log");
		}
		else {
			JSFunction.alertBack(resp, "게시물 입력이 잘못되었습니다.");
		}
	}
	
	protected void overLap(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String citizencode = req.getParameter("citizencode");
		MemberShipDAO dao = new MemberShipDAO();
		
		boolean confirmOverlap = dao.confirmOverlap(citizencode);
		if(confirmOverlap==true) {		
			JSFunction.popupClose(resp, "중복된 정보 입니다.");
		}
		else {
			JSFunction.alert(resp, "사용하실수 있는 정보입니다.");
		}
	}
	
	protected void login(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		req.getRequestDispatcher("./MOONBOARD/Login.jsp").forward(req, resp);
	}
	
	protected void loginAction(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String citizencode = req.getParameter("citizencode");
		String pass = req.getParameter("pass");
		String save_check = req.getParameter("save_check");
		
		MemberShipDAO dao = new MemberShipDAO();
		boolean result = dao.confirmLogin(pass, citizencode);
		MemberShipDTO dto = dao.humantypefind(citizencode, pass);
		String humantype = dto.getHumantype();
		
		if(result==true) {
			if(save_check!=null && save_check.equals("Y")) {
				CookieManager.makeCookie(resp, "loginId", citizencode, 86400);
			}
			else {
				CookieManager.deleteCookie(resp, "loginId");
			}
			dao.close();
			HttpSession session = req.getSession();
			session.setAttribute("CITIZENCODE", citizencode);
			session.setAttribute("HUMANTYPE", humantype);
			req.getRequestDispatcher("./MOONBOARD/Main.jsp").forward(req, resp);
		}
		else {
			JSFunction.alertBack(resp, "로그인정보가 올바르지 않습니다.");
		}
	}
	
	protected void logout(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		session.removeAttribute("CITIZENCODE");
		session.invalidate();
		resp.sendRedirect("../MOONBOARD/Main.jsp");
	}
	
	protected void idfind(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		resp.sendRedirect("../MOONBOARD/IDFind.jsp");
	}
	
	protected void idfindAction(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String code = req.getParameter("code");
		String name = req.getParameter("name");
		MemberShipDAO dao = new MemberShipDAO();
		
		MemberShipDTO dto = dao.confirmID(code, name);
		
		if(dto.getCitizencode()!=null) {
			String msg = dto.getCitizencode();
			JSFunction.alertLocation(resp, "회원코드 : "+msg, "../MOONBOARD/Login.jsp");
		}
		else {
			JSFunction.alertBack(resp, "정보가 올바르지 않습니다.");
		}
	}
	
	protected void passfind(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		resp.sendRedirect("../MOONBOARD/PASSFind.jsp");
	}
	
	protected void passfindAction(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String code = req.getParameter("code");
		String citizencode = req.getParameter("citizencode");
		MemberShipDAO dao = new MemberShipDAO();
		
		MemberShipDTO dto = dao.confirmPASS(code, citizencode);
		
		if(dto.getPass()!=null) {
			String msg = dto.getPass();
			JSFunction.alertLocation(resp, "회원비밀번호 : "+msg, "../MOONBOARD/Login.jsp");
		}
		else {
			JSFunction.alertBack(resp, "정보가 올바르지 않습니다.");
		}
	}
	
}
