<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Indie+Flower');
    h5{
    	font-family : 'Indie Flower';
    }
    </style>
<div class="row">		
		<div class="col-12">			 
			<nav class="navbar navbar-expand-sm bg-light navbar-dark">
				<!-- Brand/logo -->
				<a class="navbar-brand" href="#">
					<img src="http://www.ikosmo.co.kr/images/common/logo_center_v2.jpg" style="width:150px;">
				</a>
				 
				<!-- Links -->
				<ul class="navbar-nav">
					<li class="nav-item">
						<a class="nav-link text-dark" href="../08Board2/BoardList.jsp?bname=freeboard">자유게시판</a>
					</li>
					<li class="nav-item">
						<a class="nav-link text-dark" href="../08Board2/BoardList.jsp?bname=notice">공지사항</a>
					</li>
					<li class="nav-item">
						<a class="nav-link text-dark" href="../08Board2/BoardList.jsp?bname=qna">질문과 답변</a>
					</li>
					<li class="nav-item">
						<a class="nav-link text-dark" href="../08Board2/BoardList.jsp?bname=faq">FAQ</a>
					</li>
				</ul>

				</form> -->
					<% if(session.getAttribute("USER_ID")!=null){ %>
					<h5 class="ml-4"> 환영합니다 "<%=session.getAttribute("USER_NAME") %>" 님 :)</h4>
					<% } %>    
				<ul class="navbar-nav ml-auto" >
				<% if(session.getAttribute("USER_ID")==null){ %>
					<li class="nav-item"><!-- 회원가입 -->
						<a class="nav-link text-dark" href="#"><i class='fas fa-edit' style='font-size:20px'></i>회원가입</a>
					</li>
					<li class="nav-item"><!-- 로그인 -->
						<a class="nav-link text-dark" href="../06Session/Login.jsp"><i class='fas fa-sign-in-alt' style='font-size:20px'></i>로그인</a>
					</li>
				<% } else { %>
					<li class="nav-item"><!-- 회원정보수정 -->
						<a class="nav-link text-dark" href="#"><i class='fa fa-cogs' style='font-size:20px'></i>회원정보수정</a>
					</li>
					<li class="nav-item"><!-- 로그아웃 -->
						<a class="nav-link text-dark" href="../06Session/Logout.jsp"><i class='fas fa-sign-out-alt' style='font-size:20px'></i>로그아웃</a>
					</li>
				<% } %>
				</ul>
			</nav>
		</div>
	</div>