<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.BoardDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="boardTitle"/>
<jsp:setProperty name="board" property="boardContent"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		//이미 로그인이 된 유저는 또다시 로그인할 수 없도록
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
			}
		if (userID == null){
		
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else{
			
			if(board.getBoardTitle() == null || board.getBoardContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다.')");
				script.println("history.back()"); 
				script.println("</script>");
			} else {
				BoardDAO boardDAO = new BoardDAO();
				
				//주의 유저아이디는 로그인 후에 세션에 저장했던 로컬 변수를 사용한다.
				int result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent());
				
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()"); //이전페이지(로그인페이지)로 사용자를 돌려보낸다
					script.println("</script>");
				}
				else {	
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'board.jsp'");
					script.println("</script>");
				}
			}
		}
	

		
		
	%>
</body>
</html>