<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="data" class="model.vo.BoardVO" scope="request" />
<jsp:useBean id="member" class="model.vo.MemberVO" scope="session" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지</title>
</head>
<body>
<script type="text/javascript">
	function del(){
		ans=confirm('정말 삭제할까요?');
		if(ans==true){
			document.bForm.action.value="delete";
			document.bForm.submit();
		}
		else{
			return;
		}
	}
</script>

<form name="bForm" action="controller.jsp" method="post">
	<input type="hidden" name="action" value="update">
	<input type="hidden" name="bid" value="<%=data.getBid()%>">
	<table border="1">
		<tr>
			<td>제목</td>
			<td><input type="text" name="title" value="<%=data.getTitle()%>" required></td>
		</tr>
		<tr>
			<td>내용</td>
			<td><input type="text" name="content" value="<%=data.getContent()%>" required></td>
		</tr>
		<tr>
			<td>작성자</td>
			<td><input type="text" name="writer" value="<%=data.getWriter()%>" required readonly></td>		</tr>
	<%
		if(member.getMid() != null){
			//로그인을 하지않고 board(상세보기)로 넘어오게 되면
			// member의 role이나 mid가 null이기때문에 ▼의 조건을 통과하지 못 한다.
			if(member.getRole().equals("ADMIN") || member.getMid().equals(data.getWriter())){
	%>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="변경하기">&nbsp;
				<input type="button" value="삭제하기" onClick="del()">
			</td>
		</tr>
	<%
			}
		}
	%>
	</table>
</form>
<hr>
<a href="controller.jsp?action=main">메인으로 돌아가기</a>

</body>
</html>