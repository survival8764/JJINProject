package moonboard;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import common.BoardConfig;
import fileupload.FileUtil;
import utils.BoardPage;
import utils.JSFunction;

@WebServlet("*.board")
public class BoardController extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		String uri = req.getRequestURI();
		int lastSlash = uri.lastIndexOf("/");
		String commandStr = uri.substring(lastSlash);
		
		//free
		if(commandStr.equals("/free.board")) {
			Board(req, resp);
		}
		else if(commandStr.equals("/freewrite.board")) {
			BoardWrite(req, resp);
		}
		else if(commandStr.equals("/freewriteaction.board")) {
			BoardWriteAction(req, resp);
		}
		else if(commandStr.equals("/freeview.board")) {
			BoardView(req, resp);
		}
		else if(commandStr.equals("/freefix.board")) {
			BoardFix(req, resp);
		}
		else if(commandStr.equals("/freefixaction.board")) {
			BoardFixAction(req, resp);
		}
		else if(commandStr.equals("/freeremove.board")) {
			BoardRemove(req, resp);
		}
		else if(commandStr.equals("/freedown.board")) {
			BoardDownload(req, resp);
		}
		
		//notice
		if(commandStr.equals("/notice.board")) {
			Board(req, resp);
		}
		else if(commandStr.equals("/noticewrite.board")) {
			BoardWrite(req, resp);
		}
		else if(commandStr.equals("/noticewriteaction.board")) {
			BoardWriteAction(req, resp);
		}
		else if(commandStr.equals("/noticeview.board")) {
			BoardView(req, resp);
		}
		else if(commandStr.equals("/noticefix.board")) {
			BoardFix(req, resp);
		}
		else if(commandStr.equals("/noticefixaction.board")) {
			BoardFixAction(req, resp);
		}
		else if(commandStr.equals("/noticeremove.board")) {
			BoardRemove(req, resp);
		}
		else if(commandStr.equals("/noticedown.board")) {
			BoardDownload(req, resp);
		}
		
		//picture
		if(commandStr.equals("/picture.board")) {
			Board(req, resp);
		}
		else if(commandStr.equals("/picturewrite.board")) {
			BoardWrite(req, resp);
		}
		else if(commandStr.equals("/pictureewriteaction.board")) {
			BoardWriteAction(req, resp);
		}
		else if(commandStr.equals("/pictureview.board")) {
			BoardView(req, resp);
		}
		else if(commandStr.equals("/picturefix.board")) {
			BoardFix(req, resp);
		}
		else if(commandStr.equals("/picturefixaction.board")) {
			BoardFixAction(req, resp);
		}
		else if(commandStr.equals("/pictureremove.board")) {
			BoardRemove(req, resp);
		}
		else if(commandStr.equals("/picturedown.board")) {
			BoardDownload(req, resp);
		}
		
	}
	
	//free
	protected void Board (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
			
		BoardDAO dao = new BoardDAO();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		String boardtype = req.getParameter("boardtype");
		map.put("boardtype", boardtype);
		
		if(searchWord != null) {
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		
		int totalCount = dao.selectCount(map);
		
		int pageSize = BoardConfig.PAGE_PER_SIZE;
		int blockPage = BoardConfig.PAGE_PER_BLOCK;
		
		int pageNum = 1;
		String pageTemp = req.getParameter("pageNum");
		
		if(pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);
		
		int start = (pageNum-1) * pageSize;
		int end = pageSize;
		map.put("start", start);
		map.put("end", end);
		
		List<BoardDTO> boardLists = dao.selectListPage(map);
		dao.close();
		
		String pagingImg = BoardPage.pagingImg(totalCount, pageSize, 
				blockPage, pageNum, "./"+boardtype+".board?boardtype="+boardtype);
		map.put("pagingImg", pagingImg);
		map.put("totalCount", totalCount);
		map.put("pageSize", pageSize);
		map.put("pageNum", pageNum);
		
		req.setAttribute("boardLists", boardLists);
		req.setAttribute("map", map);
		
		if(boardtype.equals("free")) {
			req.getRequestDispatcher("./MOONBOARD/FreeBoard.jsp").forward(req, resp);
		}
		else if(boardtype.equals("notice")) {
			req.getRequestDispatcher("./MOONBOARD/NoticeBoard.jsp").forward(req, resp);
		}
		else if(boardtype.equals("picture")) {
			req.getRequestDispatcher("./MOONBOARD/PictureBoard.jsp").forward(req, resp);
		}
		
	}
	
	protected void BoardWrite (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String boardtype = req.getParameter("boardtype");
		
		if(boardtype.equals("free")) {
			req.getRequestDispatcher("./MOONBOARD/FreeBoardWrite.jsp").forward(req, resp);
		}
		else if(boardtype.equals("notice")) {
			req.getRequestDispatcher("./MOONBOARD/NoticeBoardWrite.jsp").forward(req, resp);
		}
	}
	
	protected void BoardWriteAction (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		ServletContext application = this.getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		
		if(mr != null) {
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String citizencode = (String)session.getAttribute("CITIZENCODE");
			String boardtype = mr.getParameter("boardtype");
			
			BoardDTO dto = new BoardDTO();
			dto.setTitle(title);
			dto.setContent(content);
			dto.setCitizencode(citizencode);
			dto.setBoardtype(boardtype);
			
			String fileName = mr.getFilesystemName("ofile");
			
			if(fileName != null) {
				String nowTime = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
				int extIdx = fileName.lastIndexOf(".");
				String newFileName = nowTime + fileName.substring(extIdx, fileName.length());
				
				File oldFile = new File(saveDirectory+File.separator+fileName);
				File newFile = new File(saveDirectory+File.separator+newFileName);
				oldFile.renameTo(newFile);
				
				dto.setOfile(fileName);
				dto.setSfile(newFileName);
			}
			
			BoardDAO dao = new BoardDAO();
			int result = dao.insertWrite(dto);
			dao.close();
			
			if(result==1) {
				if(boardtype.equals("free")) {
					JSFunction.alertLocation(resp, "글 작성에 성공했습니다.", "./free.board?boardtype="+boardtype);
				}
				else if(boardtype.equals("notice")) {
					JSFunction.alertLocation(resp, "글 작성에 성공했습니다.", "./notice.board?boardtype="+boardtype);
				}
			}
			else {
				JSFunction.alertBack(resp, "글 작성에 실패했습니다.");
			}
		}
		else {
			JSFunction.alertBack(resp, "글 작성중 오류가 발생했습니다.");
		}
	}
	
	protected void BoardView (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String idx = req.getParameter("idx");
		String boardtype = req.getParameter("boardtype");
		
		BoardDAO dao = new BoardDAO();
		dao.updateVisitCount(idx);
		
		BoardDTO dto = dao.selectView(idx);
		dao.close();
		dto.getCitizencode();
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		
		req.setAttribute("dto", dto);
		
		if(boardtype.equals("free")) {
			req.getRequestDispatcher("./MOONBOARD/FreeBoardView.jsp").forward(req, resp);
		}
		else if(boardtype.equals("notice")) {
			req.getRequestDispatcher("./MOONBOARD/NoticeBoardView.jsp").forward(req, resp);
		}
	}
	
	protected void BoardFix (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String idx = req.getParameter("idx");
		String boardtype = req.getParameter("boardtype");
		
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.selectView(idx);
		
		req.setAttribute("dto", dto);
		
		if(boardtype.equals("free")) {
			req.getRequestDispatcher("./MOONBOARD/FreeBoardFix.jsp").forward(req, resp);
		}
		else if(boardtype.equals("notice")) {
			req.getRequestDispatcher("./MOONBOARD/FreeBoardFix.jsp").forward(req, resp);
		}
	}
	
	protected void BoardFixAction (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		ServletContext application = this.getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		
		if(mr != null) {
			int idx = Integer.parseInt( mr.getParameter("idx"));
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			String boardtype = mr.getParameter("boardtype");
			
			String prevOfile = mr.getParameter("prevOfile");
			String prevSfile = mr.getParameter("prevSfile");
			
			BoardDTO dto = new BoardDTO();
			dto.setIdx(idx);
			dto.setTitle(title);
			dto.setContent(content);
			dto.setBoardtype(boardtype);
			
			String fileName = mr.getFilesystemName("ofile");
			
			if(fileName != null) {
				String nowTime = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
				int extIdx = fileName.lastIndexOf(".");
				String newFileName = nowTime + fileName.substring(extIdx, fileName.length());
				
				File oldFile = new File(saveDirectory+File.separator+fileName);
				File newFile = new File(saveDirectory+File.separator+newFileName);
				oldFile.renameTo(newFile);
				
				dto.setOfile(fileName);
				dto.setSfile(newFileName);
				
				FileUtil.deleteFile(req, "/Uploads", prevSfile);
			}
			else {
				dto.setOfile(prevOfile);
				dto.setSfile(prevSfile);
			}
			
			BoardDAO dao = new BoardDAO();
			int result = dao.updatePost(dto);
			dao.close();
			
			if(result==1) {
				if(boardtype.equals("free")) {
					JSFunction.alertLocation(resp, "글 수정에 성공했습니다.", "./free.board?boardtype="+boardtype);
				}
				else if(boardtype.equals("notice")) {
					JSFunction.alertLocation(resp, "글 수정에 성공했습니다.", "./notice.board?boardtype="+boardtype);
				}
			}
			else {
				JSFunction.alertBack(resp, "글 수정에 실패했습니다.");
			}
		}
		else {
			JSFunction.alertBack(resp, "글 수정중 오류가 발생했습니다.");
		}
	}
	
	protected void BoardRemove (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String idx = req.getParameter("idx");
		String boardtype = req.getParameter("boardtype");
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.selectView(idx);
		int result = dao.deletePost(idx);
		dao.close();
		
		if(result==1) {
			String saveFileName = dto.getSfile();
			FileUtil.deleteFile(req, "/Uploads", saveFileName);
			if(boardtype.equals("free")) {
				JSFunction.alertLocation(resp, "삭제되었습니다.", "./free.board?boardtype="+boardtype);
			}
			else if(boardtype.equals("notice")) {
				JSFunction.alertLocation(resp, "삭제되었습니다.", "./notice.board?boardtype="+boardtype);
			}
		}
		else {
			JSFunction.alertBack(resp, "글 삭제중 오류가 발생하였습니다.");
		}
	}
	
	protected void BoardDownload (HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		String ofile = req.getParameter("ofile");
		String sfile = req.getParameter("sfile");
		String idx = req.getParameter("idx");
		FileUtil.downloadFile(req, resp, "/Uploads", sfile, ofile);
		
		BoardDAO dao = new BoardDAO();
		dao.downCountPlus(idx);
		dao.close();
	}
}
