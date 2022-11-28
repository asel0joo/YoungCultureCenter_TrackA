<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    
    <!-- head & meta tag include -->
    <%@include file="/WEB-INF/views/metahead.jsp"%>
    
   	<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    
    <title>나의 문의 내역</title>
    
    <style>
      .table thead {
        background-color: #b0daeb;
      }
      .table{
        text-align: center;
      }
    </style>
    
    </head>
  <body>
      <!-- include header -->
	<%@include file="/WEB-INF/views/header.jsp"%>

    <div class="container mt-3">
    <h2>나의 문의 내역</h2>
  </div>
      <!-- 기간별 조회 박스 -->
      <form action="<c:url value='/mypage/inquiry'/>" method="get" id="frm">
	      <div class="container p-3 text-center mb-3" style="background-color: #b0daeb;">
	        <h4 class="mb-3">기간별 조회</h4>
	        <div class="row">
	          <div class="col-md-3 mb-3">
	            <button type="submit" class="btn btn-light" name="settedInterval" value="3month">3개월</button>
	            <button type="submit" class="btn btn-light" name="settedInterval" value="6month">6개월</button>
	          </div>
	          <div class="col-md-7 mb-3">
	            <div class="row">
	              <input
	              class="form-control-md col-5 fs-5"
	              type="date"
	              name="startDate"
	              id="startDate"
	            />
	            <label class="col-2 fs-4">~</label>
	            <input
	              class="form-control-md col-5 fs-5"
	              type="date"
	              name="endDate"
	              id="endDate"
	            />
	            </div>
	
	          </div>
	          <div class="col-md-2 mb-3">
	            <button type="submit" class="btn btn-primary" id="periodBtn">조회</button>
	          </div>
	        </div>

	      	${startDate != null? "조회기간 : " : ""}${startDate}${startDate != null? " ~ " : ""} 
	      	${endDate != null? endDate : ""}
	      </div>
      </form>


      <!-- 게시판 테이블 -->
      <div class="container">
      <table class="table table-hover mt-3">
      <thead>
          <tr>
            <th scope="col">분류</th>
            <th scope="col">제목</th>
            <th scope="col">작성일</th>
            <th scope="col">상태</th>
          </tr>
        </thead>
        <tbody>
      <c:forEach var ="InquiryDto" items = "${inqList }">
      	<tr>
          <td>${InquiryDto.inq_cate }</td>
          <td><a href="<c:url value="/mypage/inquiry/read?inq_id=${InquiryDto.inq_id }"/>" class="text-decoration-none">
          	${InquiryDto.inq_title }</a></td>
          <td>${InquiryDto.inq_date() }</td>
          <td>${InquiryDto.inq_yn == true? "답변완료" : "답변대기" }</td>
        </tr>
      </c:forEach>
        </tbody>
      </table>

      <button class="btn btn-primary mt-3 mb-3" onclick="location.href='./inquiry/write'">글쓰기</button>

    </div>
   		<nav aria-label="Page navigation example">
			<c:if test="${totalCnt == null || totalCnt == 0}">
				<div class="text-center mb-5">등록된 문의가 없습니다.</div>
			</c:if>
			<c:if test="${totalCnt != null && totalCnt != 0}">
				<ul class="pagination justify-content-center">
					<c:if test="${pr.showPrev }">
						<li class="page-item"><a class="page-link" href="<c:url value="/mypage/inquiry${pr.getQueryString(pr.beginPage-1) }" />"> &lt; </a></li>
					</c:if>
					<c:forEach var="i" begin="${pr.beginPage }" end="${pr.endPage }">
						<a class="page-link ${pr.page==i?'active':'' }" href="<c:url value="/mypage/inquiry${pr.getQueryString(i) }" />">${i }</a>
					</c:forEach>
					<c:if test="${pr.showNext }">
						<li class="page-item"><a class="page-link" href="<c:url value="/mypage/inquiry${pr.getQueryString(pr.endPage+1) }" />"> &raquo; </a></li>
					</c:if>
				</ul>
			</c:if>
		</nav>
  
	<!-- footer inlcude -->
<%@include file="/WEB-INF/views/footer.jsp"%>	  


	
	<script type="text/javascript">
	$(document).ready(function() {

		// 날짜 입력칸이 하나라도 비어있으면 alert창으로 모두 지정하도록 유도
	   $("#periodBtn").click(function() {
	      var sD = document.getElementById("startDate").value;
	      var eD = document.getElementById("endDate").value;
	      if(sD === "" || sD === null ||eD === "" || eD === null ){                            
	      	alert('조회 시작일과 종료일을 모두 지정해 주세요.')
	      }
	      })
	      
	      
	})
	  		let msg = "${msg}"
	  		if(msg == "WRT_OK") alert("문의가 성공적으로 등록되었습니다.")
	</script>    
	  
  </body>
</html>