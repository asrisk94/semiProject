package member.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import member.model.dao.MemberDao;
import member.model.vo.Member;
import product.model.vo.OrderDessertExt;
import product.model.vo.OrderTable;

public class MemberService {

	public static final String ADMIN_MEMBER_ROLE = "Y"; //관리자
	public static final String USER_MEMBER_ROLE = "N"; //일반 회원
	
	private MemberDao memberDao = new MemberDao();
	
	public int insertMember(Member member) {
		Connection conn = getConnection();
		int result = memberDao.insertMember(conn, member);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		return result;
	}
	
	public Member selectOne(String memberId) {
		//1.Connection객체 생성
		Connection conn = getConnection();
		//2.dao요청
		Member member =  memberDao.selectOne(conn, memberId);
		//3.트랜잭션관리(DML만)
		//4.자원반납
		close(conn);
		return member;
	}
	
	public int updateMember(Member member) {
		Connection conn = getConnection();
		int result = memberDao.updateMember(conn, member);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		return result;
	}
	
	
	public int deleteMember(String memberId) {
		Connection conn = getConnection();
		int result = memberDao.deleteMember(conn, memberId);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		return result;
	}

	
	
	public List<OrderTable> selectMemberOrderList(int cpage, int numPerPage, String memberId) {

		Connection conn = getConnection();
		
		List<OrderTable> list = memberDao.selectMemberOrderList(conn, cpage, numPerPage, memberId);
		
		close(conn);
		
		return list;
	}

	public List<OrderDessertExt> selectMemberOrderDessertExt(int cpage, int numPerPage, String memberId) {

		Connection conn = getConnection();
		
		List<OrderDessertExt> list = memberDao.selectMemberOrderDessertExt(conn, cpage, numPerPage, memberId);
		
		close(conn);
		
		return list;
	}

	public int selectMemberOrderCount(String memberId) {
		
		Connection conn = getConnection();
		
		int cnt = memberDao.selectMemberOrderCount(conn, memberId);
				
		close(conn);
		
		return cnt;
	}
	
	
	
	public int updatePassword(Member member) {
		Connection conn = getConnection();
		int result = memberDao.updatePassword(conn, member);
		if(result>0)
			commit(conn);
		else 
			rollback(conn);
		close(conn);
		return result;
	}
	
}
