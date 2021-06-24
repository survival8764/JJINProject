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
<title>BOARD FRAME</title>

<style type="text/css">

div#side_left {
width:15%;
height:800px;
background-color:white;
float:left;
}

#mid_content{
width:70%;
height:800px;
background-color:white;
float:left;
}

#side_right{
width:15%;
height:800px;
background-color:white;
float:right;
}

</style>
</head>
<body>
<%@ include file="../MOONBOARD/BasicTop.jsp" %>

<div id = "side_left">

<br>
	<div class="dropdown" style="background-color:white; width:200px;">
	    <button type="button" style="width: 160px; float:right"class="btn btn-light dropdown-toggle" data-toggle="dropdown">
	      층 게시판
	    </button>
	    <div class="dropdown-menu" align="center">
	   	  <a class="dropdown-item" href="#">Link 1</a>
	    </div>
	</div>

</div>

<div id = "mid_content" class="border border-top-0 border-bottom-0">
	<br>
	<h1 class="display-1" align="center">Log In</h1>
	<br>
	<br>
	<div class="container" style="background-color:white; width:700px; height:100px;">
		<form action="./loginAction.log" method="post">
  			<input type="text" class="form-control" placeholder="호 수 (숫자만입력)" name="citizencode" value="<%=loginId %>"
  				tabindex="1"/>
  				
  			<div class="form-check mb-2 mr-sm-2">
      			<input class="form-check-input" type="checkbox" name="save_check" value="Y"
      				<%=cookieCheck %> tabindex="3"/> 아이디 저장
			</div>
  			<input type="password" class="form-control" placeholder="비밀번호" name="pass" tabindex="2">
  			<div style="text-align: right; margin-top:10px;">
            	<input type="submit" value="로그인하기" class="btn btn-light">
        	</div>
        	<div style="text-align: center; margin-top:10px;">
            	<input type="button" value="회원코드찾기" class="btn btn-light" onclick="location.href='../moonboard/idfind.log'">
            	<input type="button" value="비밀번호찾기" class="btn btn-light" onclick="location.href='../moonboard/passfind.log'">
        	</div>
		</form>
	</div>

</div>

<div id = "side_right">

<% if(session.getAttribute("CITIZENCODE")==null){ %>
	<div class="container" style="background-color:white; width:220px; float:center">
	<br>
	  <form class="form-inline" action="./loginAction.log" method="post">
	      <input type="text" style="width: 180px;" class="form-control mb-1 mr-sm-1" placeholder="호 수 (숫자만입력)" name="citizencode" value="<%=loginId %>">
	      <input type="password" style="width: 180px;" class="form-control mb-1 mr-sm-1" placeholder="비밀번호" name="pass">
	  <div class="form-check mb-2 mr-sm-2">
	    <label class="form-check-label">
	      <input class="form-check-input" type="checkbox" name="save_check" value="Y" <%=cookieCheck %>/> 아이디 저장
	    </label>
	  </div>
	    <button type="submit" style="width: 80px;" class="btn btn-light mb-2">로그인</button>
	  </form>
	</div>
<% } %>

</div>

</body>
</html>