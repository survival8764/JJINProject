<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String cookieCheck = "";
String loginId = CookieManager.readCookie(request, "loginId");
if(!loginId.equals("")) {
	cookieCheck = "checked";
}
%>
<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<title>Insert title here</title>

</head>
<body>
<div class="container p-3 my-3 border">
  <h1>My First Bootstrap Page</h1>
  <p>This container has a border and some extra padding and margins.</p>
</div>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark d-flex">

  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="../MOONBOARD/LoadBoard.jsp">오시는길</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="./notice.board?boardtype=notice">공지사항</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="./free.board?boardtype=free">열린게시판</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="./picture.board?boardtype=picture">문의사항</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">주민장터</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">행사일정</a>
    </li>
  </ul>
  <ul class="navbar-nav ml-auto">
<% if(session.getAttribute("CITIZENCODE")==null){ %>
    <li class="nav-item">
      <a class="nav-link" href="./signup.log">주민등록</a>
    </li>
    <li class="nav-item">
	  <a class="nav-link" href="./login.log">로그인</a>
    </li>
<% }else{ %>
    <li class="nav-item">
	  <a class="nav-link" href="../MOONBOARD/Logout.jsp">로그아웃</a>
	</li>
<% } %>
  </ul>
</nav>
<div class="jumbotron jumbotron-fluid">
  <div class="container">
  <% if(session.getAttribute("CITIZENCODE")==null){ %>
  <form class="form-inline" action="./loginAction.log" method="post">
  <label for="text" class="mr-sm-2">호 수 : </label>
  <input type="text" class="form-control mb-2 mr-sm-2" placeholder="숫자만 입력하세요." name="citizencode" value="<%=loginId %>">
  <label for="pwd" class="mr-sm-2">비밀번호 : </label>
  <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호를 입력하세요." name="pass">
  <div class="form-check mb-2 mr-sm-2">
    <label class="form-check-label">
      <input class="form-check-input" type="checkbox" name="save_check" value="Y" <%=cookieCheck %>/> 아이디 저장
    </label>
  </div>
  <button type="submit" class="btn btn-primary mb-2">Submit</button>
</form>
<% } %>
    <h1>소개</h1>      
    <p>Bootstrap is the most popular HTML, CSS, and JS framework for developing responsive, mobile-first projects on the web.</p>
    <p>Bootstrap is the most popular HTML, CSS, and JS framework for developing responsive, mobile-first projects on the web.</p>
  </div>
</div>
</body>
</html>