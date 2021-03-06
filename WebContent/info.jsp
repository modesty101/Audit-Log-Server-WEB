<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

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
	border-width: 0px;
	border-top: 1px solid #bcbcbc;
	border-bottom: 1px solid #bcbcbc overflow: hidden;
	word-break: normal;
}

.tg th {
	font-family: 맑은 고딕;
	font-size: 14px;
	font-weight: normal;
	padding: 5px 10px;
	border-style: solid;
	border-width: 1px solid #bcbcbc;
	overflow: hidden;
	word-break: normal;
}

.tg .tg-wu73 {
	font-size: 18px;
	font-family: 맑은 고딕;
	background-color: #9C9172;
	color: #FFFFFF;
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
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Info Detail</title>
</head>
<body>
	<%
		// 인코딩 옵션 UTF-8로 설정
		request.setCharacterEncoding("utf-8");
		// 파라미터 값을 int형으로 변환
		int no = Integer.parseInt(request.getParameter("no"));

		Class.forName("org.postgresql.Driver");
		String url = "jdbc:postgresql://192.168.214.138:5432/niko";
		String user = "postgres";
		String pwd = "1234";
		String info = null;

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
	%>
	<%
		try {
			conn = DriverManager.getConnection(url, user, pwd);
			stmt = conn.createStatement();
			// 파라미터에 대한 정보만 출력하는 SQL문
			String sql = "select info from log where no=" + no;
			rs = stmt.executeQuery(sql);
	%>
	<table class="tg" width="100%" height="100%">
		<tr>
			<th class="tg-wu73">INFO</th>
		</tr>
		<%
			if (rs.next()) {
					info = rs.getString(1);
				}
		%>
		<tr>
			<td class="tg-7un6"><c:out value="<%=info%>"></c:out></td>
		</tr>
		<%
			
		%>
	</table>
	<%
		rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			out.println("err: " + e.toString());
			out.println(no);
		}
	%>
</body>
</html>