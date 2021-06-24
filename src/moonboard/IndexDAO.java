package moonboard;

import common.ConnectionPool;

public class IndexDAO extends ConnectionPool{
	
	public IndexDAO() {
		super();
	}

	public boolean confirmIndex(String code) {
		
		boolean result = true;
		try {
			String sql = "SELECT * FROM building "
					+ " WHERE code=?";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, code);
			rs = psmt.executeQuery();
			if(rs.next()==false) {
				result = false;
			}
		} 
		catch (Exception e) {
			result = false;
			System.out.println("건물코드입력시 예외발생.");
			e.printStackTrace();
		}
		return result;
	}
}
