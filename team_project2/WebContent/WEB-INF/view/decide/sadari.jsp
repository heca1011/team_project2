<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
<head>
<title>사다리 게임</title>
<script src="//code.jquery.com/jquery-3.5.0.min.js"></script>
<style>
	#div_body{ 
 	width : 1050px;
 	height : 500px;
 	margin : 0 auto;
 	padding-top:16px;
 	border:1px solid #CCCCCC;
 }
</style>

<script language="javascript" type="text/javascript">

var foodList = [];
var nNum = 0;

function nNumSet(){
	$(document).ready(function(){
		$('input[name="xxx"]:checked').each(function(){
			foodList.push($(this).val());
			shuffle(foodList)
		})
		nNum = foodList.length;
		console.log("갯수는 : " + nNum);
	});
	return nNum;
}

function shuffle(a) { 
	var j, x, i; for (i = a.length; i; i -= 1) { 
		j = Math.floor(Math.random() * i); 
		x = a[i - 1]; 
		a[i - 1] = a[j]; 
		a[j] = x; 
		} 
	}

</script>

</head>

<body>
<jsp:include page="/WEB-INF/view/decide/header.jsp"></jsp:include>
<br />


	<div id="div_body" style="width:1050px;height:450px;border:1px solid #CCCCCC;position:relative;">
		<form action="sadariResult.com">
			<div id="div_step1" style="font-size:20px; margin-top:50px;" align="center">	 
				<h1>원하시는 음식을 선택해주세요!</h1>
				<input type="checkbox" name="select" value="햄버거">햄버거</input>
				<input type="checkbox" name="select" value="쌀국수">쌀국수</input>
				<input type="checkbox" name="select" value="비빔밥">비빔밥</input>
				<input type="checkbox" name="select" value="스시">스시</input>
				<input type="checkbox" name="select" value="죽">죽</input>
				<input type="checkbox" name="select" value="김밥">김밥</input>
				<input type="checkbox" name="select" value="라면">라면</input><br/><br/>
				<input type="checkbox" name="select" value="덮밥">덮밥</input>
				<input type="checkbox" name="select" value="볶음밥">볶음밥</input>
				<input type="checkbox" name="select" value="제육볶음">제육볶음</input>
				<input type="checkbox" name="select" value="순대국밥">순대국밥</input>
				<input type="checkbox" name="select" value="해장국">해장국</input>
				<input type="checkbox" name="select" value="순두부찌개">순두부찌개</input>
				<input type="checkbox" name="select" value="콩국수">콩국수</input><br/><br/>
				<input type="checkbox" name="select" value="아귀찜">아귀찜</input>
				<input type="checkbox" name="select" value="육개장">육개장</input>
				<input type="checkbox" name="select" value="갈비탕">갈비탕</input>
				<input type="checkbox" name="select" value="샌드위치">샌드위치</input>
				<input type="checkbox" name="select" value="우동">우동</input>
				<input type="checkbox" name="select" value="칼국수">칼국수</input>
				<input type="checkbox" name="select" value="만두">만두</input><br/><br/>
				<input type="checkbox" name="select" value="마라탕">마라탕</input>
				<input type="checkbox" name="select" value="쌀국수">쌀국수</input>
				<input type="checkbox" name="select" value="김치찌개">김치찌개</input>
				<input type="checkbox" name="select" value="부대찌개">부대찌개</input>
				<input type="checkbox" name="select" value="닭볶음탕">닭볶음탕</input>
				<input type="checkbox" name="select" value="카레">카레</input>
				<input type="checkbox" name="select" value="오므라이스">오므라이스</input><br/><br/>
				<input type="submit" value="선택" style="margin-top:50px;"/>			
			</div>
		</form>
	</div>
</body>
</html>