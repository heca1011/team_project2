<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>  
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<style>
#content .lunch {margin-bottom:30px;}
#content .lunch .sec {padding-bottom:30px;}
#content .lunch .rolling_wrap {position:relative;width:1050px;height:114px;font-weight:700;text-align:center;overflow:hidden;background:#fff;border:1px solid #ddd;border-radius:4px;}
#content .lunch .rolling_wrap ul {position:absolute;width:1050px;top:0;left:0px;-webkit-transition:top 0.8s cubic-bezier(0.75,0.1,0.25,1);transition:top 0.8s cubic-bezier(0.75,0.1,0.25,1);}
#content .lunch .rolling_wrap li {width:1050px;height:114px;font-size:40px;line-height:115px;}
#content .lunch .sec3 p {margin-bottom:20px;}
#content{margin-top:130px;}
#button0{margin-top:30px; margin-left:998px;}
#button1{margin-top:20px; margin-left:840px;}
.item{float : left;margin-left:90px;}

#content{
    width: 1100px;
    height: 900px;
    padding-top: 16px;
    margin: 0 auto;
    border: 1px solid #ebebeb;
    background: #fff;
    align: center;
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
<script src="https://www.dailyest.co.kr/js/jquery-1.11.3.min.js"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
 $(function(){
	//옵션 선택 버튼 눌렀을때
	$("#button1").click(function(){
		$("#divToggle1").toggle();
		$("#divToggle2").hide();
	}); 
 	//전체목록보기 눌렀을때
	$("#button2").click(function(){
		$("#divToggle2").toggle();
		$("#divToggle1").hide();
	});
 });
 
 //현재 저장되어있는 전체목록
 
 $(document).ready(function(){	 
	var str = document.getElementById("li_menu").value
	//전체목록보기에서 수정후 변경사항저장버튼
	$(".btn1").click(function(){
		menu_set();
		$("#divToggle2").hide();
	});	 
	$(".optionBtn").click(function(){
		var option = "";
		$("input:checkbox[class='check']:checked").each(function(){
			option += $(this).val() + ",";			
		})
		$.ajax({
			type	: "post",
			url		: "/team_project2/decide/ajaxRoulette.com",
			data	: {option : option},
			success	: function(result){
				console.log(result)
				$("textarea[id='li_menu']").text(result);
				menu_set();
				$("#divToggle1").hide();
			}
		})
	});
});

</script>


</head>
<body>
<jsp:include page="/WEB-INF/view/decide/header.jsp"></jsp:include>

<div id="content">				
	<div class	="lunch">
		<div class="sec">
			<div class="rolling_wrap">
			</div>
				<button type="button" class="btn-select">시작</button>
		</div>
		<button id ="button1">옵션 선택</button>
		<button id="button2" >전체목록 보기</button>
		
		<!-- 버튼1 옵션선택 -->
		<div id = "divToggle1" style="display:none">
			<input type="checkbox" class="check" value="회식음식" />회식음식<br />
			<input type="checkbox" class="check" value="다이어트 음식" />다이어트 음식<br />
			<input type="checkbox" class="check" value="오늘의 음식"  />오늘의 음식<br />
			<button class="optionBtn">적용하기</button>				
		</div>
		<!-- 버튼2 전체목록 -->
		<div id ="divToggle2" style="display:none">
			<div>추가하거나 제거하고싶은 메뉴를 직접 메뉴입력칸에서 조정하세요.<br>구분자는 콤마(,) 입니다. <b>변경버튼을 누르면 적용됩니다.</b></div>
			<textarea class="li_menu" id="li_menu" rows="5">
				,비빔밥,스시,죽,김밥,라면,덮밥,볶음밥,제육볶음,순대,
				순대국밥,짜장면,볶음밥,짜장밥,짬뽕,짬뽕밥,잔치국수,불고기,찜닭
				,닭볶음탕,부대찌개,김치찌개,카레,오므라이스,김치볶음밥,연어덮밥,
				수육,아귀찜,순두부찌개,콩나물국밥,해장국,스파게티,파스타,냉면,
				칼국수,우동,콩국수,육개장,떡국,갈비탕,삼계탕,샌드위치,떡볶이,
				햄버거,핫도그,쌀국수,마라탕
			</textarea>
			<div><button class="btn1">적용하기</button></div>
		</div>
	</div>
	<div id = "result"></div>
	<div id ="mapView">
		<div id="map" style="width:1050px; height:350px; display: none;"></div>
	    <div id= "menu_wrap">
		    <ul id="placesList"></ul>
		    <div id="pagination"></div>
		</div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b912f2336605cfb19bb1b1f6eaad81f4&libraries=services"></script>
	<script src="/team_project2/resources/js/mapJS.js"></script>
</div>



<script>
var li_menu_split;
var c;

function menu_set(){ 
	var rolling_wrap = $(".rolling_wrap");
	var li_menu = $('.li_menu').val();	
	li_menu_split = li_menu.split(',');
	li_menu_split.shift()
	c = li_menu_split.length;
	var inner_list;

	inner_list = "<ul>";
	for(i=0;i<3;i++){
			for(j=0;j<c;j++){					
				inner_list += "<li>"+li_menu_split[j]+"</li>";				
			}
	}
	inner_list += "</ul>";
	
	rolling_wrap.html(inner_list);
	
}

menu_set();

$(function(){
	$(document).on("click",".btn-select",function(){ 
		var rolling_wrap = $(".rolling_wrap");
		var li_count = rolling_wrap.find('li').length;
		var t = 4;
		var r = Math.floor(Math.random() * li_count);
		var d = 0;
		for(var i = 0; i < r; i++){
			d++; 
			if(d > c-1){
				d = 0;
			}
		}
		var p = -(r * 114);
		var a = rolling_wrap.find('ul').css({'transition-duration':t+'s','top':p});
		setTimeout(function() { 
			$("div[id='result']").text("결과는!! "+li_menu_split[d]); + "!!!" 
			document.getElementById("map").style.display="";	
			relayout();
			resizeMap();
			searchPlaces(li_menu_split[d]);
		}, 4000);
	})
})



</script>
</html>