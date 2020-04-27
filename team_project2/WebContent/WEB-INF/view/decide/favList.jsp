<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
	<style>
	.heart0{
	margin-bottom:15px;
	margin-left:100px;
	}
	.heart{
	margin-top:120px;
	}
	#ht{
	margin-bottom:50px;
	}
	#name{
	margin-bottom:10px;
	}
	#icon{
	margin-left:10px;
	}
	</style>


</head>
<script src="//code.jquery.com/jquery-3.5.0.min.js"></script>
<body>
<jsp:include page="/WEB-INF/view/decide/header.jsp"></jsp:include>
	<h1 id="ht" align="center">즐겨찾기 목록 </h1>
	
<c:if test="${vo.size() <= 0}">
	<div class="heart" align="center">
	<div> 즐겨찾기를 등록한 가게가 존재하지 않습니다. </div>
	</div>
</c:if>
<c:forEach var ="favListVO" items="${vo}">
	<div class="heart0" >
	<div id="name">가게 :	${favListVO.name}
		<span class="fav" style="color: red;">♥</span>
	</div>
	<input type="hidden" id="hidden" value="${favListVO.url}"/>
	 <div>
		주소 : ${favListVO.address}
		
		<button onclick="window.location.href='/team_project2/decide/foodSelect.com?url=${favListVO.url}'" id="icon">상세보기</button>
	 </div>
	 <br>
	 </div>
</c:forEach>

<script>
//즐겨찾기 ajax설정
$(document).ready(function(){
	$(".fav").click(function(){
		//정말 지울건지 확인
		var input_tag = $(this).parent().next();
		var url = input_tag[0].value;
		if(confirm("좋아요를 해제하시겟습니까?") != 0){
			//등록 삭제
			$.ajax({
				url : "/team_project2/decide/fav.com",	
				data : {url : url},
			})
			
			window.location.href='/team_project2/decide/favList.com';
		}
	})
})
</script>

</body>
</html>