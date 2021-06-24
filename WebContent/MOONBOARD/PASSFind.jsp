<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String builcode = request.getParameter("builcode");
session.setAttribute("BUILCODE", builcode);
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
      <a class="nav-link" href="#">공지사항</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">열린게시판</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">문의사항</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">주민장터</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">행사일정</a>
    </li>
  </ul>
  <ul class="navbar-nav ml-auto">
    <li class="nav-item2">
    	<% if(session.getAttribute("CITIZENCODE")==null){ %>
      <a class="nav-link" href="./signup.log">주민등록</a>
			<a class="nav-link" href="./login.log">로그인</a>
    </li>
    <li class="nav-item">
		<% }else{ %>
			<a class="nav-link" href="../MOONBOARD/Logout.jsp">로그아웃</a>
		<% } %>
	</li>
  </ul> 
</nav>
<form action="../moonboard/passfindAction.log" method="post">
<div class="jumbotron jumbotron-fluid">
  <div class="container">
  <div class="form-group">
  <label for="usr"> 건물코드 :</label>
  <input type="text" class="form-control" name="code">
</div>
<div class="form-group">
  <label for="pwd"> 호 수 :</label>
  <input type="text" class="form-control" name="citizencode">
</div>
<div style="text-align: center; margin-top:10px;">
            <input type="submit" value="인증하기" class="btn btn-light">
        </div>
  </div>
</div>
</form>
	<%@ include file="../common/Copyright.jsp" %>
</body>
</html>