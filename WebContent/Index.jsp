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
<title>건물코드확인</title>
<style>
    *{margin:0px auto; font-family: 'Noto Sans KR', sans-serif;}
</style>
</head>
<body>
<div class="container" style="margin-top:200px">
  <h2 align="center">건물코드를 입력해주세요.</h2>
  <form action="./index" method="post">
    <div class="form-group">
      <input type="text" class="form-control" name="code">
      <button type="submit" class="btn btn-light btn-block">인증하기</button>
    </div>
  </form>
</div>
</body>
</html>