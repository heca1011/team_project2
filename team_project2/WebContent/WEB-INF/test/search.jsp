<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>geolocation���� ��Ŀ ǥ���ϱ�</title>
    <script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
	<script>
			$(document).ready(function(){
				$("#id").click(function(){
					id = $("#id").val();
					$.ajax({
						type	: "post",
						url		: "/spring/member/ajaxIdAvail.do",
						data	: {id : id},
						success	: function(data){
							console.log(data)
							$("#idCheckjq").val(data);
						} 
					});
				});
			});
	</script>
</head>

<body>
<div id="map" style="width:450px;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b912f2336605cfb19bb1b1f6eaad81f4
"></script>
<script>
var mapContainer = document.getElementById('map'), // ������ ǥ���� div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // ������ �߽���ǥ
        level: 6 // ������ Ȯ�� ���� 
    }; 

var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�

// HTML5�� geolocation���� ����� �� �ִ��� Ȯ���մϴ� 
if (navigator.geolocation) {
    var options ={
    	enablehighAccuracy:true
    }
    var error = function(error){
    	console.log('�����߻�!!');
    }
    
    // GeoLocation�� �̿��ؼ� ���� ��ġ�� ���ɴϴ�
    navigator.geolocation.getCurrentPosition(function(position) {
        
    	
        var lat = position.coords.latitude, // ����
            lon = position.coords.longitude; // �浵
            
            alert("������ġ��:" + lat+","+lon);
        
        var locPosition = new kakao.maps.LatLng(lat, lon), // ��Ŀ�� ǥ�õ� ��ġ�� geolocation���� ���� ��ǥ�� �����մϴ�
            message = '<div style="padding:5px;">���⿡ ��Ű���?!</div>'; // ���������쿡 ǥ�õ� �����Դϴ�
        
        // ��Ŀ�� ���������츦 ǥ���մϴ�
        displayMarker(locPosition, message);
            
      }, error, options);
    
} else { // HTML5�� GeoLocation�� ����� �� ������ ��Ŀ ǥ�� ��ġ�� ���������� ������ �����մϴ�
    
    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation�� ����Ҽ� �����..'
        
    displayMarker(locPosition, message);
}

// ������ ��Ŀ�� ���������츦 ǥ���ϴ� �Լ��Դϴ�
function displayMarker(locPosition, message) {

    // ��Ŀ�� �����մϴ�
    var marker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // ���������쿡 ǥ���� ����
        iwRemoveable = true;

    // ���������츦 �����մϴ�
    var infowindow = new kakao.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
    // ���������츦 ��Ŀ���� ǥ���մϴ� 
    infowindow.open(map, marker);
    
    // ���� �߽���ǥ�� ������ġ�� �����մϴ�
    map.setCenter(locPosition);      
}    
</script>
</body>
</html>