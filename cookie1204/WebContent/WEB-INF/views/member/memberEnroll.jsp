<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous">
</script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<style>
    /* 세션 중앙정렬 */
    
    div#enroll-container {
        text-align: center;
        width: 1000px;
        margin: 0 auto;
    }
    div#enroll-container input {
    	margin:3px;
    	border:1px solid #dfdfdf;
    	height: 30px;
    	text-align: center;
    }
    div#enroll-container table {margin:0 auto; width: 900px;}
    div#enroll-container table tr {padding-top: 5px;}
    div#enroll-container table th {padding:0 10px; text-align:center; height: 30px; width: 200px;}
    div#enroll-container table td {padding:0 10px; text-align:left;}
    /* 회원가입 필수항목 표시 */
    div#enroll-container sup {
        color: red;
    }
    #member_id, #member_pw, #member_pw_checked, #member_name, #email, #mobile_number, #phone_number {
    	width: 400px;
    }
    #society_front_number {
        width: 150px;
    }
    #society_back_number {
        width: 220px;
    }
    .emailCheked-container{
        width: 400px;
        margin-left: 3px;
        padding-left: 120px;
    }
    .box-radio-input input[type="radio"]{
        display:none;
        }
    .box-radio-input input[type="radio"]:hover{
        cursor: pointer;
        opacity: 0.7;
    }

    .box-radio-input input[type="radio"] + span{
        display:inline-block;
        background:none;
        border:1px solid #dfdfdf;  
        border-radius: 5px;
        padding:0px 10px;
        text-align:center;
        height:30px;
        width: 64px;
        line-height:30px;
        font-weight:500;
        cursor:pointer;
    }
    
    .box-radio-input input[type="radio"]:checked + span{
	    border:1px solid #ce8633;
	    background:#ce8633;
	    color:#fff;
	    text-align: center;
    }

    #zip_code {
        width: 100px;
    }
    .postcodify_address, .postcodify_details {
        width: 400px;
    }
    button {
    	border:1px solid #dfdfdf;  
        border-radius: 5px;
        background: initial;
        height: 30px;
    }
    button:hover {
        cursor: pointer;
        opacity: 0.8;
    }
    button:active {
    	background: initial;
        border-radius: 5px;
        box-shadow: 1px 1px 0 rgb(0,0,0,0.5);
        position: relative;
        top:2px;
    }
    .submit, .reset {
        width: 100px;
        margin-top: 20px;
    }
    
