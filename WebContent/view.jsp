<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int boardID = 0;
		if(request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		// 아이디가 있어야 특정한 글을 볼 수 있다
		if(boardID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		Board board = new BoardDAO().getBoardOneList(boardID); // 하나의 글 상세보기 
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">게시판 웹 사이트</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>
				<li class="active"><a href="board.jsp">게시판</a></li>
			</ul>
			<%
				//로그인이 되어있지 않다면
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
					    <!--active 현재 선택됌  -->
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>  
					</ul>	
				</li>
			</ul>
			<%	
				//로그인이 되어있는 경우
				} else {			
			%>		
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
					    <!--active 현재 선택됌  -->
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>	
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="row">
				<!--글 상세보기 시작  -->
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2"><%= board.getBoardTitle() %></td>
						</tr>
						<tr>
							<td >작성자</td>
							<td colspan="2"><%= board.getUserID() %></td>
						</tr>
						<tr>
							<td >작성일자</td>
							<td colspan="2"><%= board.getBoardDate().substring(0, 11) + board.getBoardDate().substring(11,13) + "시" + board.getBoardDate().substring(14,16)+ "분" %></td>
						</tr>
						<tr>
							<td >내용</td>
							
							<!--웹브라우저는 <같은 기호가 글의 내용에 포함된 경우 html 문법인지 글의 내용인지 구별하기 어렵다 따라서 기호를 입력했을때 내용이 짤리게 된다 -> 해결법 : replaceAll()을 이용-->
							<!--replaceAll(" ", "&nbsp;") : 공백 처리  -->
							<!--replaceAll("<", "&lt;") : 왼쪽 꺽세 처리  -->
							<!--replaceAll(">", "&gt;") : 오른쪽 꺽세 처리  -->
							<!--replaceAll("\n", "<br>") : 줄바꿈 처리  -->
							<td colspan="2" style="min-height: 200px; text-align: left;"><%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td> 
						
						</tr>
					</tbody>
				</table>
				<a href="board.jsp" class="btn btn-primary">목록</a>
				
					<!--해당 글의 작성자인 경우 수정가능 처리 시작  -->
					<%
						if(userID != null && userID.equals(board.getUserID())){
					%>
							<a href="update.jsp?boardID=<%= boardID %>" class="btn btn-primary">수정</a>
							<a href="deleteAction.jsp?boardID=<%= boardID %>" class="btn btn-primary">삭제</a>
					<% 	
						}
					%>
					<!--해당 글의 작성자인 경우 수정가능 처리 끝  -->
				
				<!--글 상세보기 끝 -->
			
		</div>
	</div>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>