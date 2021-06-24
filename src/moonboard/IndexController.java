package moonboard;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.JSFunction;

@WebServlet("/index")
public class IndexController extends HttpServlet {
	
	@Override
	protected void doPost (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String code = req.getParameter("code");
		
		IndexDAO dao = new IndexDAO();
		boolean result = dao.confirmIndex(code);
		
		if(result==true) {
			dao.close();
			HttpSession session = req.getSession();
			session.setAttribute("CODE", code);
			req.getRequestDispatcher("./MOONBOARD/Main.jsp").forward(req, resp);
		}
		else {
			dao.close();
			JSFunction.alertBack(resp, "코드가 잘못되었습니다.");
		}
	}
}
