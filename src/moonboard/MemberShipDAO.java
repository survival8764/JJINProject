package moonboard;

import java.io.PrintWriter;
import java.lang.reflect.Member;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletResponse;

import common.ConnectionPool;

public class MemberShipDAO extends ConnectionPool {
	
	public MemberShipDAO() {
		super();
	}
	
//	public int selectCount(Map<String, Object> map) {
//		
//		int totalCount = 0;
//		String query = "SELECT COUNT(*) FROM mvcboard";
//		if(map.get("searchWord") != null) {
//			query += " WHERE "+ map.get("searchField") +" "
//					+ " LIKE '%"+ map.get("searchWord") +"%'";
//		}
//		try {
//			stmt = con.createStatement();
//			rs = stmt.executeQuery(query);
//			rs.next();
//			totalCount = rs.getInt(1);
//		}
//		catch (Exception e) {
//			System.out.println("게시물 카운트중 예외발생");
//			e.printStackTrace();
//		}
//		
//		return totalCount;
//	}
//	
//	public List<MoonBoardDTO> selectListPage(Map<String, Object> map) {
//		
//		List<MoonBoardDTO> bbs = new Vector<MoonBoardDTO>();
//		String query = " "
//				+"	SELECT * FROM mvcboard ";
//		if(map.get("searchWord") != null) {
//			query +=" WHERE "+ map.get("searchField") +" "
//					+" LIKE '%"+ map.get("searchWord") +"%' ";
//		}
//		
//		query += " ORDER BY idx DESC LIMIT ?, ?";
//		try {
//			psmt = con.prepareStatement(query);
//			psmt.setInt(1, Integer.parseInt(map.get("start").toString()));
//			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));
//			rs = psmt.executeQuery();
//			while(rs.next()) {
//				MoonBoardDTO dto = new MoonBoardDTO();
//				
//				dto.setIdx(rs.getString(1));
//				dto.setName(rs.getString(2));
//				dto.setTitle(rs.getString(3));
//				dto.setContent(rs.getString(4));
//				dto.setPostdate(rs.getDate(5));
//				dto.setOfile(rs.getString(6));
//				dto.setSfile(rs.getString(7));
//				dto.setDowncount(rs.getInt(8));
//				dto.setPass(rs.getString(9));
//				dto.setVisitcount(rs.getInt(10));
//				
//				bbs.add(dto);
//			}
//		}
//		catch (Exception e) {
//			System.out.println("게시물 조회중 예외발생");
//			e.printStackTrace();
//		}
//		return bbs;
//	}
	
	public int insertMember(MemberShipDTO dto) {
		
		int result = 0;
		try {
			String query = "INSERT INTO membership ( "
					+" citizencode,pass,name,birth,zipcode, "
					+" compaddr,compaddr2,email,mobile, "
					+" tel,code) "
					+" VALUES ( "
					+" ?,?,?,?,?,?,?,?,?,?,?)";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getCitizencode());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getBirth());
			psmt.setString(5, dto.getZipcode());
			psmt.setString(6, dto.getCompaddr());
			psmt.setString(7, dto.getCompaddr2());
			psmt.setString(8, dto.getEmail());
			psmt.setString(9, dto.getMobile());
			psmt.setString(10, dto.getTel());
			psmt.setString(11, dto.getCode());
			result = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("게시물 입력중 예외발생.");
			e.printStackTrace();
		}
		return result;
	}
	