</style>
<script>
$(function() {
	/* 폼 제출시 체크 */
	$("[name=memberEnrollFrm]").submit(function(e){
		
		//비밀번호 유효성 검사
		$("#member_pw").blur(function(){
			var $pw1 = $("#member_pw");
			var $pw2 = $("#member_pw_checked");
			
			if(/^[a-zA-Z0-9!@#$$%^&*()]{5,}/.test($pw1.val()) == false){
	        	alert("유효한 패스워드를 입력하세요.");
	        	$pw1.select();
	            return false;
	        }
		});
		
		//이름 유효성 검사
        var $member_name = $("#member_name");
        if(/^[가-힣]{2,}$/.test($member_name.val()) == false){
        	alert("이름은 한글 2글자 이상이어야 합니다.");
        	$member_name.select();
        	return false;
        }
      	//이메일 유효성 검사
        if(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i.test($email.val()) == false){
        	alert("유효한 이메일이 아닙니다.");
        	$email.select();
        	return false;
        }        
        
      	//전화번호 유효 번호로 교체하기
        var $mobile_number = $("#mobile_number");//휴대전화
        var $phone_number = $("#phone_number");//집전화
        //특수문자(복수개) 제거
        $mobile_number.val($mobile_number.val().replace(/[^0-9]/g, ""));
        $phone_number.val($phone_number.val().replace(/[^0-9]/g, ""));
        
        //연락처 유효성 검사
        if(/^01([0|1|6|7|8|9]?)([0-9]{3,4})([0-9]{4})$/.test($mobile_number.val()) == false){
        	alert("유효한 전화번호가 아닙니다.");
        	$mobile_number.select();
        	return false;
        }
        if(/(^02.{0})([0-9]{3})([0-9]{4})|$/.test($phone_number.val()) == false){
        	alert("유효한 전화번호가 아닙니다.");
        	$phone_number.select();
        	return false;
        }
      	//주소 유효성 검사
      	var $zip_code = $("#zip_code");
      	var $member_addr = $("#member_addr");
      	var $member_addr_detail = $("#member_addr_detail");
	    
        return true;
	})
	
	/**
	* 중복 검사 이후 아이디를 변경한 경우, 다시 중복검사를 해야한다.
	*/
	$("#member_id").change(function(){
		$("#idValid").val(0);
	});
	
	//실시간 처리
	//비밀번호 일치여부 검사
	$("#member_pw_checked").blur(function(){
		var $pw1 = $("#member_pw");
		var $pw2 = $("#member_pw_checked");
		
		if($pw1.val() != $pw2.val()){
			alert("비밀번호가 일치하지 않습니다.");
			$pw2.select(); //수정용 드래그 상태
		}
	});
	
      //우편주소 api팝업 띄우기
      $("#zip_code_search").postcodifyPopUp();

});


</script>
<script>
	/* //아이디 중복체크 여부 검사
	function validate(){
		if(checkedMemberId) {
			alert("아이디 중복 체크를 해주세요.");
		}
		return checkedMemberId;
	} */
	
    function checkIdDuplicate(){
        //1. 아이디 유효성 검사하기
        var $member_id = $("#member_id");
        if(/^[a-zA-Z0-9_]{4,}$/.test($member_id.val()) == false){
            alert("4글자 이상 입력해주세요.");
            $member_id.select();
            return;
        }

      	//2. 팝업을 통해 중복검사
    	//폼제출 + 팝업
    	var title = "checkIdDuplicatePopup";
    	var spec = "left=500px, top=300px, width=300px, height=200px";
    	open("", title, spec);

    	
    	var $frm = $(document.checkIdDuplicateFrm);// name값은 document에서 바로 접근가능
    	//아이디값 세팅
    	$frm.find("[name=memberId]")
    		.val($member_id.val());
    	$frm.attr("action", "<%= request.getContextPath() %>/member/checkIdDuplicate")
    		.attr("method", "POST")
    		.attr("target", title) //폼과 팝업 연결 설정
    		.submit();
    	
    }
</script>
<form name="checkIdDuplicateFrm">
    <input type="hidden" name="memberId" />
</form>
<div id="enroll-container">
    <h2>회원 가입 정보 입력</h2>
    <hr>
    <form
        name="memberEnrollFrm"
        action=""
        method="POST"
        onsubmit="return validate()">
        <table>
            <tr>
                <th>아이디<sup>*</sup></th>
                <td>
                    <input type="text" name="member_id" id="member_id" placeholder="4자 이상" required>
                    <button type="button" onclick="checkIdDuplicate();">중복확인</button>
                    <input type="hidden" id="idValid" value="0" />
                </td>
            </tr>
            <tr>
                <th>비밀번호<sup>*</sup></th>
                <td>
                    <input type="password" name="member_pw" id="member_pw" placeholder="4자 이상" required>
                </td>
            </tr>
            <tr>
                <th>비밀번호 확인<sup>*</sup></th>
                <td>
                    <input type="password" name="member_pw" id="member_pw_checked" required>
                </td>
            </tr>
            <tr>
                <th>이름<sup>*</sup></th>
                <td>
                    <input type="text" name="member_name" id="member_name" placeholder="2자 이상" required>
                </td>
            </tr>
            <tr>
                <th>주민번호<sup>*</sup></th>
                <td>
                    <input type="text" name="society_front_number" id="society_front_number" placeholder="생년월일" required maxlength="6" > -
                    <input type="password" name="society_back_number" id="society_back_number" maxlength="7" required>
                </td>
            </tr>
            <tr>
                <th>이메일&nbsp;</th>
                <td>
                    <input type="email" name="email" id="email" placeholder="abc@naver.com">
                </td>
            </tr>
            <tr>
                <th>이메일 수신 여부&nbsp;</th>
                <td class="emailCheked">
                    <div class="emailCheked-container">
                        <label class="box-radio-input" for="email_get1"><input type="radio" name="email_get" id="email_get1" value="Y"><span>예</span></label>
                        <label class="box-radio-input" for="email_get2"><input type="radio" name="email_get" id="email_get2" value="N"><span>아니오</span></label>
                    </div>
                </td>
            </tr>
            <tr>
                <th>휴대폰 번호<sup>*</sup></th>
                <td>
                    <input type="tel" name="mobile_number" id="mobile_number" placeholder="01012345678(-제외)" required>
                </td>
            </tr>
            <tr>
                <th>자택 번호&nbsp;</th>
                <td>
                    <input type="tel" name="phone_number" id="phone_number" placeholder="021234567(-제외)">
                </td>
            </tr>
            <tr>
                <th>우편 번호<sup>*</sup></th>
                <td>
                    <input type="text" name="zip_code" id="zip_code" class="postcodify_postcode5" required>
                    <button type="button" id="zip_code_search">우편번호</button>
                </td>
            </tr>
            <tr>
                <th>자택 주소<sup>*</sup></th>
                <td>
                    <input type="text" name="member_addr" id="member_addr" class="postcodify_address" required>
                </td>
            </tr>
            <tr>
                <th>상세 주소<sup>*</sup></th>
                <td>
                    <input type="text" name="member_addr_detail" id="member_addr_detail" class="postcodify_details" required>
                </td>
            </tr>
        </table>
        
        <button type="submit" class="submit">가입</button>
        <button type="reset" class="reset">취소</button>
    </form>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
