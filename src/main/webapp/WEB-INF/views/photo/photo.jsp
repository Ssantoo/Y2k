<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }"
	scope="application" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />
<title>홈피</title>
<link rel="short icon" href="${contextPath}/resources/img/2014.ico">
<link rel="stylesheet" href="${contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/style.css" />
<link rel="stylesheet" href="${contextPath}/resources/css/photo.css" />
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

</head>
<body>

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
								<img class="profile-img"
									src="${contextPath}/resources/img/profile.jpg" alt="profile" />
								<div class="desc-wrap">
									<p class="text-desc">
										<div id="sideContentDiv" class="desc-wrap text-desc"></div>
									</p>
									
									<a class="history" href="#">HISTORY</a>
								</div>
								<div class="info-wrap">
									<a class="info-name" href="#">조현재</a>
									<p class="text-email">nowing0108@kakao.com</p>
								</div>
								<div class="profile-dropdown">
									<div class="dropdown-btn">
										<div class="dropdown-title">친구와 채팅</div>
										<div class="triangle-down"></div>
									</div>
									
									<div class="dropdown-content">
										<a href="${contextPath}/chat/chat.html">김지인</a> <a
											href="${contextPath}/chat/chat.html">박규민</a> <a
											href="${contextPath}/chat/chat.html">조소연</a> <a
											href="${contextPath}/chat/chat.html">김민주</a>
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
								<p class="title">
									<div id="mainDiv" class="title title-wrap"><a href="#">마케팅이 좋은 사람들, 마케팅월드</a></div>
								</p>
								<div class="link-wrap">
									<a href="https://www.instagram.com/hyunjong_yoo/"
										target="_blank"><span>일촌맺기</span></a> <a
										href="https://blog.naver.com/hananharu" target="_blank"><span>팬되기</span></a>
									<p>
										<a href="#">https://www.cyowrld.com/marketer_JJ</a>
									</p>
								</div>
							</div>
							<div class="main">
								<div class="tab_content" id="tab-content">
									<%-- <c:if test="${ dto.member.userNo eq image.userNo }"> --%>
									<button id="photo_upload" onclick="up();">사진올리기</button>
									<%-- </c:if> --%>
									<br>
									<br>
									<div id="tab-1-content" class="tab-content-item show">
										<!--게시물컨 그리드배열-->
										<div class="tab-1-content-inner">

											<!--${dto.member.userNo} -->
											<%-- ${dto.member} --%>
											<%-- ${images} --%>
											<input type="hidden" name="nickName"
												value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.member.nickName}">
											<c:forEach var="image" items="${images}">

												<div class="img-box">
													<img id="imgOne" class="imgOne"
														src="/upload/${image.renameName}" /> <input type="hidden"
														name="boardNo" id="boardNo" value=${image.boardNo }>
													<!--<div class="comment"></div>-->
												</div>

											</c:forEach>
											<!--아이템들end-->
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="menu align-center expanded text-center SMN_effect-68">
							<a href="${contextPath}/mainPage.ma" class="menu-item mi-1">홈</a>
						</div>
						<a href="${contextPath}/photo.ph"
							class="menu-item mi-2 menu-checked">사진첩</a>
						<div class="menu align-center expanded text-center SMN_effect-68">
							<a href="${contextPath}/diary.di" class="menu-item mi-3">다이어리</a>
							<a href="${contextPath}/visitBoard.vi" class="menu-item mi-4">방명록</a>
							<a href="#" class="menu-item mi-5">마케팅</a>
						</div>
					</div>
				</div>
			</section>

		</main>
	</div>






	<script src="${contextPath}/resources/js/photo.js"></script>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>

<script>
	$(document).ready(function(){
		let skinPath = "";
		let mainTitle = "";
		let profilePath = "";
		let sideContent = "";
		let myUserNo = "";
/* 		let sideContentDiv = $("#sideContentDiv").html(); */
		
		
		
		
		if("${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.member.userNo}" != 64){
			myUserNo = 64;
		} else {
			myUserNo = "${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal.member.userNo}";
		}
		
		let params={
				userNo : myUserNo
		}
		
		$.ajax({
			type:"GET",
			url:"/onload.my",
			data : params,
			success:function(res){
				skinPath = res.skinPath;
				mainTitle = res.mainTitle;
				profilePath = res.profilePath;
				sideContent = res.sideContent;
				document.getElementById('sideContentDiv').innerHTML = sideContent;
				document.getElementById('mainDiv').innerHTML = mainTitle;
				
				$(".bg").css({"background":"url("+skinPath+")"}); 
				
				console.log(skinPath);
				console.log(mainTitle);
				console.log(profilePath);
				console.log(sideContent);
			}
		})
		
		
		/* let myUserNo = "${my_rayout.myUserNo}";
		let skinPath = "${my_rayout.skinPath}";
		console.log("userNo : " + myUserNo);
		console.log("skinPath : " + skinPath);
		
		console.log("${my_rayout}");
		console.log("${my_rayout.myUserNo}");
		console.log("${my_rayout.skinPath}");
		console.log("${my_rayout.mainTitle}");
		console.log("${my_rayout.sideContent}"); */
		
		
		
		
	});
	
</script>

</html>
