<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.vo.BoardVO,java.util.ArrayList"%>
<jsp:useBean id="datas" class="java.util.ArrayList" scope="request" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>검색 결과</title>
</head>
<body>

<form action="controller.jsp" method="post">
	<input type="hidden" name="action" value="main">
	<table border="2">
		<tr>
			<th>번 호</th>
			<th>제 목</th>
			<th>내 용</th>
			<th>작성자</th>
		</tr>
		<%
		for (BoardVO v : (ArrayList<BoardVO>) datas) {
		%>
		<tr>
			<th><a href="controller.jsp?action=board&bid=<%=v.getBid()%>"><%=v.getBid()%></a></th>
			<td><%=v.getTitle()%></td>
			<td><%=v.getContent()%></td>
			<td><%=v.getWriter()%></td>
		</tr>
		<%
		}
		%>
	</table>
</form>
<hr>
<a href="controller.jsp?action=main">메인으로 돌아가기</a>
</body>
</html>