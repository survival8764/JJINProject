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
<title>FREE BOARD</title>

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
	<h1 class="display-4" align="center">FREE BOARD</h1>
	<br>
	<br>
	<div class="container bg-white">
      <table class="table table-hover" >
        <thead>
	      <tr align="center">
            <th width="10%">번호</th>
            <th width="*%">제목</th>
            <th width="15%">작성자</th>
            <th width="10%">조회수</th>
            <th width="15%">작성일</th>
            <th width="10%">파일첨부</th>
          </tr>
        </thead>
<c:choose>
	<c:when test="${empty boardLists }">
		  <tr>
			<td colspan="6" align="center">
				등록된 게시물이 없습니다.
			</td>
		  </tr>
	</c:when>
	<c:otherwise>
		<c:forEach items="${boardLists }" var="row" varStatus="loop">
		  <tr align="center">
			<td>
				${map.totalCount - (((map.pageNum-1) * map.pageSize)
					+ loop.index)}
			</td>
			<td align="left">
				<a href="./freeview.board?boardtype=free&idx=${row.idx }">${row.title }</a>
			</td>
			<td>${row.citizencode }호</td>
			<td>${row.visitcount }</td>
			<td>${row.postdate }</td>
			<td>
			<c:if test="${not empty row.ofile }">
				<a href="./freedown.board?ofile=${row.ofile
					}&sfile=${row.sfile }&idx=${row.idx }">[다운로드]</a> 
			</c:if>
			</td>
		  </tr>
		</c:forEach>
	</c:otherwise>
</c:choose>
	  </table>
	  </div>
	<div class="container bg-white">
	  <table class="table">
		<tr>
		  <td  align="center"> 
				${map.pagingImg }
		  </td>
		  <td width="100" align="center"><button type="button"
			class="btn btn-light" onclick="location.href='./freewrite.board?boardtype=free';">글쓰기</button>
		  </td>
		</tr>
	  </table>
	</div>
	  
	<div class="container" style="background-color:white; width:700px; height:100px;">
	  <form method="get">
	  <input type="hidden" name="boardtype" value="free"/>
		<table class="table table-borderless">
		  <tr>
			<td align="center">
			  <select name="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option>
			  </select>
			  <label class="container" style="background-color:white; width:250px; float:center">
				<input type="text" class="form-control mb-1 mr-sm-1" placeholder="검색어를 입력하세요." name="searchWord" />
			  </label>
			    <input type="submit" class="btn btn-light" value="검색하기" />
			</td>
		  </tr>
		</table>
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