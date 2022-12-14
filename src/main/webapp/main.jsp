<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.vo.BoardVO,java.util.ArrayList" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="datas" class="java.util.ArrayList" scope="request" />
<jsp:useBean id="member" class="model.vo.MemberVO" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인페이지</title>
</head>
<body>
<script type="text/javascript">
	function check(){
		ans=prompt('비밀번호를 입력하세요.');
		if(ans=='<%=member.getMpw()%>'){ 
			location.href="controller.jsp?action=mypage";
		}
	}
</script>
<%if(member.getMid()==null){
%>
<a href="login.jsp">로그인</a> | <a href="reg.jsp">회원가입</a>
<%
}else{
%>
<h1><a href="javascript:check()"><%=member.getMname()%></a>님, 반갑습니다! :D</h1>
<a href="controller.jsp?action=logout">로그아웃</a><br>
<%
}
%>
<hr>
<form action="controller.jsp" method="post">
	<input type="hidden" name="action" value="main">
	<table border="3">
		<tr>
			<td>
				<select name="searchType">
					<option selected value="TITLE">제목</option>
					<option value="WRITER">ID로검색</option>
					<option value="MNAME">이름으로검색</option>
				</select>
				&nbsp;
				<input type="text" name="searchContent">&nbsp;
				<input type="submit" value="검색">
			</td>
		</tr>
	</table>
</form>
<hr>
<table border="2">
	<tr>
		<th>번 호</th><th>제 목</th><th>작성자(이름)</th><th>작성일</th>
	</tr>
<%
	for(BoardVO v:(ArrayList<BoardVO>)datas){
%>
	<tr>
		<th><a href="controller.jsp?action=board&bid=<%=v.getBid()%>"><%=v.getBid()%></a></th>
		<td><%=v.getTitle()%></td>
		<td><%=v.getWriter()%></td>
		<td><%=v.getBdate()%></td>
	</tr>
<%
	}
%>
</table>
<hr>
<%if(member.getMid()==null){
%>
<h3>새로운 글을 작성하려면 로그인하여야 합니다! :D</h3>
<%
}else{
%>
<a href="form.jsp">새로운 글 작성하기</a>
<%
}
%>

</body>
</html>