//	public MemberShipDTO selectView(String idx) {
//		
//		MemberShipDTO dto = new MemberShipDTO();
//		String query = "SELECT * FROM membership WHERE idx=?";
//		try {
//			psmt = con.prepareStatement(query);
//			psmt.setString(1, idx);
//			rs = psmt.executeQuery();
//			if(rs.next()) {
//				dto.setIdx(rs.getString(1));
//				dto.setBuilcode(rs.getString(2));
//				dto.setCitizencode(rs.getString(3));
//				dto.setPass(rs.getString(4));
//				dto.setName(rs.getString(5));
//				dto.setBirth(rs.getString(6));
//				dto.setZipcode(rs.getString(7));
//				dto.setCompaddr(rs.getString(8));
//				dto.setCompaddr2(rs.getString(9));
//				dto.setEmail(rs.getString(10));
//				dto.setMobile(rs.getString(11));
//				dto.setTel(rs.getString(12));
//				dto.setPostdate(rs.getDate(13));
//			}
//		}
//		catch (Exception e) {
//			System.out.println("게시물 상세보기중 예외발생");
//			e.printStackTrace();
//		}
//		return dto;
//	}
	
	public void updateVisitCount(String idx) {
		
		String query = "UPDATE mvcboard SET "
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
	
	public boolean confirmLogin(String pass, String citizencode) {
		
		boolean result = true;
		try {
			// 일련번호와 패스워드가 일치하는 게시물이 있는지 확인
			String sql = "SELECT COUNT(*) FROM membership WHERE pass=? AND citizencode=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, pass);
			psmt.setString(2, citizencode);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) {
				result = false;
			}
		}
		catch (Exception e) {
			result = false;
			e.printStackTrace();
		}
		return result;
	}
	
	public MemberShipDTO confirmID(String code, String name) {
		
		MemberShipDTO dto = new MemberShipDTO();

		try {
			// 일련번호와 패스워드가 일치하는 게시물이 있는지 확인
			String sql = "SELECT citizencode FROM membership WHERE code=? AND name=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, code);
			psmt.setString(2, name);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setCitizencode(rs.getString(1));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	public MemberShipDTO confirmPASS(String code, String citizencode) {
	
		MemberShipDTO dto = new MemberShipDTO();
		try {
			// 일련번호와 패스워드가 일치하는 게시물이 있는지 확인
			String sql = "SELECT pass FROM membership WHERE code=? AND citizencode=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, code);
			psmt.setString(2, citizencode);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setPass(rs.getString(1));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public MemberShipDTO humantypefind(String citizencode, String pass) {
		
		MemberShipDTO dto = new MemberShipDTO();

		try {
			String sql = "SELECT humantype FROM membership WHERE citizencode=? AND pass=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, citizencode);
			psmt.setString(2, pass);
			rs = psmt.executeQuery();
			if(rs.next()) {
				dto.setHumantype(rs.getString(1));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public boolean confirmOverlap(String citizencode) {
		
		boolean isCorr = true;
		try {
			// 일련번호와 패스워드가 일치하는 게시물이 있는지 확인
			String sql = "SELECT COUNT(*) FROM membership WHERE citizencode=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, citizencode);
			rs = psmt.executeQuery();
			rs.next();
			if(rs.getInt(1)==0) {
				isCorr = false;
			}
		}                               
		catch (Exception e) {
			isCorr = false;
			e.printStackTrace();
		}
		return isCorr;
	}
	
	// 수정처리
//	public int updatePost(MoonBoardDTO dto) {
//		int result = 0;
//		try {
//			// 비회원제 게시판이므로 패스워드까지 where절에 추가함.
//			String query = "UPDATE mvcboard SET "
//					+ " title=?, name=?, content=?, ofile=?, sfile=? "
//					+ " WHERE idx=? and pass=?";
//			psmt = con.prepareStatement(query);
//			psmt.setString(1, dto.getTitle());
//			psmt.setString(2, dto.getName());
//			psmt.setString(3, dto.getContent());
//			psmt.setString(4, dto.getOfile());
//			psmt.setString(5, dto.getSfile());
//			psmt.setString(6, dto.getIdx());
//			psmt.setString(7, dto.getPass());
//			result = psmt.executeUpdate();
//		}
//		catch (Exception e) {
//			System.out.println("게시물 수정중 예외발생");
//			e.printStackTrace();
//		}
//		return result;
//	}

	// 삭제처리
	public int deletePost(String idx) {
		int result = 0;
		try {
			// 비밀번호 검증후 즉시 삭제하므로 비밀번호는 조건에서 제외한다.
			String query = "DELETE FROM mvcboard WHERE idx=?";
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
		String sql = "UPDATE mvcboard SET "
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
