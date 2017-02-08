<%@ page contentType="text/html; charset=UTF-8"%>
<%
        if(session.getAttribute("login") != null){
               response.sendRedirect("audit.jsp");
        }
        else if(request.getMethod().equals("POST")){
               final String ID = "admin";
               final String PASSWD = "1234";
              
               String id = request.getParameter("id");
               String passwd = request.getParameter("passwd");
               String url = "";
              
               if(id != null && id.equals(ID) && passwd != null && passwd.equals(PASSWD)){
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
<title>로그 서버 접속기</title>
<meta charset="UTF-8">
</head>
<body>
	<form id="loginForm" method="POST">

		<label for="id">ID</label> <input type="text" name="id" id="id" /> <br>
		<label for="id">PW</label> <input type="password" name="passwd"
			id="passwd" /> <input type="submit" value="로그인" />

	</form>
</body>
</html>
<%
}
%>