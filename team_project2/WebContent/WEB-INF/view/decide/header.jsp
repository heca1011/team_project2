<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/team_project2/resources/css/rollet.css">
<script src="http://code.jquery.com/jquery-latest.min.js" type="text/javascript"></script>

<title>Insert title here</title>
<link href="/team_project2/resources/css/button.css" rel="stylesheet">
<style>
	body{background-color: #f5f6f7;}
	#header1 {width :987px; margin-top:20px; margin-left:600px;}
	#img1 {height: 0px; margin-top:0px; margin-bottom: 10px;}
	#search{height:0px;}
	#cssmenu{margin-top:50px; margin-bottom:50px; list-style:none;}
	.sel_body{
    width: 1500px;
    padding-top: 16px;
    margin: 0 auto;
    border: 1px solid #ebebeb;
    background: #fff;
	}
	#div_body{ 
 	background: #fff;
 	}
</style>

</head>
<body>
	<div id="header1" align="center">
		<h1 id="img1" align="left">결정의 신</h1>
			<div id ="search">
				<form action="/team_project2/decide/search.com" method="post" align="center">
					<input type="text" name="keyword" placeholder="지역과 음식을 입력하세요." />
					<input type="submit" value="검색"  />
					<input type="checkbox" name="check" checked />내 주변에서 검색
				</form>
			</div>
		<div id="login1">
			<table align= "right">
				<c:if test="${sessionScope.memId == null}">
					<tr>
						<td>
							<button class="ripple" onclick="window.location.href='/team_project2/member/loginForm.com'" >로그인</button>
							<button class="ripple" onclick="window.location.href='/team_project2/member/signupForm.com'">회원가입</button>
							<c:if test="${sessionScope.memId == 'admin'}">
								<button class="ripple" onclick="window.location.href='/team_project2/member/memberlist.com'">가입자관리</button>
							</c:if>
						<td>
					</tr>		
				</c:if>
				<c:if test="${sessionScope.memId != null}">
					<tr>
						<td>
							<button class="ripple" onclick="window.location.href='/team_project2/member/logout.com'" >로그아웃</button>
							<button class="ripple" onclick="window.location.href='/team_project2/member/myPage.com'">마이페이지</button>
						<td>
					</tr>
				</c:if>
			</table>
		</div>
	</div>

	<div id='cssmenu' align="center">
		<div class="wrap">
			<ul>
			   <li><a id="rollet1" href='/team_project2/decide/main.com'><span>룰렛</span></a></li>
			   <li><a id="rollet2" href="/team_project2/decide/sadariSelect.com"><span>사다리</span></a></li>
			   <li><a id="rollet3" href="/team_project2/decide/qanda.com"><span>물어봐~</span></a></li>
			</ul>
		</div>
	</div>
</body>
</html>