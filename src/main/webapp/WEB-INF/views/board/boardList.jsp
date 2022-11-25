<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" scope="application" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link rel="short icon" href="${contextPath}/resources/img/2014.ico"/>
    <link rel="stylesheet" href="${contextPath}/resources/css/reset.css" />
    <link rel="stylesheet" href="${contextPath}/resources/css/style.css" />
    <link rel="stylesheet" href="${contextPath}/resources/css/board.css" />
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://kit.fontawesome.com/7a738a6e1a.js" crossorigin="anonymous"></script>
	<style>body{margin:0; padding:0;} td{cursor: pointer;}</style>
</head>
<body id="b_body">
    <div class="bg">
      <main>
        <section class="pf-st">
          <div class="pf-side">
            <div class="pf-back">
              <div class="profile-wrap">
                <div class="visitor-counter">
                  <p class="today">999</p>
                  <p class="today-count">1213042</p>
                </div>
                <div class="profile">
                  <p class="todayis">
                    TODAY IS .. <i>♥</i><span> 행복</span>
                  </p>
                  <img class="profile-img" src="${contextPath}/resources/img/profile.jpg" alt="profile"/>
                  <div class="desc-wrap">
                    <p class="text-desc">
                     안녕하세요. <br> 조다롱입니다. <br> 제 미니홈피에 오신것을 환영합니다. </p>
                    <a class="history" href="#">HISTORY</a>
                  </div>
                  <div class="info-wrap">
                    <a class="info-name" href="#">Y2K</a>
                    <p class="text-email">guswhd956@naver.com</p>
                  </div>
                  <div class="profile-dropdown">
                    <div class="dropdown-btn">
                      <div class="dropdown-title">Related SNS Link</div>
                      <div class="triangle-down"></div>
                    </div>
                    <div class="dropdown-content">
                        <a href="https://bit.ly/3IUmQTC" target="_blank">Instagram</a>
                        <a href="https://bit.ly/3IWxs4u" target="_blank">FaceBook</a>
                        <a href="https://bit.ly/3IOwM0W" target="_blank">Blog</a>
                    </div>
                  </div>
                </div>
                <div class="side side1"></div>
                <div class="side side2"></div>
                <div class="side side3"></div>
                <div class="side side4"></div>
              </div>
            </div>
          </div>
        </section>
        <section class="main-section">
          <div class="main-dot">
            <div class="main-paper">
              <div class="main-wrap">
                <div class="title-wrap">
                  <p class="title"><a href="#">나의 미니홈피에 온걸 환영해 :D</a></p>
                  <div class="link-wrap">
                    <a href="https://www.instagram.com/hyunjong_yoo/" target="_blank"><span>일촌맺기</span></a>
                    <a href="https://blog.naver.com/hananharu" target="_blank"><span>팬되기</span></a>
                    <p><a href="#">https://www.cyowrld.com/marketer_JJ</a></p>
                  </div>
                </div>
	<div class="main">
	
	  <img id="cyimg" src="${contextPath}/resources/img/cyimg.png"/><br>
	  <div id="boardMain">자유게시판</div>
        <i class="fas fa-edit" onclick="location.href='${contextPath}/boardWrite.bo'"></i>
        <br>
    <table>
        <thead>
	        <tr>
	            <th>글번호</th>
	            <th>제목</th>
	            <th>작성자</th>
	            <th>작성일</th>
	            <th>조회수</th>
	    
	        </tr>
    	</thead>
        <tbody>
        	<c:forEach items="${list}" var="b">	
	        <tr>
	            <td>${b.boardNo}</td>
	            <td>${b.boardTitle}</td>
	            <td>${b.nickName}</td>
	            <td>${b.createDate}</td>
	            <td>${b.boardCount}</td>
	        </tr>
        	</c:forEach>
        </tbody>
    </table>
    <br>
        <ul>  
        <li>
        <c:url var="back" value="${loc}">
        	<c:param name="page" value="${pi.currentPage - 1}"></c:param>
        </c:url>
        <a class="way" href="${back}">◀</a>
        </li>    
        
        
         <li>
            	<c:forEach begin="${pi.startPage}" end="${pi.endPage}" var="p">
            		<c:if test="${ pi.currentPage eq p }">
						<li><a>${ p }</a></li>
					</c:if>
					<c:if test="${ pi.currentPage ne p }">
						<c:url var="goNum" value="${ loc }">
							<c:param name="page" value="${ p }"/>
						</c:url>
	            		<li class="page-item"><a class="page-link" href="${goNum}">${ p }</a></li>
					</c:if>
            	</c:forEach>
         </li>
	                      
        <li>
        <c:url var="next" value="${loc}">
        	<c:param name="page" value="${pi.currentPage + 1}"></c:param>
        </c:url>
        <a class="way" href="${next}">▶</a>
        </li>  
    </ul>
    <br>
    <div class="search-box">
        <select id="searchOption">
            <option>작성자</option>
            <option>제목</option>
            <option>내용</option>
        </select>
        <span action="." method="post">
          <input class="search-txt" type="text" placeholder="검색어를 입력해 주세요">
          <button class="search-btn" type="submit"><i class="fas fa-search"></i></button>
        </span>
    </div>
    <p class="p">Web Site Shortcuts.
        <a href="https://cyworld.com" target="_blank" id="cyLink" >See cyworld MainPage</a>.</p>
	</div>
			
	</div>
   <div class = "menu align-center expanded text-center SMN_effect-68">
           <a href="mainPage.html">   <div class="menu-item mi-1"  onclick="location.href='${contextPath}'">홈</div></a>
<!--              <a href="photo.html" class="menu-item mi-2" onclick="openPopup()">사진첩</a>-->

              <a href="photo.html" class="menu-item mi-2" >사진첩</a>
              <a href="diary.html" class="menu-item mi-3">다이어리</a>
 </div>
              <a class="menu-item mi-5 menu-checked" onclick="location.href='${contextPath}/boardList.bo'">게시판</a>
              <div class = "menu align-center expanded text-center SMN_effect-68">
                <a class="menu-item mi-4" onclick="location.href='${contextPath}/visit.vi'">방명록</a>
              </div>
              <!-- <a href="#" class="menu-item mi-5 menu-checked">마케팅</a> -->
<!--              <div class="menu-item mi-6">게시판</div>-->	
<!--              <div class="menu-item mi-7">방명록</div>-->

            </div>
          </div>
        </section>
      </main>
    </div>
	<script>
    	window.onload = () => {
    		const tbody = document.querySelector('tbody');
    		const tds = tbody.querySelectorAll('td');
    		for(const td of tds) {
    			td.addEventListener("click", function(){
    				const trTds = this.parentElement.querySelectorAll('td'); //세로 한줄 td
    				const boardNo = trTds[0].innerText;
    				const writer = trTds[2].innerText;
    				location.href='${contextPath}/selectBoard.bo?bNo=' + boardNo + '&writer=' + writer + '&page=' + ${pi.currentPage};
    			});
    		}
    	}
    </script>

</body>
</html>