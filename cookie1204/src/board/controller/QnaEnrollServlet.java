package board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.model.service.QnaService;
import board.model.vo.Qna;
import member.model.vo.Member;

/**
 * Servlet implementation class QnaEnrollServlet
 */
@WebServlet("/board/qnaEnroll")
public class QnaEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private QnaService qnaService = new QnaService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/board/qnaEnroll.jsp")
		   .forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1.사용자 입력값으로 qna 객체 생성
		String qnaTitle = request.getParameter("qnaTitle");
		String qnaContent = request.getParameter("qnaContent");
		System.out.println("enroll 들어오자마자 = " + qnaContent);

		qnaContent = qnaContent.replaceAll("<br />", "\n");
		System.out.println("enroll 리플레이스올 = " + qnaContent);
		
		HttpSession session = request.getSession();
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		String qnaWriter = memberLoggedIn.getMemberId();
		
		Qna qna =
			 new Qna(0, qnaTitle, qnaContent, qnaWriter, 0, 0, null, null);
		
		//2.업무로직 : qna 객체 db저장 요청
		//DML처리 결과는 int 타입
		int result = qnaService.insertQna(qna);
		String msg = result > 0 ? "문의글 등록 성공!" : "문의글 등록 실패!";
		
		//qna.getQnaNo()를 통해서 새로 등록된 게시글 번호 가져오기
		String location = result > 0 ?
							request.getContextPath() + "/board/qnaView?qnaNum=" + qna.getQnaNum() :
								request.getContextPath() + "/board/qna";

		//3.사용자 피드백(msg) 및 redirect처리 (/cookie__1204/board/qnaList)
		//DML이후 반드시 요청url을 변경할 것
		request.getSession().setAttribute("msg", msg);
		response.sendRedirect(location);
		
		
	}
}