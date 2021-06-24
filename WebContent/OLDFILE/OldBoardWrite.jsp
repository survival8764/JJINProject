<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String builcode = request.getParameter("builcode");
String idx = request.getParameter("idx");
session.setAttribute("BUILCODE", builcode);
session.setAttribute("IDX", idx);
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
<script type="text/javascript">
    function formValidate(f){
   	 if(f.name.value==""){
   		 alert("작성자를 입력하세요");
   		 f.name.focus();
   		 return false;
   	 }
   	 if(f.title.value==""){
   		 alert("제목을 입력하세요");
   		 f.title.focus();
   		 return false;
   	 }
   	 if(f.content.value==""){
   		 alert("내용을 입력하세요");
   		 f.content.focus();
   		 return false;
   	 }
   	 if(f.pass.value==""){
   		 alert("비밀번호를 입력하세요");
   		 f.pass.focus();
   		 return false;
   	 }
    }
</script>
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
      <a class="nav-link" href="../moonboard/freeboard.do" >열린게시판</a>
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
      <a class="nav-link" href="../moonboard/sign.do">주민등록</a>
    </li>
    <li class="nav-item">
    	<% if(session.getAttribute("IDX")==null){ %>
			<a class="nav-link" href="../MoonBoard/Login.jsp">로그인</a>
		<% }else{ %>
			<a class="nav-link" href="../MoonBoard/Logout.jsp">로그아웃</a>
		<% } %>
	</li>
  </ul>
</nav>
<div class="jumbotron jumbotron-fluid">
  <div class="container bg-white">
  <br/>
<form name="writeFrm" method="post" enctype="multipart/form-data"
    action="./freewriteaction.board" onsubmit="return formValidate(this);">
    <input type="hidden" name="boardtype" value="free"/>
<table class="table table-bordered">

    <tr>
   	 <td>제목</td>
   	 <td>
   		 <input type="text" name="title" style="width:90%;" />
   	 </td>
    </tr>
    <tr>
   	 <td>내용</td>
   	 <td>
   		 <textarea name="content" style="width:90%;height:100px;"></textarea>
   	 </td>
    </tr>
    <tr>
   	 <td>첨부파일</td>
   	 <td>
   		 <input type="file" name="ofile" />
   	 </td>
    </tr>
    <tr>
   	 <td colspan="2" align="center">
   		 <button type="submit" class="btn btn-light">작성완료</button>
   		 <button type="reset" class="btn btn-light">RESET</button>
   		 <button type="button" class="btn btn-light" onclick="location.href='../moonboard/freeboard.do';">
   			 리스트바로가기
   		 </button>
   	 </td>
    </tr>
</table>    
</form>
<br/>
  </div>
</div>
	<%@ include file="../common/Copyright.jsp" %>
</body>
</html>