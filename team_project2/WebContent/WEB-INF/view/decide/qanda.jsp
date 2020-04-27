<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<style>
div.bubble-question, div.bubble-question div, div.bubble-question div>p, div.bubble-question svg {
    min-height: 52px;
}
div.bubble-question {
    min-width: 40%;
}
.bubble-question {
    margin-top: 40px;
    margin-left: 25px;
}
.bubble {
    display: inline-block;
    box-sizing: border-box;
    position: relative;
}
.bubble svg {
    position: absolute;
    -webkit-filter: drop-shadow(-6px -5px 20px rgba(0,0,0,0.4));
    filter: drop-shadow(-6px -5px 20px rgba(0,0,0,0.4));
    left: 0;
}
svg[Attributes Style] {
    width: 85;
    height: 102;
}
.bubble-question .bubble-tail {
    display: flex;
    float: left;
    align-items: center;
}
.bubble-question .question-number {
    margin: 0 0 0 30px;
    padding: 38px 0 0 0;
}
.bubble-question .question-number {
    color: white;
    font-size: 18px;
    margin: 2px 0 0 30px;
    text-align: center;
    width: 55px;
}
.bubble p {
    margin: 25px 45px;
    position: relative;
    font-size: 20px;
}
p {
    display: block;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}
.bubble-question .question-number::before {
    top: 66px;
}
.bubble-question .question-number::after {
    top: 26px;
}
div.bubble-question div.bubble-body {
    min-width: 50%;
}
.bubble-question .bubble-body {
    float: left;
    max-width: calc(100% - 85px);
}
.bubble-question .question-text {
    margin: 0;
    padding: 25px 25px;
    font-size: 18px;
    background-color: rgba(255,255,255,0.7);
    -webkit-filter: drop-shadow(-6px -5px 20px rgba(0,0,0,0.4));
    filter: drop-shadow(-6px -5px 20px rgba(0,0,0,0.4));
}
.selector ul:not(.social-network) {
    list-style: none;
    padding: 10px 0 0 0;
    margin: 0;
}
.database-selection {
    margin: 50px 40px 0 110px;
    background-color: rgba(255,255,255,0.7);
    min-height: 52px;
}

img{
 width:180px;
 margin-left:400px;
 }
.btn1{
  background-position: center;
  transition: background 0.8s;
    border: none;
  border-radius: 2px;
  padding: 10px 8px;
  font-size: 16px;
  text-transform: uppercase;
  cursor: pointer;
  color: white;
  background-color: #876e64;
  box-shadow: 0 0 4px #999;
  outline: none;
}
.btn1:hover{
background: #4a3e3a radial-gradient(circle, transparent 1%, #E2E2E2 1%) center/15000%;
}
.btn1:active{ 
	background-color: #6eb9f7;
	background-size: 100%;
	transition: background 0s;
}

.btn2{
  background-position: center;
  transition: background 0.8s;
  border: none;
  border-radius: 2px;
  padding: 10px 8px;
  font-size: 16px;
  text-transform: uppercase;
  cursor: pointer;
  color: white;
  background-color: #876e64;
  box-shadow: 0 0 4px #999;
  outline: none;
}
.btn2:hover{
background: #4a3e3a radial-gradient(circle, transparent 1%, #E2E2E2 1%) center/15000%;
}
.btn2:active{ 
	background-color: #6eb9f7;
	background-size: 100%;
	transition: background 0s;
}
.item{float : left;margin-left:90px;}

.sel_body {
    width: 1100px;
    height: 500px;
    margin: 0 auto;
    padding-top: 16px;
    border: 1px solid #CCCCCC;
    background: #fff;
}
#placesList{
    width: 1050px;
    padding-top: 16px;
    margin: 0 auto;
    margin-left:530;
	list-style:none;
	padding-left:0px;
}
ul{
	list-style:none;
}

</style>
<script>
var i = 1
var ansList = "";
jQuery.ajaxSettings.traditional = true;

function readyMap(result){
	document.getElementById("map").style.display="";
	relayout();
	resizeMap();
	searchPlaces(result);
}

