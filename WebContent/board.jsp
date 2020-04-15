<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>

<!-- 글목록(board.jsp) 스타일 꾸미기 시작 -->
<style type="text/css">
	/*링크를 달고 있는 태그의 색깔을 검은색으로 바꾸기, 제목 선택시 밑줄이 그어지지 않도록 처리   */
	a, a:hover{
		color: #000000;
		text-decoration:none;
	}
</style>
<!-- 글목록(board.jsp) 스타일 꾸미기 끝 -->

</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; // 기본 페이지 
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BoardDAO boardDAO = new BoardDAO();
						ArrayList<Board> list = boardDAO.getBoardList(pageNumber);
						for(int i = 0; i < list.size(); i++){	
					%>
				
					<tr>
						<td><%= list.get(i).getBoardID() %></td>
						<!--웹브라우저는 <같은 기호가 글의 내용에 포함된 경우 html 문법인지 글의 제목인지 구별하기 어렵다 따라서 기호를 입력했을때 내용이 짤리게 된다 -> 해결법 : replaceAll()을 이용-->
							<!--replaceAll(" ", "&nbsp;") : 공백 처리  -->
							<!--replaceAll("<", "&lt;") : 왼쪽 꺽세 처리  -->
							<!--replaceAll(">", "&gt;") : 오른쪽 꺽세 처리  -->
							<!--replaceAll("\n", "<br>") : 줄바꿈 처리  -->
						<td><a href="view.jsp?boardID=<%= list.get(i).getBoardID() %>"><%= list.get(i).getBoardTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBoardDate().substring(0, 11) + list.get(i).getBoardDate().substring(11,13) + "시" + list.get(i).getBoardDate().substring(14,16)+ "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			
			<!-- 페이징 처리 시작 -->
			<%
				/* 1이 아닌경우 2페이지 이상 이전 버튼이 보이도록 한다  */
				if(pageNumber != 1){
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber -1 %>"  class="btn btn-success btn-arraw-left">이전</a>		
			<%	
				/* 다음 페이지가 존재한다면 다음 버튼이 보이도록  */
				} if(boardDAO.nextPage(pageNumber + 1)){
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber +1 %>"  class="btn btn-success btn-arraw-left">다음</a>
			<%
			}
			%>
			<!-- 페이징 처리 끝 -->
			
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>