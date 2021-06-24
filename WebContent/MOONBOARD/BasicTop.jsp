<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>기본 바</title>
</head>
<body>

<div class="jumbotron jumbotron-fluid" style="margin-bottom:0">
  <div class="container">
    <h1 align=center class="display-1">SWEET HOME</h1>      
  </div>
</div>

<nav class="navbar navbar-expand-sm bg-light navbar-light">
  <ul class="navbar-nav">
    <li class="nav-item active">
      <a class="nav-link" href="./main.log">HOME</a>
    </li>
    <li class="nav-item active">
      <a class="nav-link" href="./main.log">오시는길</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="./notice.board?boardtype=notice">공지사항</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="./free.board?boardtype=free">자유게시판</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="./picture.board?boardtype=picture">갤러리</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">주민장터</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">행사일정</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">문의사항</a>
    </li>
  </ul>
<% if(session.getAttribute("CITIZENCODE")==null){ %>
  <ul class="navbar-nav ml-auto">
    <li class="nav-item">
      <a class="nav-link" href="./signup.log">주민등록</a>
    </li>
    <li class="nav-item">
	  <a class="nav-link" href="./login.log">로그인</a>
    </li>
  </ul>
<% }else{ %>
  <ul class="navbar-nav ml-auto">
    <li class="nav-item">
	  <a class="nav-link" href="">회원정보수정</a>
	</li>
    <li class="nav-item">
	  <a class="nav-link" href="./logout.log">로그아웃</a>
	</li>
  </ul>
<% } %>
</nav>

</body>
</html>