$(document).ready(function(){
	$(".btn1").click(function(){
		if(ansList == ""){
			ansList += "q"+i
		}else{
			ansList += ",q"+i
		}
		if(i == 6){
			console.log(ansList);
			$("#q6").css("display", "none");
			$(".q6").css("display", "none");
			$("#a").css("display", "");
			$(".a").css("display", "");
			$.ajax({
				type	: "post",
				url		: "/team_project2/decide/ajaxQA.com",
				dataType : "text",
				data	: {ansList : ansList},
				async	: true,
				success	: function(result){
					console.log("result :" + result)
					$("#result").text(result+"!!");
					readyMap(result);
				}
			})
		}else{
			$("#q"+i).css("display", "none");
			$("#q"+(i+1)).css("display", "");					
		}
		i += 1;
	});
	$(".btn2").click(function(){			
		if(i == 6){
			$("#q6").css("display", "none");
			$(".q6").css("display", "none");
			$("#a").css("display", "");
			$(".a").css("display", "");
			$.ajax({
				type	: "post",
				url		: "/team_project2/decide/ajaxQA.com",
				dataType : "text",
				data	: {ansList : ansList},
				async	: true,
				success	: function(result){
					console.log("result :" + result)
					$("#result").text(result+"!!");
					readyMap(result);
				}
			})
		}else{
			$("#q"+i).css("display", "none");
			$("#q"+(i+1)).css("display", "");					
		};
		i += 1;
	});
});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/decide/header.jsp"></jsp:include>
<br>
<div class="sel_body">
	<div align="center">
	<img alt="결신님" src="/team_project2/resources/img/ggyeolsin00.png">
<div class="bubble-question bubble">
	<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="85" height="102">
		<polygon points="30,0 30,20 29,25 27,30 22,37 15,45 0,60 30,60 30,102 85,102 85,0">
		</polygon>
	</svg>
	<svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="85" height="102">
		<polygon points="30,0 30,20 29,25 27,30 22,37 15,45 0,60 30,60 30,102 85,102 85,0">
		</polygon>
	</svg>
	<div id="q1">
		<div class="bubble-tail"><p class="question-number">1</p></div>
		<div class="bubble-body"><p class="question-text">매운음식이 땡기십니까?</p></div>
	</div>
	<div id="q2" style="display: none;">
		<div class="bubble-tail"><p class="question-number">2</p></div>
		<div class="bubble-body"><p class="question-text">면요리가 땡기십니까?</p></div>
	</div>
	<div id="q3" style="display: none;">
		<div class="bubble-tail"><p class="question-number">3</p></div>
		<div class="bubble-body"><p class="question-text">국물요리는 어떠십니까?</p></div>
	</div>
	<div id="q4" style="display: none;">
		<div class="bubble-tail"><p class="question-number">4</p></div>
		<div class="bubble-body"><p class="question-text">반찬은역시 고기라고 생각하십니까?</p></div>
	</div>
	<div id="q5" style="display: none;">
		<div class="bubble-tail"><p class="question-number">5</p></div>
		<div class="bubble-body"><p class="question-text">보통은 점심으로 잘 먹지않는걸 먹어보시겟습니까?</p></div>
	</div>
	<div id="q6" style="display: none;">
		<div class="bubble-tail"><p class="question-number">6</p></div>
		<div class="bubble-body"><p class="question-text">칼로리는 높아도 상관없다고 생각하십니까?</p></div>
	</div>
	<div class="a" style="display:none;">
		<div class="bubble-tail"><p class="question-number">A</p></div>
		<div class="bubble-body"><p class="question-text">제 결정은..</p></div>
	</div>
</div>
	<div class="database-selection selector dialog-box">
        <div style="top: 17.6936px; width: 220px; opacity: 0;"></div>
        <div class="q6" style="display:bolck;"> 
			<div><input type="button" class="btn1" value="예"/>				<input type="button" class="btn2" value="아니오"/></div> 
		</div>
		<div class="a" style="display:none;">
			<span id="result"></span>
		</div>
    </div>
	<div id ="mapView">
		<div id="map" style="width:1050px; height:350px; display: none;"></div>
	    <div id= "menu_wrap">
		    <ul id="placesList"></ul>
		    <div id="pagination"></div>
		</div>
	</div>
</div>
</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b912f2336605cfb19bb1b1f6eaad81f4&libraries=services"></script>
	<script src="/team_project2/resources/js/mapJS.js"></script>
</body>
</html>