<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<style>
	.my{
		margin-bottom:25px;
	}
	.mybutton{
		width:150px;
		height:50px;
		border: none;
  		border-radius: 2px;
  		padding: 10px 8px;
  		font-size: 20px;
  		text-transform: uppercase;
  		cursor: pointer;
  		color: #fff;
  		background-color: #876e64;
  		box-shadow: 0 0 4px #999;
  		outline: none;
  		background-position: center;
  		transition: background 0.8s;
	}
	.mybutton:hover{
	background: #4a3e3a radial-gradient(circle, transparent 1%, #E2E2E2 1%) center/15000%;
	}

	#mybutton:active{
 	background-color: #6eb9f7;
  	background-size: 100%;
  	transition: background 0s;
	}
	
	
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/view/decide/header.jsp"></jsp:include>

<div id="contents" align="center">
	<h1 class="h1">회원 정보</h1>
	<div class="my"><button onclick="window.location.href='/team_project2/decide/history.com'" class="mybutton">방문기록</button></div>
	<div class="my"><button onclick="window.location.href='/team_project2/decide/favList.com'" class="mybutton">즐겨찾기 목록</button></div>
	<div class="my"><button onclick="window.location.href='/team_project2/member/logout.com'" class="mybutton">로그아웃</button></div>
	<div class="my"><button onclick="window.location.href='/team_project2/member/modifyForm.com'" class="mybutton">정보수정</button></div>
	<div class="my"><button onclick="window.location.href='/team_project2/member/deleteMemberForm.com'" class="mybutton">회원탈퇴</button></div>
</div>

</body>
</html>