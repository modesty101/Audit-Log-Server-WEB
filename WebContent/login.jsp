<%@ page contentType="text/html; charset=UTF-8"%>
<%
	if (session.getAttribute("login") != null) {
		response.sendRedirect("audit.jsp");
	} else if (request.getMethod().equals("POST")) {
		final String ID = "admin";
		final String PASSWD = "1234";

		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String url = "";

		if (id != null && id.equals(ID) && passwd != null && passwd.equals(PASSWD)) {
			session.setAttribute("login", id);
			url = "audit.jsp";
		} else {
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
<!--webfonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:600italic,400,300,600,700'
	rel='stylesheet' type='text/css'>
<!--//webfonts-->


<title>로그 서버 접속기</title>
<meta charset="UTF-8">
</head>
<body>

	<!-----start-main---->
	<div class="main">
		<div class="login-form">
			<h1>ADMIN LOGIN</h1>
			<div class="head">
				<img src="images/user.png" alt="" />
			</div>
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
		<!--//End-login-form-->
		<!-----start-copyright---->
		<div class="copy-right">
			<p>
				Template by <a href="http://w3layouts.com">w3layouts</a>
			</p>
		</div>
		<!-----//end-copyright---->
	</div>
	<!-----//end-main---->
</body>
</html>
<%
	}
%>