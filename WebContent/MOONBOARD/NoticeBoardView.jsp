<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%

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
  <br>
    <table class="table table-bordered">
    <colgroup>
   	 <col width="15%"/>
   	 <col width="35%"/>
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
   	 <!-- 첨부한 파일이 있을때만 다운로드 링크 활성화 -->
   	 <c:if test="${not empty dto.ofile }">
   		 ${dto.ofile }<!-- 기존 파일명 출력 -->
   		 <a href="./noticedown.board?ofile=${dto.ofile }&sfile=${dto.sfile }&idx=${dto.idx }">
   			 [다운로드]
   		 </a>   	 
   	 </c:if>   	 
   	 </td>
   	 <td>다운로드수</td>
   	 <td>${dto.downcount }</td>
    </tr>
	<tr>
		<td colspan="4" align="center">
 		<c:if test="${CITIZENCODE eq dto.citizencode }" var="result">
			<button type="button"
			onclick="location.href='./noticefix.board?boardtype=notice&idx=${param.idx }';">
				수정하기
			</button>
			<button type="button"
			onclick="location.href='./noticeremove.board?boardtype=notice&idx=${param.idx }';">
				삭제하기
			</button>
			<button type="button" onclick="location.href='../mvcboard/list.do';">
				리스트바로가기
			</button>
		</c:if>
 		<c:if test="${not result }">
			<button type="button" onclick="location.href='../mvcboard/list.do';">
				리스트바로가기
			</button>
		</c:if>
		</td>
	</tr>
	
	<script>
	function commentValidate(f){
		if(f.name.value==""){
			alert("작성자를 입력하세요");
			f.name.focus();
			return false;
		}
		if(f.pass.value==""){
			alert("비밀번호를 입력하세요");
			f.pass.focus();
			return false;
		}
		if(f.comments.value==""){
			alert("댓글 내용을 입력하세요");
			f.comments.focus();
			return false;
		}
	}
	</script>
	
	<form name="commentFrm" method="post" action="./commentWrite.comm" 
	onsubmit="return commentValidate(this);">
	<!-- 해당 게시물의 일련번호로 댓글 테이블의 참조키가 된다. -->
	<input type="hidden" name="board_idx" value="${param.boardidx }" />
	<table class="table table-bordered">
		<colgroup>
			<col width="30%"/>
			<col width="40%"/>
			<col width="*"/>
		</colgroup>
		<tr>
			<td>작성자 : <input type="text" name="name" size="10" /></td>
			<td colspan="2">
			비밀번호 : <input type="password" name="pass" size="10" /></td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea name="comments" style="width:100%;height:70px;"></textarea>
			</td>
			<td align="center"><input type="submit" value="댓글쓰기" style="width:80px;height:77px; " /></td>
		</tr>
	</table>
	</form>
	
	<script>
	function commentEdit(idx, board_idx) {
		window.open('./commentEdit.comm?idx='+idx+'&board_idx='+board_idx,
				'commentPop','top=0,left=0,width=700,height=300');
	}
	function commentDelete(idx, board_idx) {
		window.open('./commentDelete.comm?idx='+idx+'&board_idx='+board_idx,
				'commentPop','top=0,left=0,width=700,height=300');
	}
	</script>
	<!-- 
		HTML5에서 지원하는 앵커(Ancher) 기능으로 해당 페이지에서 특정
		위치를 로드하고 싶을때 아래와 같이 <a>태그에 name속성을 부여한다.
		사용시에는 쿼리스트링 마지막에 #앵커명 형태로 사용하면 된다.
	 -->
	<a name="commentList"></a>
	<table class="table table-bordered">
		<colgroup>
			<col width="30%"/>
			<col width="40%"/>
			<col width="*"/>
		</colgroup>
	<c:choose>
		<c:when test="${empty comments }">
			<tr>
				<td colspan="3" align="center">
					등록된 댓글이 없습니다.
				</td>
			</tr>
		</c:when>
	
		<c:otherwise>
			<c:forEach items="${comments }" var="row" varStatus="loop">
			<tr>
				<td>작성자 : ${row.name }</td>
				<td>작성일 : ${row.postdate }</td>
				<td>
					<!-- 수정, 삭제를 위해 전달되는 파라미터는 댓글의 일련번호,
						해당 게시물의 일련번호 2개가 필요하다. -->
					<input type="button" value="수정"
						onclick="commentEdit(${row.idx}, ${row.board_idx });" />
					<input type="button" value="삭제"
						onclick="commentDelete(${row.idx}, ${row.board_idx });" />
				</td>
			</tr>
			<tr>
				<td colspan="3">${row.comments }</td>
			</tr>
			
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</table>
	<br/>
  </div>
</div>
	<%@ include file="../common/Copyright.jsp" %>
</body>
</html>