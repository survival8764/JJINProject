<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
      <a class="nav-link" href="./free.board">열린게시판</a>
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
	<form method="get">
	<table class="table table-borderless">
	<tr>
		<td align="center">
			<select name="searchField">
				<option value="title">제목</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchWord" />
			<input type="submit" value="검색하기" />
		</td>
	</tr>
	</table>
	</form>
  <div class="container bg-white">
  <table class="table table-hover">
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
    <tbody>
      <c:choose>
	<c:when test="${empty boardLists }">
	<!-- 등록된 게시물이 없을때. --> 
		<tr>
			<td colspan="6" align="center">
				등록된 게시물이 없습니다.
			</td>
		</tr>
	</c:when>
	<c:otherwise>
		<!-- 게시물이 있는 경우 확장 for문 형태의 forEach태그 사용함. -->
		<c:forEach items="${boardLists }" var="row" varStatus="loop">
		<tr align="center">
			<td>
				${map.totalCount - (((map.pageNum-1) * map.pageSize)
					+ loop.index)}
			</td>
			<td align="left">
				<a href="./noticeview.board?boardtype=notice&idx=${row.idx }">${row.title }</a>
			</td>
			<td>${row.citizencode }호</td>
			<td>${row.visitcount }</td>
			<td>${row.postdate }</td>
			<td>
			<!-- 첨부된 파일이 있는 경우에만 다운로드 링크 출력됨. -->
			<c:if test="${not empty row.ofile }">
<!-- 				파일 다운로드 시 다운로드 횟수를 증가해야 하므로
<!-- 					게시물의 일련번호가 필요함. -->
				<a href="../moonboard/noticedown.board?ofile=${row.ofile
					}&sfile=${row.sfile }&idx=${row.idx }">[다운로드]</a> 
			</c:if>
			</td>
		</tr>
		</c:forEach>
	</c:otherwise>
</c:choose>
	</table>
	<table class="table">
		<tr>
			<td  align="center"> 
				<!-- 컨트롤러에서 map에 저장한 페이지번호 문자열 출력 -->
				${map.pagingImg }
			</td>
			<c:if test="${HUMANTYPE eq 'manager' }" var="result">
			<td width="100" align="center"><button type="button"
				class="btn btn-light" onclick="location.href='./freewrite.board?boardtype=notice';">글쓰기</button></td>
			</c:if>
		</tr>
	</table>
    </tbody>
  </table>
</div>
</div>
	<%@ include file="../common/Copyright.jsp" %>
</body>
</html>