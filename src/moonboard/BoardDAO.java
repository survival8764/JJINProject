package moonboard;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletResponse;

import common.ConnectionPool;

public class BoardDAO extends ConnectionPool{
	
	public BoardDAO() {
		super();
	}
	
	public int selectCount(Map<String, Object> map) {
		
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM board "
				+ " WHERE boardtype=? ";
		if(map.get("searchWord") != null) {
			query += " AND "+ map.get("searchField") +" "
					+ " LIKE '%"+ map.get("searchWord") +"%'";
		}
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, (String)map.get("boardtype"));
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 카운트중 예외발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	public List<BoardDTO> selectListPage(Map<String, Object> map) {
		
		List<BoardDTO> list = new Vector<BoardDTO>();
		
		String query = "SELECT * FROM board "
				+ " WHERE boardtype=? ";
		if(map.get("searchWord") != null) {
			query +=" AND "+ map.get("searchField") +" "
					+" LIKE '%"+ map.get("searchWord") +"%' ";
		}
		query += " ORDER BY idx DESC LIMIT ?, ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, (String)map.get("boardtype"));
			psmt.setInt(2, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(3, Integer.parseInt(map.get("end").toString()));
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				
				BoardDTO dto = new BoardDTO();
				dto.setIdx(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setOfile(rs.getString(4));
				dto.setSfile(rs.getString(5));
				dto.setDowncount(rs.getInt(6));
				dto.setVisitcount(rs.getInt(7));
				dto.setPostdate(rs.getDate(8));
				dto.setBoardtype(rs.getString(9));
				dto.setCitizencode(rs.getString(10));
				
				list.add(dto);
			}
		}
		catch (Exception e) {
			System.out.println("게시물 조회중 예외발생");
			e.printStackTrace();
		}
		return list;
	}
	
	public int insertWrite(BoardDTO dto) {
		
		int result = 0;
		try {
			String query = "INSERT INTO board ( "
					+" title,content,ofile,sfile,boardtype,citizencode) "
					+" VALUES ( "
					+" ?,?,?,?,?,?)";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			psmt.setString(5, dto.getBoardtype());
			psmt.setString(6, dto.getCitizencode());
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 입력중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public BoardDTO selectView(String idx) {
		
		BoardDTO dto = new BoardDTO();
		String query = "SELECT * FROM board WHERE idx=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setIdx(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString(3));
				dto.setOfile(rs.getString(4));
				dto.setSfile(rs.getString(5));
				dto.setDowncount(rs.getInt(6));
				dto.setVisitcount(rs.getInt(7));
				dto.setPostdate(rs.getDate(8));
				dto.setBoardtype(rs.getString(9));
				dto.setCitizencode(rs.getString(10));
			}
		}
		catch (Exception e) {
			System.out.println("게시물 상세보기중 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	public void updateVisitCount(String idx) {
		
		String query = "UPDATE board SET "
				+ " visitcount=visitcount+1 "
				+ " WHERE idx=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}
		catch (Exception e) {
			System.out.println("게시물 조회수 증가중 예외발생");
			e.printStackTrace();
		}
	}
	
	public boolean confirmPassword(String pass, String boardidx) {
		
		boolean isCorr = true;
		try {
			// 일련번호와 패스워드가 일치하는 게시물이 있는지 확인
			String sql = "SELECT COUNT(*) FROM freeboard WHERE pass=? AND boardidx=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, boardidx);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) {
				// 패스워드가 일치하는 게시물이 없으므로 false.
				isCorr = false;
			}
		}
		catch (Exception e) {
			// 예외가 발생하여 확인이 불가능하므로 false.
			isCorr = false;
			e.printStackTrace();
		}
		return isCorr;
	}
	
	//수정처리
	public int updatePost(BoardDTO dto) {
		
		int result = 0;
		try {
			String query = "UPDATE board SET "
					+ " title=?, content=?, ofile=?, sfile=? "
					+ " WHERE idx=? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			psmt.setInt(5, dto.getIdx());
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 수정중 예외발생");
			e.printStackTrace();
		}
		return result;
	}

	// 삭제처리
	public int deletePost(String idx) {
		
		int result = 0;
		try {
			String query = "DELETE FROM board WHERE idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 삭제중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public void downCountPlus(String idx) {
		String sql = "UPDATE board SET "
				+ " downcount=downcount+1 "
				+ " WHERE idx=? ";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			psmt.executeUpdate();
		}
		catch (Exception e) {}
	}
}
