<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, minimum-scale=1.0, user-scalable=no"/>
    <title>Place Search Site</title>
    <script type="text/javascript" src=//dapi.kakao.com/v2/maps/sdk.js?appkey=b912f2336605cfb19bb1b1f6eaad81f4&libraries=services"></script>
    <script src="//code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light mb-5" style="background-color: #e3f2fd;">
        <a class="navbar-brand font-weight-bold" href="#">
            <img src="/img/logo.png" width="30" height="30" class="d-inline-block align-top" alt="">
            Place Search Site
        </a>

        <div class="collapse navbar-collapse" id="navbarColor03">
            <div class="navbar-nav mr-auto">
            </div>
            <form class="form-inline" action="/logout">
                <button class="btn btn-outline-primary my-2 my-sm-0">로그아웃</button>
            </form>
        </div>
    </nav>
    <div class="container w-100 h-100">
        <div class="row" id="contents">
            <div class="col-9 mb-5">
                <div class="row">
                    <div class="col">
                        <form name="searchForm" onsubmit="place.search(); return false;">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" name="keywordNm" placeholder="검색어를 입력해 주세요." aria-label="Recipient's username" aria-describedby="basic-addon2">
                                <input type="hidden" name="currentPage" value="1">
                                <input type="hidden" name="searchType" value="search">
                                <div class="input-group-append">
                                    <button class="btn btn-primary">검색</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-12" id="place_list">
                        <div class="card h-100">
                            <div class="card-body text-center">
                                <h3 class="my-xl-5">검색된 결과가 없습니다.</h3>
                            </div>
                        </div>
                    </div>
                    <div class="w-100"></div>
                    <div class="col">
                        <ul class="pagination justify-content-center mt-3" id="pagination">
                        </ul>
                        <div class="modal fade" id="mapModal" tabindex="-1" role="dialog" aria-labelledby="mapModal" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h4 class="modal-title font-weight-bold" id="exampleModalLongTitle">검색 상세보기</h4>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <div class="row">
                                            <div class="col">
                                                <div id="map" class="map" style="width:100%; height:400px"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-3 text-center mb-5">
                <div class="row">
                    <div class="col">
                        <nav class="navbar navbar-dark bg-primary text-wrap">
                            <span class="text-white mx-auto font-weight-bold">인기 키워드</span>
                        </nav>
                        <ul class="list-group" id="keyword_list"></ul>
                    </div>
                    <div class="w-100"></div>
                    <div class="col mt-5">
                        <nav class="navbar navbar-dark bg-primary text-wrap">
                            <span class="text-white mx-auto font-weight-bold">내 검색 히스토리</span>
                        </nav>
                        <ul class="list-group" id="history_list"></ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
    		$.ajaxSetup({

    		    beforeSend: function () {
    		        var width = 0;
    		        var height = 0;
    		        var left = 0;
    		        var top = 0;

    		        width = 150;
    		        height = 150;
    		        top = ( $(window).height() - height ) / 2 + $(window).scrollTop();
    		        left = ( $(window).width() - width ) / 2 + $(window).scrollLeft();

    		        if($("#ajaxLoading").length != 0) {
    		            $("#ajaxLoading").css({
    		                "top": top+"px",
    		                "left": left+"px"
    		            });
    		            $("#ajaxLoading").show();
    		        }
    		        else {
    		            $('body').append('<div id="ajaxLoading" style="position:absolute; top:' + top + 'px; left:' + left + 'px; width:' + width + 'px; height:' + height + 'px; z-index:9999; filter:alpha(opacity=50); opacity:alpha*0.5; margin:auto; padding:0; "><img src="/img/ajax_loading.gif" style="width:150px; height:150px;"></div>');
    		        }
    		    },
    		    complete: function () {
    		        $("#ajaxLoading").hide();
    		    }
    		});

    		var login = {

    		    submit: function () {
    		        var frm = document.loginForm;

    		        if(trim(frm.userId.value) == ''){
    		            alert("아이디를 입력해 주세요.");
    		            frm.userId.focus();
    		            return false;
    		        }

    		        if(trim(frm.userPw.value) == ''){
    		            alert("비밀번호를 입력해 주세요.");
    		            frm.userPw.focus();
    		            return false;
    		        }

    		        var url = '/login';
    		        var data = $("form[name=loginForm]").serialize();

    		        $.ajax({
    		            type: "POST",
    		            url: url,
    		            data: data,
    		            dataType: 'JSON',
    		            success: function (res) {
    		                if(res == true){
    		                    window.location.href = '/index';
    		                }else{
    		                    alert("로그인 정보를 다시 확인해 주세요.");
    		                    frm.userId.value = '';
    		                    frm.userPw.value = '';
    		                    frm.userId.focus();
    		                }
    		            }
    		        });
    		    }
    		}

    	

    		function trim(str) {
    		    return str.replace(/^\s+|\s+$/g,"");
    		}

    		function loadMap(lat, lng) {
    		    var moveLatLon = new kakao.maps.LatLng(lat, lng);

    		    var marker = new kakao.maps.Marker({
    		        map: map,
    		        position: moveLatLon
    		    });

    		    var contents = '<div class="wrap">\n';
    		    contents += '    <div class="info">\n';
    		    contents += '        <div class="title">\n';
    		    contents += '            <div class="text">' + sessionStorage.getItem('title') + '</div>\n';
    		    contents += '            <div class="close" onclick="closeOverlay()" title="닫기"></div>\n';
    		    contents += '        </div>\n';
    		    contents += '        <div class="body">\n';
    		    contents += '            <div class="desc">\n';
    		    if(trim(sessionStorage.getItem('road_adres')) == ''){
    		        contents += '                <div class="ellipsis">'+ sessionStorage.getItem('adres')+'</div>\n';
    		    }else{
    		        contents += '                <div class="ellipsis">'+ sessionStorage.getItem('road_adres')+'</div>\n';
    		        contents += '                <div class="jibun ellipsis">' + sessionStorage.getItem('adres') + '</div>\n';
    		    }
    		    if(trim(sessionStorage.getItem('phone')) == ''){
    		        contents += '                <div><a href="https://map.kakao.com/link/map/' + sessionStorage.getItem('id') + '" target="_blank" class="link">바로가기</a></div>\n';
    		    }else{
    		        contents += '                <div><div class="phone">' + sessionStorage.getItem('phone') + '</div><a href="https://map.kakao.com/link/map/' + sessionStorage.getItem('id') + '" target="_blank" class="link">바로가기</a></div>\n';
    		    }
    		    contents += '            </div>\n';
    		    contents += '        </div>\n';
    		    contents += '    </div>\n';
    		    contents += '</div>\n';

    		    overlay = new kakao.maps.CustomOverlay({
    		        content: contents,
    		        map: map,
    		        position: marker.getPosition()
    		    });

    		    kakao.maps.event.addListener(marker, 'click', function() {
    		        overlay.setMap(map);
    		    });

    		    setTimeout(function(){
    		        map.relayout();
    		        map.setCenter(moveLatLon);
    		    }, 500);
    		}

    		function closeOverlay() {
    		    overlay.setMap(null);
    		}
    		
    		$(document).on('click', '#modalBtn', function(e){
    		    var lat = $(this).data('lat');
    		    var lng = $(this).data('lng');
    		    var id = $(this).parent().data('value');
    		    var title = $(this).siblings('.card-title').text();
    		    var phone = $(this).siblings('.phone').text();
    		    var road_adres = $(this).parent().find('.road-adres').text();
    		    var adres = $(this).parent().find('.adres').text();

    		    sessionStorage.clear();
    		    sessionStorage.setItem("id", id);
    		    sessionStorage.setItem("title", title);
    		    sessionStorage.setItem("phone", phone);
    		    sessionStorage.setItem("road_adres", road_adres);
    		    sessionStorage.setItem("adres", adres);

    		    loadMap(lat, lng);
    		});
    		
    		var container = document.getElementById('map');
    		var options = {
    		    center: new kakao.maps.LatLng(0, 0),
    		    level: 3
    		};
    		
    		var map = new kakao.maps.Map(container, options);
    		var overlay;

    		var place = {

    		    // 검색 함수
    		    search : function() {
    		        $('#pagination').twbsPagination('destroy');

    		        var frm = document.searchForm;
    		        if(trim(frm.keywordNm.value) == ''){
    		            alert("검색어를 입력해 주세요");
    		            frm.keywordNm.focus();
    		            return false;
    		        }

    		        frm.currentPage.value = 1;
    		        frm.searchType.value = 'search';

    		        var url = '/team_project2/decide/place.com';
    		        var data = $("form[name=searchForm]").serialize();

    		        $.ajax({
    		            type: "GET",
    		            url: url,
    		            data: data,
    		            dataType: 'JSON',
    		            success: function (res) {
    		                place.makeList(res);
    		            }
    		        });
    		    },

    		    // 리스트 및 페이징 함수
    		    list : function() {
    		        var frm = document.searchForm;
    		        frm.searchType.value = 'list';

    		        var url = '/team_project2/decide/place.com';
    		        var data = $("form[name=searchForm]").serialize();

    		        $.ajax({
    		            type: "GET",
    		            url: url,
    		            data: data,
    		            dataType: 'JSON',
    		            success: function (res) {
    		                place.makeList(res);
    		            }
    		        });
    		    },

    		    // 리스트를 만들어주는 함수
    		    makeList : function(data) {
    		        $('#place_list').empty();

    		        var frm = document.searchForm;
    		        var list = data.documents;
    		        var totalCount = data.meta.pageable_count;

    		        if(list.length > 0){
    		            var contents = '';

    		            list.forEach(function(item, index, array){
    		                contents += '<div class="card">\n';
    		                contents += '   <div class="card-body" data-value="'+item.id+'">\n';
    		                contents += '       <h6 class="card-subtitle mb-2 text-muted">'+item.category_name+'</h6>\n';
    		                contents += '       <h5 class="card-title">'+item.place_name+'</h5>\n';
    		                contents += '       <h6 class="card-subtitle mb-2 text-muted phone">'+item.phone+'</h6>\n';
    		                if(trim(item.road_address_name) != ''){
    		                    contents += '       <p class="card-text"><span class="badge badge-dark">도로명</span><span class="road-adres">'+item.road_address_name+'</span></p>\n';
    		                }
    		                if(trim(item.address_name) != ''){
    		                    contents += '       <p class="card-text"><span class="badge badge-dark">지번</span><span class="adres">'+item.address_name+'</span></p>\n'
    		                }
    		                contents += '       <button type="button" id="modalBtn" class="btn btn-primary" data-toggle="modal" data-target="#mapModal" data-lng="'+item.x+'" data-lat="'+item.y+'">상세조회</button>\n';
    		                contents += '   </div>\n';
    		                contents += '</div>\n';
    		            })

    		            $('#place_list').html(contents);
    		            $("#place_list > .card").first().prop("tabindex", -1).focus();

    		            var totalPage = parseInt(totalCount / 10);

    		            if (totalCount > 10 * totalPage) {
    		                totalPage++;
    		            }

    		            $('#pagination').twbsPagination({
    		                initiateStartPageClick: false,
    		                totalPages: totalPage,
    		                visiblePages: 10,
    		                first: '<<',
    		                prev: '<',
    		                next: '>',
    		                last: '>>',

    		                onPageClick: function (event, page) {
    		                    frm.currentPage.value = page;
    		                    place.list();
    		                }
    		            });
    		        }else{
    		            var contents = '';

    		            contents += '<div class="card">\n';
    		            contents += '   <div class="card-body text-center">\n';
    		            contents += '       <h3 class="my-xl-5">검색된 결과가 없습니다.</h3>\n';
    		            contents += '   </div>\n';
    		            contents += '</div>\n';

    		            $('#place_list').html(contents);
    		        }
    		    },

    		    /* // 인기 검색어 및 히스토리 갱신 함수 (10초마다 갱신)
    		     updateData : function() {
    		        var url = '/team_project2/decide/place.com';

    		        $.ajax({
    		            type: "POST",
    		            url: url,
    		            dataType: 'JSON',
    		            timeout: 5000,
    		            beforeSend: function () {
    		            },
    		            success: function (res) {
    		                $('#keyword_list').empty();
    		                $('#history_list').empty();

    		                var historyList = res.historyList;
    		                var topKeywordList = res.topKeywordList;
    		                var contents = '';

    		                if(typeof topKeywordList != 'undefined' && topKeywordList.length > 0){
    		                    topKeywordList.forEach(function(item, index, array){
    		                        contents += '<li class="list-group-item">'+item.keywordNm+' / '+item.keywordCnt+'회</li>\n';
    		                    })
    		                }else{
    		                    contents += '<li class="list-group-item">등록된 데이터가 없습니다.</li>\n';
    		                }

    		                $('#keyword_list').html(contents);
    		                contents = '';

    		                if(typeof historyList != 'undefined' && historyList.length > 0){
    		                    historyList.forEach(function(item, index, array){
    		                        contents += '<li class="list-group-item">'+item.keywordNm+'<br>'+item.convertRegDate+'</li>\n';
    		                    })
    		                }else{
    		                    contents += '<li class="list-group-item">등록된 데이터가 없습니다.</li>\n';
    		                }

    		                $('#history_list').html(contents);
    		            },
    		            complete: setTimeout(function () {
    		                place.updateData();
    		            }, 10000)
    		        }); 
    		    } */
    		}

    		$( document ).ready(function() {
    		    place.updateData();
    		});
    </script>
</body>
<script type="text/javascript" src=//dapi.kakao.com/v2/maps/sdk.js?appkey=b912f2336605cfb19bb1b1f6eaad81f4&libraries=services"></script>
</html>