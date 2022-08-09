<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" errorPage="error/error.jsp" import="java.util.ArrayList,model.vo.*" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mDAO" class="model.dao.MemberDAO" />
<jsp:useBean id="bDAO" class="model.dao.BoardDAO" />
<jsp:useBean id="bVO" class="model.vo.BoardVO" />
<jsp:setProperty property="*" name="bVO" />
<jsp:useBean id="mVO" class="model.vo.MemberVO" />
<jsp:setProperty property="*" name="mVO" />
<%
	// 어떤 요청을 받았는지 파악
	//  -> 해당 요청을 수행

	String action=request.getParameter("action");
	System.out.println("로그: "+action);
	
	if(action.equals("login")){
		MemberVO member=mDAO.selectOne(mVO);
		if(member!=null){
			session.setAttribute("member", member);
			response.sendRedirect("controller.jsp?action=main");
		}
		else{
			response.sendRedirect("login.jsp");
		}
	}
	else if(action.equals("reg")){
		if(mDAO.insert(mVO)){
			response.sendRedirect("login.jsp");
		}
		else{
			throw new Exception("reg 오류");
		}
	}
	else if(action.equals("mypage")){
		MemberVO member=(MemberVO)session.getAttribute("member");
		// 이후에는 selectOne을 통해서 data를 받게될예정
		if(member!=null){
			request.setAttribute("data", member);
			pageContext.forward("mypage.jsp");
		}
		else{
			throw new Exception("mypage 오류");
		}
	}
	else if(action.equals("mupdate")){
		if(mDAO.update(mVO)){
			session.invalidate(); // 세션 정보 전체 제거하기
			 /// session.removeAttribute("member");
			response.sendRedirect("login.jsp");
		}
		else{
			throw new Exception("mupdate 오류");
		}
	}
	else if(action.equals("mdelete")){
		MemberVO member=(MemberVO)session.getAttribute("member");
		if(member!=null && mDAO.delete(member)){
			session.invalidate();
			response.sendRedirect("login.jsp");
		}
		else{
			throw new Exception("mdelete 오류");
		}
	}
	else if(action.equals("main")){
		ArrayList<BoardVO> datas=bDAO.selectAll(bVO);
		request.setAttribute("datas", datas);
		pageContext.forward("main.jsp"); // forward 액션
	}
	else if(action.equals("board")){
		BoardVO data=bDAO.selectOne(bVO);
		if(data==null){
			response.sendRedirect("controller.jsp?action=main");
		}
		request.setAttribute("data", data);
		pageContext.forward("board.jsp");
	}
	else if(action.equals("insert")){
		if(bDAO.insert(bVO)){
			response.sendRedirect("controller.jsp?action=main");
		}
		else{
			throw new Exception("insert 오류");
		}
	}
	else if(action.equals("update")){
		if(bDAO.update(bVO)){
			response.sendRedirect("controller.jsp?action=main");
		}
		else{
			throw new Exception("update 오류");
		}
	}
	else if(action.equals("delete")){
		if(bDAO.delete(bVO)){
			response.sendRedirect("controller.jsp?action=main");
		}
		else{
			throw new Exception("delete 오류");
		}
	}
	else{
		out.println("<script>alert('action 파라미터 값이 올바르지 않습니다...');location.href='controller.jsp?action=main'</script>");	
	}
%>