<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// 세션의 애트리뷰트가 널이 아니라면, audit.jsp로 리다이렉트
	if (session.getAttribute("login") != null) {

		response.sendRedirect("audit.jsp");
		// 전송방식이 POST라면, 
	} else if (request.getMethod().equals("POST")) {
		// ID와 PW는 하드코딩
		final String ID = "admin";
		final String PASSWD = "1234";

		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String url = "";
		// 검증: id가 널인지? ID가 전달받은 파라미터(id)의 값과 같은지?
		// 패스워드는 id 검증 원리와 동일
		if (id != null && id.equals(ID) && passwd != null && passwd.equals(PASSWD)) {
			session.setAttribute("login", id);
			// 동일하면 audit.jsp로 라다이렉트
			url = "audit.jsp";
		} else {
			// 틀리면 다시 login.jsp로 리다이렉트
			url = "login.jsp";
		}
		response.sendRedirect(url);
	} else {
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<link href="css/style.css" rel='stylesheet' type='text/css' />
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript">
	
	 addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } 

</script>
<!-- 웹 폰트 설정 -->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:600italic,400,300,600,700'
	rel='stylesheet' type='text/css'>
<title>로그 서버 접속기</title>
<meta charset="UTF-8">
</head>
<body>
	<div class="main">
		<div class="login-form">
			<h1>ADMIN LOGIN</h1>
			<div class="head">
				<!-- 로그인 프로필 -->
				<img src="images/user.png" alt="" />
			</div>
			<!-- 로그인 폼 -->
			<form id="loginForm" method="post">
				<input type="text" name="id" id="id" class="text" value="USERNAME"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'USERNAME';}">
				<input type="password" name="passwd" id="passwd" value="Password"
					onfocus="this.value = '';"
					onblur="if (this.value == '') {this.value = 'Password';}">
				<div class="submit">
					<input type="submit" onclick="myFunction()" value="LOGIN">
				</div>
				<p>
					<a href="#">Forgot Password ?</a>
				</p>
			</form>
		</div>

		<div class="copy-right">
			<p>
				Template by <a href="http://w3layouts.com">w3layouts</a>
			</p>
		</div>
	</div>

</body>
</html>
<%
	}
%>