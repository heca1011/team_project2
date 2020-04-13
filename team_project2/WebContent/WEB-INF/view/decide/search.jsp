<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<div id="map" style="width:100%;height:350px;"></div>
	<form onsubmit="searchPlaces(); return false;">
     	키워드 : <input type="text" id="keyword" size="15"> 
     	<button type="submit">검색하기</button> 
    </form>
    <div id= "menu_wrap">
	    <ul id="placesList"></ul>
	    <div id="pagination"></div>
    </div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b912f2336605cfb19bb1b1f6eaad81f4&libraries=services
"></script>
	<script>
		var markers = []; // 마커를 담을 배열
		
		var locPosition; // 사용자의 위치를 담을 변수
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = { 
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 3 // 지도의 확대 레벨 
		    }; 
	
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {
		    var options ={
		    	enablehighAccuracy:true
		    }
		    var error = function(error){
		    	console.log('에러발생!!');
		    }
		    
		    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    navigator.geolocation.getCurrentPosition(function(position) {
	    	
		        var lat = position.coords.latitude, // 위도
		            lon = position.coords.longitude; // 경도
		        
		        locPosition = new kakao.maps.LatLng(lat, lon); // geolocation으로 얻어온 좌표로 위치정보 생성
		            
		      }, error, options);
		    
		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
		    
		    locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
		        message = 'geolocation을 사용할수 없어요..'
		        
		    displayMarker(locPosition, message);
		}
		
		var places = new kakao.maps.services.Places(); // 장소검색 서비스 객체를 생성합니다.
		
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});

		// 키워드검색 요청
		function searchPlaces(){
			var keyword = document.getElementById('keyword').value;
			
			if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
			
			var searchOptions= {
	    		location: locPosition,
				radius: 1000 // 검색범위설정 (m단위)
			
	    	}
			
			// 주변범위검색
			places.keywordSearch(keyword,placesSearch,searchOptions);
			// 지역명까지 함께 검색
			//places.keywordSearch(keyword,placesSearch);
			
			
		}
		// 검색키워드 작성 -> 호출되는 메서드 A (15개의 한페이지 결과만 받아옴)
		// 검색을 했을때, 새로운 함수를 하나만들어 검색시 호출되게 수정.가능한지 알아보고, 
		// 새로운함수 (A함수를 호출 (페이지 보여주기가 아니라, 데이터만 가져오는 함수) )
		//  ==> 부르면 변수에 값들만 저장
		
		function getDatas(data,status,pagination) {
			//console.log(pagination);
			for(var i = 1; i <= pagination.last; i++){
				pagination.gotoPage(i);
			}
				console.log(data);
		}
		var check = true;
		var check_num = 1;
		//검색 콜백함수
		function placesSearch(data, status, pagination){
			 if (status === kakao.maps.services.Status.OK) {
				 
			        // 정상적으로 검색이 완료됐으면
			        // 검색 목록과 마커를 표출
			        displayPlaces(data);

			        // 페이지 번호를 표출
			        displayPagination(pagination);
			        
			        console.log("check_num : "+check_num)
			        if(pagination.last < check_num){
			       		check = false;			        	
			        }
			        if(check){
						getDatas(data,status,pagination);
				        check_num ++;
					}

			    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

			        alert('검색 결과가 존재하지 않습니다.');
			        return;

			    } else if (status === kakao.maps.services.Status.ERROR) {

			        alert('검색 결과 중 오류가 발생했습니다.');
			        return;

			    }
			}
		
		
		
		// 검색 결과 목록과 마커를 표출하는 함수
		function displayPlaces(places) {

		    var listEl = document.getElementById('placesList'),
		    menuEl = document.getElementById('menu_wrap'),
		    fragment = document.createDocumentFragment(), 
		    bounds = new kakao.maps.LatLngBounds(), 
		    listStr = '';
		    
		    
		    
		    // 검색 결과 목록에 추가된 항목들을 제거
		    removeAllChildNods(listEl);

		    // 지도에 표시되고 있는 마커를 제거
		    removeMarker();
		    
		    
		    for ( var i=0; i<places.length; i++ ) {

		        // 마커를 생성하고 지도에 표시
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
       
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가
		        bounds.extend(placePosition);

		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });

		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });

		            itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };

		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);

		        fragment.appendChild(itemEl);
		    }

		    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가
		    listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;

		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정
		    map.setBounds(bounds);
		}

		// 검색결과 항목을 Element로 반환
		function getListItem(index, places) {

		    var el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + places.place_name + '</h5>';

		    if (places.road_address_name) {
		        itemStr += '    <span>\n' + places.road_address_name + '</span>' +
		                    '   <span class="jibun gray">\n' +  places.address_name  + '</span>';
		    } else {
		        itemStr += '    <span>\n' +  places.address_name  + '</span>'; 
		    }
		                 
		      itemStr += '  <span class="tel">\n' + places.phone  + '</span>' +
		                '</div>';           

		    el.innerHTML = itemStr;
		    el.className = 'item';

		    return el;
		}

		// 마커를 생성하고 지도 위에 마커를 표시하는 함수
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });

		    marker.setMap(map); // 지도 위에 마커를 표출
		    markers.push(marker);  // 배열에 생성된 마커를 추가

		    return marker;
		}

		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 

		    // 기존에 추가된 페이지번호를 삭제
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }

		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#";
		        el.innerHTML = i;

		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }

		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수
		// 인포윈도우에 장소명을 표시
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}

		 // 검색결과 목록의 자식 Element를 제거하는 함수
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
		</script>
	</body>
</html>