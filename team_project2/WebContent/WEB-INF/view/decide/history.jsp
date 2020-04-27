<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="//code.jquery.com/jquery-3.5.0.min.js"></script>
<script>
	$(document).ready(function(){
		$(".today").click(function(){
			$("#Today1").css("display","")
			$(".today1_1").css("display","")
		});
		
		$(".today1_1").click(function(){
			$("#Today1").css("display","none")
			$(".today1_1").css("display","none")
		});
		
	
		$(".today11").click(function(){
			$("#Today2").css("display","")
			$(".today2_1").css("display","")
		});
		
		$(".today2_1").click(function(){
			$("#Today2").css("display","none")
			$(".today2_1").css("display","none")
		});
		
	
		$(".today22").click(function(){
			$("#Today3").css("display","")
			$(".today3_1").css("display","")
		});
		
		$(".today3_1").click(function(){
			$("#Today3").css("display","none")
			$(".today3_1").css("display","none")
		});
	
	
		$(".today33").click(function(){
			$("#Today4").css("display","")
			$(".today4_1").css("display","")
		});
		
		$(".today4_1").click(function(){
			$("#Today4").css("display","none")
			$(".today4_1").css("display","none")
		});
	});	
	
</script>
<style>
	#content{
		width:1100px;
		margin: 0 auto;
	}
	.content{
		width:1100px;
		margin: 0 auto;
		border: 1px solid #ebebeb;
		background: #fff;
	}
</style>
<body>
<jsp:include page="/WEB-INF/view/decide/header.jsp"></jsp:include>
<div class="content">
<c:if test="${history.size() <= 0}" >
	<h1 align="center">방문 기록</h1>
	<div><h1>방문기록이 존재하지 않습니다.</h1></div>
</c:if>
	<h1 align="center">방문 기록</h1>
				<div class="today"> 오늘 </div> <br/>
				<div class="today1_1" style="display:none;"> 접기 </div> <br/>
<div id="Today1"style="display:none;">
<c:set var="loop_flag" value="false" />
	<c:forEach var="historyVo" items="${history}">
		<c:if test="${historyVo.day == today}">
			<c:if test="${not loop_flag }">
				<c:set var="loop_flag" value="true" />
			</c:if>
			<form action="/team_project2/decide/foodSelect.com">
			<div>가게이름 :${historyVo.name}</div>
			<div>주소 :${historyVo.address}</div> 
			<input type="hidden" name="url" value="${historyVo.url}"/>
			<input type="submit" value="상세보기"/> <br>
			</form>
		</c:if>
	</c:forEach>
			</div>

	<br> <div class="today11"> 1일전</div> <br>
	<div class="today2_1" style="display:none;"> 접기 </div> <br/>
			<div id="Today2" style="display:none">
	<c:forEach var="historyVo" items="${history}">
		<c:if test="${historyVo.day == yesterday}">
			<c:if test="${not loop_flag2 }">
				<c:set var="loop_flag2" value="true" />
			</c:if>
			<form action="/team_project2/decide/foodSelect.com">
			<div>가게이름 :${historyVo.name}</div>
			<div>주소 :${historyVo.address}</div>
			<input type="hidden" value="${historyVo.url}"/>
			<input type="submit" value="상세보기"/>
			</form>
		</c:if>
	</c:forEach>
			</div>

	<br/><div class="today22"> 2일전 </div><br/>
	<div class="today3_1" style="display:none;"> 접기 </div> <br/>
			<div id="Today3" style="display:none">
	<c:forEach var="historyVo" items="${history}">
		<c:if test="${historyVo.day == twoAgo}">
			<c:if test="${not loop_flag3 }">
				<c:set var="loop_flag3" value="true" />
			</c:if>
			<form action="/team_project2/decide/foodSelect.com">
			<div>가게이름 :${historyVo.name}</div>
			<div>주소 :${historyVo.address}</div>
			<input type="hidden" value="${historyVo.url}"/>
			<input type="submit" value="상세보기"/>
			</form>
			<br />
		</c:if>
	</c:forEach>
	</div>
	<div class="today33"> 3일 이전</div>
	<div class="today4_1" style="display:none;"> 접기 </div> <br/>
	<div id="Today4" style="display:none">
	<c:forEach var="historyVo" items="${history}">
		<c:if test="${historyVo.day < twoAgo}">
			<c:if test="${not loop_flag4 }">
				<c:set var="loop_flag4" value="true" />
			</c:if>
			<form action="/team_project2/decide/foodSelect.com">
			<div>가게이름 :${historyVo.name}</div>
			<div>주소 :${historyVo.address}</div>
			<input type="hidden" value="${historyVo.url}"/>
			<input type="submit" value="상세보기"/>
			</form>
		</c:if>	
	</c:forEach>
	</div>
	</div>
</body>
</html>