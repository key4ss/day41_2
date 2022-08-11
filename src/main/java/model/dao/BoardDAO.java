package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.util.JDBCUtil;
import model.vo.BoardVO;

public class BoardDAO {
	Connection conn;
	PreparedStatement pstmt;
	final String sql_selectOne="SELECT * FROM BOARD WHERE BID=?";
	//final String sql_selectAll="SELECT * FROM BOARD ORDER BY BID DESC";
	//final String sql_selectAll="SELECT * FROM BOARD JOIN MEMBER ON BOARD.WRITER = MEMBER.MID(+)";
	//final String sql_selectAllT="SELECT * FROM BOARD WHERE TITLE LIKE '%'||?||'%' ORDER BY BID DESC";
	final String sql_selectAllT = "SELECT * FROM BOARD JOIN MEMBER ON BOARD.WRITER = MEMBER.MID(+) WHERE TITLE LIKE '%'||?||'%' ORDER BY BID DESC";
//	final String sql_selectAllW="SELECT * FROM BOARD WHERE WRITER LIKE '%'||?||'%' ORDER BY BID DESC";
	final String sql_selectAllW="SELECT * FROM BOARD JOIN MEMBER ON BOARD.WRITER = MEMBER.MID(+) WHERE WRITER LIKE '%'||?||'%' ORDER BY BID DESC";
	final String sql_selectAllMn="SELECT * FROM BOARD JOIN MEMBER ON BOARD.WRITER = MEMBER.MID(+) WHERE MNAME LIKE '%'||?||'%' ORDER BY BID DESC";
	final String sql_insert="INSERT INTO BOARD VALUES((SELECT NVL(MAX(BID),0)+1 FROM BOARD),?,?,?,(SELECT SYSDATE FROM DUAL))";
	final String sql_update="UPDATE BOARD SET TITLE=?,CONTENT=? WHERE BID=?";
	final String sql_updateTwo="UPDATE BOARD SET WRITER=? WHERE BID=?";
	final String sql_delete="DELETE FROM BOARD WHERE BID=?";
	
	
	public BoardVO selectOne(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_selectOne);
			pstmt.setInt(1, vo.getBid());
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				BoardVO data=new BoardVO();
				data.setBid(rs.getInt("BID"));
				data.setContent(rs.getString("CONTENT"));
				data.setTitle(rs.getString("TITLE"));
				data.setWriter(rs.getString("WRITER"));
				data.setBdate(rs.getString("BDATE"));
				return data;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}		
		return null;
	}
	public ArrayList<BoardVO> selectAll(BoardVO vo){
		ArrayList<BoardVO> datas=new ArrayList<BoardVO>();
		conn=JDBCUtil.connect();
		try {
			if(vo.getSearchType()==null) { //검색조건x 경우
				vo.setSearchType("TITLE");
			}
			if(vo.getSearchContent()==null) {//검색내용x 경우
				vo.setSearchContent("");
			}
			String sql_selectAll=sql_selectAllT;
			if(vo.getSearchType().equals("WRITER")) {
				sql_selectAll=sql_selectAllW;
			}
			if(vo.getSearchType().equals("MNAME")) {
				sql_selectAll=sql_selectAllMn;
			}
			pstmt=conn.prepareStatement(sql_selectAll);
			pstmt.setString(1, vo.getSearchContent());
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				BoardVO data=new BoardVO();
				data.setBid(rs.getInt("BID"));
				data.setContent(rs.getString("CONTENT"));
				data.setTitle(rs.getString("TITLE"));
				data.setWriter(rs.getString("MNAME"));
				data.setBdate(rs.getString("BDATE"));
				datas.add(data);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}		
		return datas;
	}
	public boolean insert(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_insert);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setString(3, vo.getWriter());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean update(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_update);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean updateTwo(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_updateTwo);
			pstmt.setString(1, vo.getWriter());
			pstmt.setInt(2,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
	public boolean delete(BoardVO vo) {
		conn=JDBCUtil.connect();
		try {
			pstmt=conn.prepareStatement(sql_delete);
			pstmt.setInt(1,vo.getBid());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			JDBCUtil.disconnect(pstmt, conn);
		}
		return true;
	}
}
