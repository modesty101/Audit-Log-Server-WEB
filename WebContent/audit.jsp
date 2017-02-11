<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
	// 커맨드 파라미터를 받아옴.(=로그아웃)
	String command = request.getParameter("command");
	// 전송과정 중, 로그인이 null되었는지 판단함.
	if (session.getAttribute("login") == null) {
		response.sendRedirect("login.jsp");
		// 커맨드가 널이아니거나, 커맨드가 "로그아웃"일 경우..
	} else if (command != null && command.equals("logout")) {
		// 세션 무효화.
		session.invalidate();
		// 로그인 페이지로 이동.
		response.sendRedirect("login.jsp");
	} else {
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
function popup(int no) {
	var pop_title = "Log info";
	var url = "http://localhost:6884/AuditLogPage/info.jsp?no=44";
	
	window.open(url,pop_title,"width=1000,height=1000,toolbar=no,status=no,location=no,scrollbars=auto,menubar=no,resizable=yes,left=50,right=50");
}
</script>
<style type="text/css">
h4 {
	FONT-SIZE: 22px;
	COLOR: white;
	PADDING-BOTTOM: 10px;
	TEXT-ALIGN: left;
	PADDING-TOP: 10px;
	PADDING-LEFT: 10px;
	BORDER-LEFT: #00b5ff 8px solid;
	PADDING-RIGHT: 10px;
	BACKGROUND-COLOR: #282828;
	border-radius: 3px;
}

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
	<!-- 로그아웃 -->
	<div class="logout">
		<a href="audit.jsp?command=logout">로그아웃</a>
	</div>
	<!-- 로그인 정보 출력 -->
	<h4><%=session.getAttribute("login")%>님의 방문을 환영합니다.
	</h4>
	<%
		/* PostgreSQL 연결 과정. */

			// PostgreSQL의 드라이버를 불러옴.
			Class.forName("org.postgresql.Driver");
			// 연결할 DB의 주소와 테이블 명
			String url = "jdbc:postgresql://192.168.214.140:5432/niko";
			// DB에 접속할 아이디
			String id = "postgres";
			// DB에 접속할 패스워드
			String pass = "1234";
			// 총 로그
			int total = 0;

			try {
				// PostgreSQL 연결
				Connection conn = DriverManager.getConnection(url, id, pass);
				// Statement 객체 생성 -> DB와 관련된 명령을 전달할 수 있음.
				Statement stmt = conn.createStatement();
				// Log 테이블 내의 총 자료의 개수를 구하는 SQL문
				String sqlCount = "SELECT COUNT(*) FROM Log";
				// 쿼리 실행
				ResultSet rs = stmt.executeQuery(sqlCount);

				// rs.next()의 반환값은 true or false, 찾는결과가 있으면 true
				if (rs.next()) {
					// SELECT문의 첫번째 필드 여기선 COUNT(*), 숫자(1)은 COUNT(*) 의미함.
					// EX) SELECT COUNT(*) ADD FROM Log; 만약 두번째 필드를 얻고 싶다면, rs.getInt(2)
					total = rs.getInt(1);
				}
				// 로그 개수 출력
				out.print("총 로그 : " + total + "개");
	%>

	<!-- 조회 기능 ==> (새로고침) -->
	<div class="check">
		<form style="padding-top: 5px">
			<input type="button" value="조회" onclick="location.reload(true)"
				style="width: 100px; height: 50px; color: #FFFFFF; font-size: 20; font-family: 굴림; background-color: #564C4D; border: 0">
		</form>
	</div>

	<%
		// 객체 종료
		rs.close();
		stmt.close();
		conn.close();
		} catch (SQLException e) {
			// 예외 처리
			out.println(e.toString());
		}
	%>

	<%
		// 위 구문과 동일함
		Class.forName("org.postgresql.Driver");
			String urI = "jdbc:postgresql://192.168.214.140:5432/niko";
			String user = "postgres";
			String pwd = "1234";

			Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;

			try {
				conn = DriverManager.getConnection(urI, user, pwd);
				stmt = conn.createStatement();
				// 테이블 내의 정보를 오름차순으로 정렬하여 출력함.
				String sql = "SELECT no, date, info from Log order by no ASC";
				rs = stmt.executeQuery(sql);
	%>
	<!-- 테이블 안에 가져온 정보를 출력함 -->
	<table class="tg" width="100%" height="auto">
		<tr>
			<th class="tg-wu73">NO</th>
			<th class="tg-wu73">DATE</th>
			<th class="tg-wu73">INFO</th>
		</tr>
		<%
			while (rs.next()) {
						// 첫번째 필드 : NO
						int no = rs.getInt(1);
						// 두번째 필드 : DATE
						String date = rs.getString(2);
						// 세번째 필드 : INFO
						String info = rs.getString(3);
		%>
		<!-- info부분은 팝업창으로 -->
		<tr>
			<td class="tg-7un6"><%=no%></td>
			<td class="tg-7un6"><%=date%></td>
			<td class="tg-7un6"><a href="info.jsp?no=<%=no%>"><%=info%></a></td>
			<td class="tg-7un6"><input onclick="popup(<%=no %>)" type="button" value="INFO"/></td>
		</tr>
		<%
			}
		%>

		<%
		// 객체 종료
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