<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>

<form action="controller.jsp?" method="post">
<input type="hidden" name="action" value="reg">
	<table border="1">
		<tr>
			<td>아이디</td>
			<td><input type="text" name="mid" required></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="mpw" required></td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="mname" required></td>
		</tr>
		<tr>
			<td>계정권한</td>
			<td>
				<select name="role">
					<option selected>MEMBER</option>
					<option>ADMIN</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="회원가입">
			</td>
		</tr>
	</table>
</form>
<hr>
<a href="login.jsp">로그인하기</a><br>
<a href="controller.jsp?action=main">메인으로 돌아가기</a>
</body>
</html>