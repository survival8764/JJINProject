<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html> 
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<title>Insert title here</title>


<style>
		.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
		</style>






</head>
<body>
<div class="container p-3 my-3 border">
  <h1>My First Bootstrap Page</h1>
  <p>This container has a border and some extra padding and margins.</p>
</div>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark d-flex">

  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" href="#">오시는길</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">공지사항</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="../moonboard/freeboard.do" >열린게시판</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">문의사항</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">주민장터</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">행사일정</a>
    </li>
  </ul>
  <ul class="navbar-nav ml-auto">
    <li class="nav-item2">
    	<% if(session.getAttribute("CITIZENCODE")==null){ %>
      <a class="nav-link" href="./signup.log">주민등록</a>
			<a class="nav-link" href="./login.log">로그인</a>
    </li>
    <li class="nav-item">
		<% }else{ %>
			<a class="nav-link" href="../MOONBOARD/Logout.jsp">로그아웃</a>
		<% } %>
	</li>
  </ul>
</nav>
<div class="jumbotron jumbotron-fluid">
  <div class="container">
  <% if(session.getAttribute("CITIZENCODE")==null){ %>
  <form class="form-inline" action="./loginAction.log" method="post">
  <label for="text" class="mr-sm-2">호 수 : </label>
  <input type="text" class="form-control mb-2 mr-sm-2" placeholder="숫자만 입력하세요." name="citizencode">
  <label for="pwd" class="mr-sm-2">비밀번호 : </label>
  <input type="password" class="form-control mb-2 mr-sm-2" placeholder="비밀번호를 입력하세요." name="pass">
  <div class="form-check mb-2 mr-sm-2">
    <label class="form-check-label">
      <input class="form-check-input" type="checkbox"> 아디디 저장
    </label>
  </div>
  <button type="submit" class="btn btn-primary mb-2">Submit</button>
</form>
<% } %>

<p>[열린오피스]로 검색하시오.</p>
<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" placeholder="장소를 검색하세요" id="keyword" size="15"> 
                    <button type="submit">검색하기</button> 
                </form>
            </div>
        </div>
        <hr>
       		<ul id="placesList"></ul>
        	<div id="pagination"></div>
    	</div>
	</div>



 {% comment %} <div id="map" style="width:1450px;height:700px;"></div> {% endcomment %}
        <script
            type="text/javascript"
            src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c17c4d53566bdbe486a962a86d328fd6&libraries=services"></script>
        <script>
        // 마커를 담을 배열입니다
            var markers = [];
            
            var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스

            var options = {
                //지도를 생성할 때 필요한 기본 옵션
                center: new kakao.maps.LatLng(33.450701, 126.570667), //지도의 중심좌표.
                level: 3 //지도의 레벨(확대, 축소 정도)
            };
            //지도 생성
            var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

            // 장소 검색 객체를 생성합니다
            var ps = new kakao.maps.services.Places();

             // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
            var infowindow = new kakao.maps.InfoWindow({zIndex: 1});

            
           // 키워드로 장소를 검색합니다
			searchPlaces();

			// 키워드 검색을 요청하는 함수입니다
			function searchPlaces() {

				var keyword = document.getElementById('keyword').value;

				if (!keyword.replace(/^\s+|\s+$/g, '')) {
					alert('키워드를 입력해주세요!');
					return false;
				}

				// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
				ps.keywordSearch(keyword, placesSearchCB); 
			}

            // 키워드 검색 완료 시 호출되는 콜백함수 입니다
            function placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {

                    // 정상적으로 검색이 완료됐으면
                    // 검색 목록과 마커를 표출합니다
                    displayPlaces(data);

                    // 페이지 번호를 표출합니다
                    displayPagination(pagination);

                } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

                    alert('검색 결과가 존재하지 않습니다.');
                    return;

                } else if (status === kakao.maps.services.Status.ERROR) {

                    alert('검색 결과 중 오류가 발생했습니다.');
                    return;

                }
            }

            
// 검색 결과 목록과 마커를 표출하는 함수입니다
            function displayPlaces(places) {

                var listEl = document.getElementById('placesList'), 
                menuEl = document.getElementById('menu_wrap'),
                fragment = document.createDocumentFragment(), 
                bounds = new kakao.maps.LatLngBounds(), 
                listStr = '';
                
                // 검색 결과 목록에 추가된 항목들을 제거합니다
                removeAllChildNods(listEl);

                // 지도에 표시되고 있는 마커를 제거합니다
                removeMarker();
                
                for ( var i=0; i<places.length; i++ ) {

                    // 마커를 생성하고 지도에 표시합니다
                    var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                        marker = addMarker(placePosition, i), 
                        itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

                    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                    // LatLngBounds 객체에 좌표를 추가합니다
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

                // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
                listEl.appendChild(fragment);
                menuEl.scrollTop = 0;

                // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                map.setBounds(bounds);
            }


            // 검색결과 항목을 Element로 반환하는 함수입니다
            function getListItem(index, places) {

                var el = document.createElement('li'),
                itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                            '<div class="info">' +
                            '   <h5>' + places.place_name + '</h5>';

                if (places.road_address_name) {
                    itemStr += '    <span>' + places.road_address_name + '</span>' +
                                '   <span class="jibun gray">' +  places.address_name  + '</span>';
                } else {
                    itemStr += '    <span>' +  places.address_name  + '</span>'; 
                }
                            
                itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                            '</div>';           

                el.innerHTML = itemStr;
                el.className = 'item';

                return el;
            }

            // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
            function addMarker(position, idx, title) {
                var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
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

                marker.setMap(map); // 지도 위에 마커를 표출합니다
                markers.push(marker);  // 배열에 생성된 마커를 추가합니다

                return marker;
            }

            // 지도 위에 표시되고 있는 마커를 모두 제거합니다
            function removeMarker() {
                for ( var i = 0; i < markers.length; i++ ) {
                    markers[i].setMap(null);
                }   
                markers = [];
            }

            
// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
            function displayPagination(pagination) {
                var paginationEl = document.getElementById('pagination'),
                    fragment = document.createDocumentFragment(),
                    i; 

                // 기존에 추가된 페이지번호를 삭제합니다
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

            // 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
            // 인포윈도우에 장소명을 표시합니다
            function displayInfowindow(marker, title) {
                var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

                infowindow.setContent(content);
                infowindow.open(map, marker);
            }

            // 검색결과 목록의 자식 Element를 제거하는 함수입니다
            function removeAllChildNods(el) {   
                while (el.hasChildNodes()) {
                    el.removeChild (el.lastChild);
                }
            }
        </script>




  </div>
</div>
</body>
</html>