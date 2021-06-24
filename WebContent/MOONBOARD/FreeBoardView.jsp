<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
<title>BOARD VIEW</title>

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
	<h1 class="display-4" align="center">BOARD VIEW</h1>
	<br>
      <div class="container bg-white">
      <br>
        <table class="table table-bordered">
        <colgroup>
   	      <col width="15%"/>
   	      <col width="30%"/>
   	      <col width="15%"/>
   	      <col width="*"/>
        </colgroup>
	    <tr>
	   	  <td>번호</td>
	   	  <td>${dto.idx }</td>
	   	  <td>작성자</td>
	   	  <td>${dto.citizencode }호</td>
	    </tr>
	    <tr>
	   	  <td>작성일</td>
	   	  <td>${dto.postdate }</td>
	   	  <td>조회수</td>
	   	  <td>${dto.visitcount }</td>
	    </tr>
	    <tr>
	   	  <td>제목</td>
	   	  <td colspan="3">${dto.title }</td>
	    </tr>
	    <tr>
	   	  <td>내용</td>
	   	  <td colspan="3" height="100">${dto.content }</td>
	    </tr>
	    <tr>
	   	  <td>첨부파일</td>
   	 	  <td>
	<c:if test="${not empty dto.ofile }">
   			${dto.ofile }
   		<a href="./freedown.board?ofile=${dto.ofile }&sfile=${dto.sfile }&idx=${dto.idx }">
   			[다운로드]
   		</a>   	 
	</c:if>   	 
   	 	  </td>
   	 	  <td>다운로드수</td>
   	 	  <td>${dto.downcount }</td>
    	</tr>
		  <tr>
		    <td colspan="4" align="center">
	<c:if test="${CITIZENCODE eq dto.citizencode || HUMANTYPE eq 'manager'}" var="result">
			  <button type="button" class="btn btn-light mb-2"
			  	onclick="location.href='./freefix.board?boardtype=free&idx=${param.idx }';">
				수정하기
			  </button>
			  <button type="button" class="btn btn-light mb-2"
			  	onclick="location.href='./free.board?boardtype=free';">
				리스트바로가기
			  </button>
			  <button type="button" class="btn btn-light mb-2"
			  	onclick="location.href='./freeremove.board?boardtype=free&idx=${param.idx }';">
				삭제하기
			  </button>
	</c:if>
	<c:if test="${not result }">
			  <button type="button" class="btn btn-light mb-2" 
			    onclick="location.href='./free.board?boardtype=free';">
				리스트바로가기
			  </button>
	</c:if>
		    </td>
	  	  </tr>
	    </table>
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