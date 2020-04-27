<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.5.0.min.js"></script>
<style type="text/css">
li:nth-of-type(n+5) { display: none; }
#menuBtn:checked ~ li:nth-of-type(n+4) { display: block; }
.details_present {
    position: relative;
    min-height: 144px;
    margin: -1px -1px 0;
    background: url(//t1.daumcdn.net/localimg/localimages/07/2017/pc/bg_nodata.png) no-repeat;
}
.details_present .bg_present {
    display: block;
    position: relative;
    overflow: hidden;
    width: 100%;
    height: 270px;
    -webkit-background-size: cover;
    background-size: cover;
    background-position: 50% 50%;
}
.details_present .bg_present:after {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 65px;
    content: "";
}
.frame_g {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border: 1px solid rgba(0,0,0,.08);
    box-sizing: border-box;
}
.place_details .inner_place {
    min-height: 187px;
    padding-top: 27px;
    background: url(//t1.daumcdn.net/localimg/localimages/07/2017/pc/bg_shadow_side.png) repeat-y;
}
.place_details {
    position: relative;
    z-index: 10;
    width: 744px;
    padding-bottom: 4px;
    margin: -64px auto 0;
    background: url(//t1.daumcdn.net/localimg/localimages/07/2017/pc/bg_shadow_bottom.png) no-repeat 0 100%;
    text-align: center;
}
.tit_location {
    padding: 2px 33px 0;
    font-size: 40px;
    line-height: 50px;
    letter-spacing: -2px;
    display: block;
    font-size: 1.5em;
    margin-block-start: 0.83em;
    margin-block-end: 0.83em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;

}
.cont_essential {
    position: relative;
    border: 1px solid #ebebeb;
    background: #fff;
}
.place_details .location_evaluation {
    height: 30px;
    padding-top: 8px;
    text-align: center;
}
.place_details .ico_dot, .place_details .link_evaluation, .place_details .txt_location {
    display: inline-block;
    font-size: 16px;
    line-height: 25px;
    letter-spacing: -1px;
    vertical-align: top;
    text-decoration: none;
}
.place_details .ico_dot {
    width: 3px;
    height: 3px;
    margin: 12px 4px 0;
    background-position: -120px -60px;
    vertical-align: top;
}
.cont_menu {
    padding: 29px 79px 44px;
    margin-top: 10px;
    border: 1px solid #eaeaea;
    background: #fff;
}
.cont_menu .list_menu .menu_list {
    padding: 2px 0;
    border-bottom: 0;
    padding: 0;
    margin: 0;
}
.cont_menu .list_menu li {
    overflow: hidden;
    position: relative;
    width: 640px;
    padding: 0;
    margin: 0;
}
.loss_word {
    display: block;
    overflow: hidden;
    width: 100%;
    text-overflow: ellipsis;
    white-space: nowrap;
    word-break: break-word;
}
.cont_menu .menuonly_type .loss_word {
    width: 100%;
    line-height: 23px;
}
.cont_menu .menuonly_type .info_menu {
    overflow: hidden;
    float: none;
    margin: 0;
    padding: 0;
}
ul {
    padding: 0;
    margin: 0;
}
.details_placeinfo .txt_address, .details_placeinfo .txt_traffic {
    display: block;
    word-break: break-all;
}
.details_placeinfo .placeinfo_default {
    min-height: 22px;
    padding-bottom: 10px;
    line-height: 22px;
}
.details_placeinfo .location_present .num_contact {
    float: left;
}
.details_placeinfo .num_contact {
    display: block;
}
.details_placeinfo {
    position: relative;
    padding: 25px 79px 40px;
    border: 1px solid #ebebeb;
    background: #fff;
}
.cont_findway {
    padding: 29px 79px 47px;
    margin-top: 10px;
    border: 1px solid #eaeaea;
    background: #fff;
}
.sel_body1{
    width: 800px;
    padding-top: 16px;
    margin: 0 auto;
}	
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/view/decide/header.jsp"></jsp:include>
	<br/>
<div class="sel_body1">
	<h2>음식점 세부정보</h2>
<div class="cont_essential">
	<div class="details_present">
		<span class="bg_present" style="background-image:url('${vo.img}')">
		</span>
		<span class="fram_g"></span>
	</div>
	<!-- place_details -->
	<div class="place_details">
		<div class="inner_place">
			<div class="tit_location">${vo.name }
				<c:if test="${favData}">
					<span id="fav" style="color: red;">♥</span>
				</c:if>
				<c:if test="${!favData}">
					<span id="fav" style="color: red;">♡</span>
				</c:if>
			</div>
			<div class="location_evaluation">
				<span class="txt_location">${vo.type}</span>
				<span class="ico_comm ic_dot"></span>
				<span class="link_evaluation">평점 ${vo.score}</span>
			</div>
		</div>
	</div>
	<!-- place_details -->
</div>
	<!-- cont-essential -->
	
	<!-- details_placeinfo -->
<div class="details_placeinfo">
	<h3 class="tit_subject">상세정보</h3>
	<div class="placeinfo_default">
		<span class="txt_address">${vo.address}</span>
	</div>
	<c:if test="${vo.phone != null}">
		<div class="num_contact">대표번호 : ${vo.phone }</div>
	</c:if>
</div>
	<div class="cont_menu">
		<c:if test="${menu != null}">
			<div class="particular_head"> 메뉴 </div> <br>
			<ul class="list_menu">
			<c:forEach var="menu" items="${menu}" varStatus="status">
				<c:if test="${price[status.index] != null}">
					<li class="menu_list">
						<div class="info_menu">
							<span class="loss_word">${menu}		------------------- ${price[status.index]}원</span>
						</div>
					</li>
					<c:if test="${status.index == 3}">
						<br>메뉴 더보기<input type="checkbox" id="menuBtn"/>
						<br>
					</c:if>
				</c:if>
				<c:if test="${price[status.index] == null}">
					<li class="menu_list">
						<div class="info_menu">
							<span class="loss_word">${menu}</span>
						</div>
					</li>
					<c:if test="${status.index == 3}">
						<br>메뉴 더보기<input type="checkbox" id="menuBtn"/>
						<br>
					</c:if>
				</c:if>
			</c:forEach>
			</ul>
		</c:if>
	</div>
	<div class="cont_findway">
		<div>약도</div> <br>
		<div id='map' style="width:700px;height:300px;"></div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b912f2336605cfb19bb1b1f6eaad81f4&libraries=services"></script>
<script>

var mapContainer = document.getElementById('map'), // 지도를 표시할 div
mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

//주소로 좌표를 검색합니다
geocoder.addressSearch('${vo.address}', function(result, status) {

// 정상적으로 검색이 완료됐으면 
 if (status === kakao.maps.services.Status.OK) {

    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
    // 결과값으로 받은 위치를 마커로 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: coords
    });

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">'+'${vo.name}'+'</div>'
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords);
} 
});

// 즐겨찾기 ajax설정
$(document).ready(function(){
	$("#fav").click(function(){
		if(${sessionScope.memId != null}){				
			var text = $(this).text();
			var a = "${vo.name}";
			var name = "${vo.name}";
			var address = "${vo.address}";
			var url = "${vo.url}"
				 $.ajax({
					type : "POST",
					url : "/team_project2/decide/success.com",	
					data : {name : name, address : address, url : url, text :text},
				 })
			if(text == "♡"){
				$("#fav").text("♥");
			}else if(text == "♥"){
				$("#fav").text("♡");
			}			
		 }else{
			alert("로그인시 사용가능한 기능입니다.")
		} 
	})
})
</script>
</body>
</html>