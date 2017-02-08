<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
	String command = request.getParameter("command");
	if (session.getAttribute("login") == null) {
		response.sendRedirect("login.jsp");
	} else if (command != null && command.equals("logout")) {
		session.invalidate();
		response.sendRedirect("login.jsp");
	} else {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style type="text/css">
.tg {
	border-collapse: collapse;
	border-spacing: 0;
}

.tg td {
	font-family: 맑은 고딕;
	font-size: 14px;
	padding: 10px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
}

.tg th {
	font-family: 맑은 고딕;
	font-size: 14px;
	font-weight: normal;
	padding: 10px 5px;
	border-style: solid;
	border-width: 1px;
	overflow: hidden;
	word-break: normal;
}

.tg .tg-wu73 {
	font-size: 18px;
	font-family: 맑은 고딕;
	background-color: #6200c9;
	color: #fcff2f;
	text-align: center;
	vertical-align: top
}

.tg .tg-7un6 {
	font-size: 15px;
	font-family: 맑은 고딕;
	background-color: #ffffff;
	color: #000000;
	text-align: center;
	vertical-align: top
}

h3 {
	font-family: 맑은 고딕;
}

.logout {
	float: center;
}

.check {
	float: right;
	padding: 2px
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Audit Log Page</title>
</head>
<body>
	<div class="logout">
		<a href="audit.jsp?command=logout">로그아웃</a>
	</div>

	<h3><%=session.getAttribute("login")%>님의 방문을 환영합니다.
	</h3>
	<%
		Class.forName("org.postgresql.Driver");
			String url = "jdbc:postgresql://192.168.214.138:5432/niko";
			String id = "postgres";
			String pass = "1234";
			int total = 0;

			try {
				Connection conn = DriverManager.getConnection(url, id, pass); //DB연결
				Statement stmt = conn.createStatement(); //Statement타입의 객체생성

				String sqlCount = "SELECT COUNT(*) FROM Log"; // DB내의 자료개수를 찾는 SQL문
				ResultSet rs = stmt.executeQuery(sqlCount); // DB실행

				if (rs.next()) { // rs.next()의 반환값은 true or false입니다. 찾는결과가 있으면 true
					total = rs.getInt(1); // SELECT문의 첫번째 필드 여기선 COUNT(*)
				}

				out.print("총 로그 : " + total + "개"); // 게시물수 출력

				String sqlList = "SELECT no, date, info from Log order by no ASC";
				rs = stmt.executeQuery(sqlList); // DB실행
	%>
	<div class="check">
		<form style="padding-top: 5px">
			<input type="button" value="조회" onclick="location.reload(true)">
		</form>
	</div>

	<%
		if (total == 0) { // total 즉, 자료가 없다면
	%>
	<%
		} else { // total이 0이 아닌 즉 자료가 1개이상 있다면

					while (rs.next()) { // while이라는 반복문으로 자료를 찾습니다. rs.next()는 다음라인으
						int idx = rs.getInt(1); // 1은 첫번째 즉 num값을 idx라는 변수에 대입
					}
				}
				rs.close(); //rs객체 반환
				stmt.close(); // stmt객체 반환
				conn.close(); // conn객체 반환
			} catch (SQLException e) {
				out.println(e.toString()); //에러 날경우 에러출력
			}
	%>

	<%
		Class.forName("org.postgresql.Driver");
			String urI = "jdbc:postgresql://192.168.214.138:5432/niko";
			String user = "postgres";
			String pwd = "1234";

			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;

			try {
				conn = DriverManager.getConnection(urI, user, pwd);
				stmt = conn.createStatement();

				String sql = "select no, date, info from Log";
				rs = stmt.executeQuery(sql);
	%>
	<table class="tg" width="100%" height="auto">
		<tr>
			<th class="tg-wu73">NO</th>
			<th class="tg-wu73">DATE</th>
			<th class="tg-wu73">INFO</th>
		</tr>
		<%
			while (rs.next()) {
						int no = rs.getInt(1);
						String date = rs.getString(2);
						String info = rs.getString(3);
		%>
		<tr>
			<td class="tg-7un6"><%=no%></td>
			<td class="tg-7un6"><%=date%></td>
			<td class="tg-7un6"><a href="info.jsp?no=<%=no%>"><%=info%></a></td>
		</tr>
		<%
			}
		%>

		<%
			rs.close();
					stmt.close();
					conn.close();
				} catch (SQLException e) {
					out.println("err: " + e.toString());
				}
		%>
	</table>
</body>
</html>
<%
	}
%>