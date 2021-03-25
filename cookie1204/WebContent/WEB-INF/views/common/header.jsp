<%@page import="member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
<%
	// session 객체를 통해 받아온 메세지 전달.
	String msg = (String)session.getAttribute("msg");
	//1회 사용후 폐기
	if(msg != null) session.removeAttribute("msg");
	
	// 리퀘스트 객체에 저장된 로케이션(이동주소) 전달.
	String loc = (String)request.getAttribute("loc");
	// 로그인 여부 헤더에 전달.
	Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
	
	//서버로 전송된 쿠키값 확인 (아이디 저장 버튼)
	String saveId = null;
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c : cookies){
			if("saveId".equals(c.getName())){
				saveId = c.getValue();
				break;
			}
		}
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cookie__1204</title>

<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">

<script>
<% if(msg != null) { %> alert("<%= msg %>"); <% } %>
<% if(loc != null) { %> location.href = "<%= loc %>"; <% } %>

</script>

</head>

	<body>
			<header>
				<div id="header_container">
					<div id="link">
						<div id="mainpage-logo" name="link">
							<a href="${pageContext.request.contextPath}"><img class="headerImg" src="${pageContext.request.contextPath}/images/Logo2.PNG" alt="과자방로고?" /></a>
						</div>
						<div id="mainpage-insta" name="link">
							<a href="https://www.instagram.com/cookie__room1204/?hl=ko" target="_blank"><img class="headerImg" src="${pageContext.request.contextPath}/images/instagram.png" alt="인스타" /></a>
						</div>
						<div id="mainpage-blog" name="link">
							<a href="https://m.blog.naver.com/PostList.nhn?blogId=ekfud662" target="_blank"><img class="headerImg" src="${pageContext.request.contextPath}/images/blog.png" alt="블로그" /></a>								
						</div>
					</div>
					<nav>
						<ul id="main_menu">
							<li><a href="https://asrisk94.github.io/html/">HOME</a></li>
							<li><a href="${pageContext.request.contextPath}/common/profile">PROFILE</a></li>
							<li><a href="${pageContext.request.contextPath}/common/about">ABOUT</a></li>
							<li><a href="${pageContext.request.contextPath}/common/contact">오시는 길</a></li>
							<li><a href="${pageContext.request.contextPath}/product/shoppingMain">Shop</a>
								<ul id="sub_menu">
									<li><a href="${pageContext.request.contextPath}/product/dessertCategory?dessertCategory=마들렌">마들렌</a></li>
									<li><a href="${pageContext.request.contextPath}/product/dessertCategory?dessertCategory=휘낭시에">휘낭시에</a></li>
									<li><a href="${pageContext.request.contextPath}/product/dessertCategory?dessertCategory=special">스페셜</a></li>
								</ul>
							</li>
							<li><a href="${pageContext.request.contextPath}/board/noticeList">Notice</a></li>
							<li><a href="${pageContext.request.contextPath}/board/qna">QnA</a></li>
						</ul>
					</nav>
					
					<div id="login_join">
						<ul id="login_main">
							<c:if test="${memberLoggedIn == null}">
							<li><a href="${pageContext.request.contextPath}/member/login">Login</a></li>
							<li><a href="${pageContext.request.contextPath}/member/memberEnroll">Join</a></li>
							</c:if>
							<c:if test="${memberLoggedIn != null}">
							<li><a>${memberLoggedIn.memberName}님</a></li>
								<c:if test="${'N' == memberLoggedIn.isAdmin}">
								<li id="mypage_main"><a>MyPage</a>
									<ul id="mypage_sub">
										<li><a href="${pageContext.request.contextPath}/member/memberView?memberId=${memberLoggedIn.MemberId}">회원정보</a></li>
										<li><a href="${pageContext.request.contextPath}/product/basketList">장바구니</a></li>
										<li><a href="${pageContext.request.contextPath}/member/orderList">주문내역</a></li>
										<li><a href="${pageContext.request.contextPath}/member/logout">Logout</a></li>
									</ul>
								</li>
								</c:if>
								<c:if test="${'Y' == memberLoggedIn.isAdmin}">
								<li id="mypage_main"><a>AdminPage</a>
									<ul id="mypage_sub">
										<li><a href="<%= request.getContextPath() %>/admin/orderManagement">주문관리</a></li>
										<li><a href="<%= request.getContextPath() %>/admin/orderRecord">판매내역조회</a></li>
										<li><a href="<%= request.getContextPath() %>/admin/memberList">회원관리</a></li>
										<li><a href="<%= request.getContextPath() %>/member/logout">Logout</a></li>
									</ul>
								</li>
								</c:if>
							</c:if>
						</ul>
					</div>
					
<!-- 					<div id="login_join"> -->
<!-- 						<ul id="login_main"> -->
<%-- 							<% if(memberLoggedIn == null) { %> --%>
<%-- 							<li><a href="<%= request.getContextPath() %>/member/login">Login</a></li> --%>
<%-- 							<li><a href="<%= request.getContextPath() %>/member/memberEnroll">Join</a></li> --%>
<%-- 							<% } else { %> --%>
<%-- 							<li><a><%= memberLoggedIn.getMemberName() %>님</a></li> --%>
<%-- 								<% if("N".equals(memberLoggedIn.getIsAdmin())) { %> --%>
<!-- 							<li id="mypage_main"><a>MyPage</a> -->
<!-- 								<ul id="mypage_sub"> -->
<%-- 									<li><a href="<%= request.getContextPath() %>/member/memberView?memberId=<%= memberLoggedIn.getMemberId() %>">회원정보</a></li> --%>
<%-- 									<li><a href="<%= request.getContextPath() %>/product/basketList">장바구니</a></li> --%>
<%-- 									<li><a href="<%= request.getContextPath() %>/member/orderList">주문내역</a></li> --%>
<%-- 									<li><a href="<%= request.getContextPath() %>/member/logout">Logout</a></li> --%>
<!-- 								</ul> -->
<!-- 							</li> -->
<%-- 								<% } else if("Y".equals(memberLoggedIn.getIsAdmin())) { %> --%>
<!-- 							<li id="mypage_main"><a>AdminPage</a> -->
<!-- 								<ul id="mypage_sub"> -->
<%-- 									<li><a href="<%= request.getContextPath() %>/admin/orderManagement">주문관리</a></li> --%>
<%-- 									<li><a href="<%= request.getContextPath() %>/admin/orderRecord">판매내역조회</a></li> --%>
<%-- 									<li><a href="<%= request.getContextPath() %>/admin/memberList">회원관리</a></li> --%>
<%-- 									<li><a href="<%= request.getContextPath() %>/member/logout">Logout</a></li> --%>
<!-- 								</ul> -->
<!-- 							</li>	 -->
									
<%-- 								<% } %>						 --%>
<%-- 							<% } %> --%>
<!-- 						</ul> -->
<!-- 					</div> -->
					
				</div>
			</header>
			
			<section>