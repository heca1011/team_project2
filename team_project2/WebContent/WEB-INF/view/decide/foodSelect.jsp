<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-3.5.0.min.js"></script>
</head>
<body>
<br/>
<h2 align="center">음식점 세부정보</h2>
<form action="main.do">
		<div><input type="submit" value="메인페이지로"/></div>
		<div>이름 : ${vo.name }
			<c:if test="${favData}">
				<span id="fav" style="color: red;">♥</span>
			</c:if>
			<c:if test="${!favData}">
				<span id="fav" style="color: red;">♡</span>
			</c:if>
		</div>
		<div id="address">주소 : ${vo.address }</div>
		<div>타입 : ${vo.type }</div>
		<div>평점 : ${vo.score }</div>
		<c:if test="${vo.phone} != null">
			<div>대표번호 : ${vo.phone }</div>
		</c:if>
		<c:if test="${vo.menu} != null">
			<div> 메뉴 </div>
			<c:forEach var="menu" items="${menu }" varStatus="status">
				<div>${menu} ------------------- ${price[status.index]}원</div>
			</c:forEach>
		</c:if>
		지도
		<div id='map' style="width:700px;height:300px;"></div>
</form>
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
		//if(${sessionScope.memId != null}){
				//function(data){				
					//하트를 채움
					var text = $(this).text();
					if(text == "♡"){
						$("#fav").text("♥");
					}else if(text == "♥"){
						$("#fav").text("♡");
					}
				//}			
		/* }else{
			alert("로그인시 사용가능한 기능입니다.")
		} */
		})
})
</script>
</body>
</html>