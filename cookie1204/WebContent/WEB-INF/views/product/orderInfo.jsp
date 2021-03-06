<%@page import="product.model.vo.Basket"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	List<Basket> list = (List<Basket>)request.getAttribute("list");
	int amount = 0;
	for(Basket b : list) {
		amount += b.getBasketSumMoney()*b.getBasketAmountNum();
	}
%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
<link rel="stylesheet" href="../css/10-11.css" />
<script type="text/javascript" src="../js/10-11.js"></script>  

<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
	
    <style>


        table {
            empty-cells: hide;
            position: relative;
        }
        input[type=submit] {
            width:100px; 
            height:50px; 
            color:white; 
            background:#3300ff; 
            position: relative; 
            top: 4px; 
        }
        fieldset#form-group {
            width: 500px;
            height: 450px;
          
            margin: 0 auto; 
            ont-family: 'Open Sans', sans-serif; 
            font-size: 15px; 
            font-weight: 400; 
            color: #888; 
            line-height:30px;
            text-align: center;
            justify-content : center;
            display: flex;
        }

		#postcodify_postcode5 {
			width : 110px;
		}
        
    </style>
    
	<script src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" type="text/javascript"></script>
    <script>
    
    $(function() { 
        $("#postcodify_search_button").postcodifyPopUp(); 
    });
    
    
    
        var IMP = window.IMP;
        IMP.init('imp94594446');

        function order() {

            var sumMoney = document.getElementById("sumMoney").innerText;
            console.log("sumMoney= " + sumMoney);
            var productName = document.getElementById("productName").innerText;
            var email = document.getElementById("buyer_email").value;
            var receiveName = document.getElementById("receiveName").value;
			var buyer_tel = document.getElementById("buyer_tel").value;
			var postcodify_address = document.getElementById("postcodify_address").value;
			var postcodify_details = document.getElementById("postcodify_details").value;
			
			if(postcodify_details != null) {
				postcodify_address = postcodify_address + postcodify_details;
			}
			
			var postCode = document.getElementById("postcodify_postcode5").value;
			
			
			console.log(receiveName);
			if(receiveName == "") {
				alert("?????? ?????? ????????? ???????????????.");
				return false;
			}
			if(buyer_tel == "") {
				alert("????????? ????????? ???????????????.");
				return false;
			}
			if(postcodify_address == "") {
				alert("????????? ???????????????.");
				return false;
			}
			
			
			
            /********************************************************************/
            IMP.request_pay({
                pg : 'inicis', // version 1.1.0?????? ??????.
                pay_method : 'card',
                merchant_uid : 'merchant_' + new Date().getTime(),
                name : productName,
                amount : sumMoney,
                buyer_email : email,
                buyer_name : receiveName,
                buyer_tel : buyer_tel,
                buyer_addr : postcodify_address,
                buyer_postcode : postCode
<%--                 m_redirect_url : '<%= request.getContextPath() %>/product/orderResult' --%>
            }, function(rsp) {
                if ( rsp.success ) {
                    
                    // ????????????
                    var orderTradeNum = document.getElementsByName("orderTradeNum");
                    orderTradeNum[0].value = rsp.merchant_uid;
                    
                    // ?????? ??????
                    var orderReceiveName = document.getElementsByName("orderReceiveName");
                    var order_memberName = document.getElementById("receiveName");
                    orderReceiveName[0].value = order_memberName.value;
                    
                    // ????????????
                    var orderZipCode = document.getElementsByName("orderZipCode");
                    var order_zipCode = document.getElementById("postcodify_postcode5");
                    orderZipCode[0].value = order_zipCode.value;
					
                    // ?????? ??????
                    var orderReceiveAddr = document.getElementsByName("orderReceiveAddr");
                    var order_addr = document.getElementById("postcodify_address");
                    orderReceiveAddr[0].value = order_addr.value;
                    
                    // ?????? ??????
                    var orderReceiveAddrDetail = document.getElementsByName("orderReceiveAddrDetail");
                    var order_addrDetail = document.getElementById("postcodify_details");
                    orderReceiveAddrDetail[0].value = order_addrDetail.value;
                    
                    // ???????????? (???)
                    var orderReceivePhone = document.getElementsByName("orderReceivePhone");
                    var order_phone = document.getElementById("buyer_call");
                    orderReceivePhone[0].value = order_phone.value;
                    
                    // ????????? ??????
                    var orderReceiveMobile = document.getElementsByName("orderReceiveMobile");
                    var order_mobile = document.getElementById("buyer_tel");
                    orderReceiveMobile[0].value = order_mobile.value;
                    
                    // ????????????
                    var orderMemo = document.getElementsByName("orderMemo");
                    var order_memo = document.getElementById("orderMemo");
                    orderMemo[0].value = order_memo.value;
                    
                    // ????????????
                    var orderSumMoney = document.getElementsByName("orderSumMoney");
                    orderSumMoney[0].value = <%= amount %>;
                    
                    // ?????????
                    var orderEmail = document.getElementsByName("orderEmail");
                    var order_email = document.getElementById("buyer_email");
                    orderEmail[0].value = order_email.value;
                    
                    // ?????????
                    var memberId = document.getElementsByName("memberId");
                    memberId[0].value = "<%= memberLoggedIn != null ? memberLoggedIn.getMemberId() : "" %>";
                    
                    // ?????? ????????????
                    var cardNum = document.getElementsByName("cardNum");
                    cardNum[0].value = rsp.apply_num;
                    
                    // ???????????? ??????
                 	var order_success = document.getElementById("order_success");
         			order_success.submit();
//                     msg += '??????ID : ' + rsp.imp_uid;
//                     msg += '?????? ??????ID : ' + rsp.merchant_uid;
//                     msg += '?????? ?????? : ' + rsp.paid_amount;
//                     msg += '?????? ???????????? : ' + rsp.apply_num;
                } else {
                    var msg = '????????? ?????????????????????. ';
                    msg += ' ???????????? : ' + rsp.error_msg;
                    alert(msg);
                }
            });
            /******************************************************************/
        }

    </script>	
    
    <form action="<%= request.getContextPath() %>/product/orderResult" id="order_success" method="post">
    
    	<input type="hidden" name="orderTradeNum" value="" />
    	<input type="hidden" name="orderReceiveName" value="" />
    	<input type="hidden" name="orderZipCode" value="" />
    	<input type="hidden" name="orderReceiveAddr" value="" />
    	<input type="hidden" name="orderReceiveAddrDetail" value="" />
    	<input type="hidden" name="orderReceivePhone" value="" />
    	<input type="hidden" name="orderReceiveMobile" value="" />
    	<input type="hidden" name="orderMemo" value="" />
    	<input type="hidden" name="orderSumMoney" value="" />
    	<input type="hidden" name="orderEmail" value="" />
    	<input type="hidden" name="memberId" value="" />
    	<input type="hidden" name="cardNum" value="" />
    </form>
    
	<br><br>
<form name="orderform" id="orderform" method="post" class="orderform" action="/product/basketList">
    
    <input type="hidden" name="cmd" value="order">
   	<div class="basketdiv" id="basket">
    	<div class="row head">
        	<div class="subdiv">
<!--        	<div class="check">??????</div> -->
<!--                 <div class="img">?????????</div> -->
					<div> </div>
               	<div class="dessertName"> ?????????</div>
            </div>
            <div class="subdiv">
	            <div class="basketprice">??????</div>
	            <div class="num">??????</div>
	            <div class="sum">??????</div>
            </div>
       	</div> 
			<% int idx = 0; %>
			<% for(Basket b : list) { %>
			<% idx++; %>
     		<div class="row data">
            	<div class="subdiv">
<!--                <div class="check"><input type="checkbox" name="buy" value="260" checked="">&nbsp;</div> -->
<!-- 	                <div class="img"><img src="../images/basket1.jpg" width="60"></div> -->
					<div> </div>
	                <div class="dessertName"> <%= b.getDessertName() %></div>
                </div>
                <div class="subdiv">
                	<div class=basketprice><input type="hidden" name="p_price" class="p_price" value="<%= b.getBasketSumMoney()*b.getBasketAmountNum() %>"><%= b.getBasketSumMoney() %>???</div>
                    <div class="num">
                    	<div class="updown">
                        	<div><%= b.getBasketAmountNum() %></div>
<%--                        <span onclick="javascript:basket.changePNum(<%= idx %>);"> --%>
<!--                       		<i class="fas fa-arrow-alt-circle-up up"></i> -->
<!--                        </span> -->
<%--                        <span onclick="javascript:basket.changePNum(<%= idx %>);"> --%>
<!--                        	<i class="fas fa-arrow-alt-circle-down down"></i> -->
<!--                       	</span> -->
                        </div>
                    </div>
					<div class="sum"><%= b.getBasketSumMoney() %>???</div>    
                </div>
			</div> <!-- row data -->
					
			<% } %>
	</div>         
</form>
	<br>
				<div class="bigtext right-align sumcount" id="sum_p_num">
				<% if(list.size() == 1) { %>
					<span id="productName"><%= list.get(0).getDessertName() %></span>
				<% } else { %>
					<span id="productName"><%= list.get(0).getDessertName() %> ??? <%= list.size() %>???</span>
				<% } %>
			</div>
            <div class="bigtext right-align box blue summoney" id="sum_p_price"><span id="sumMoney"><%= amount %></span><span>???</span></div>
	<br />
    <fieldset id="form-group">

<!--                 <div class="form-group"> -->
                
                
		<table id="orderInfoTable">
			<tr>
				<td>
	            	<label for="">?????? ??????:</label>
				</td>
				<td>
	            	<input type="text" id="receiveName" placeholder="?????? ??????" value="<%= memberLoggedIn.getMemberName() %>"><br />
				</td>
			</tr>
			<tr>
				<td>
	            	<label for="">????????????:</label>
	            </td>
				<td>
	            	<input type="text" id="postcodify_postcode5" class="postcodify_postcode5" value="<%= memberLoggedIn.getZipCode() != null ? memberLoggedIn.getZipCode() : "" %>" readonly />

			    	<button id="postcodify_search_button">??????</button><br />
				</td>
			</tr>              
            <tr>
            	<td>
	            	<label for="">??????:</label>
	            </td>
				<td>
	            	<input type="text" id="postcodify_address" class="postcodify_address" value="<%= memberLoggedIn.getMemberAddr() != null ? memberLoggedIn.getMemberAddr() : "" %>" readonly /><br />
				</td>
			</tr>  
           	<tr>
           		<td>
	            	<label for="">????????????:</label>
	            </td>
				<td>
	            	<input type="text" id="postcodify_details" class="postcodify_details" value="<%= memberLoggedIn.getMemberAddrDetail() != null ? memberLoggedIn.getMemberAddrDetail() : "" %>" /><br />
				</td>
			</tr>  		
         	<tr>
         		<td>
	            	<label for="">????????? ??????:</label>
            	</td>
				<td>
	           		<input type="text" placeholder="????????? ??????" id="buyer_tel" value="<%= memberLoggedIn.getMobileNum() != null ? memberLoggedIn.getMobileNum() : "" %>"><br />
				</td>
			</tr>  
            <tr>
            	<td>
	            	<label for="">??? ????????????:</label>
            	</td>
				<td>
	          		<input type="text" id="buyer_call" placeholder="??? ????????????" value="<%= memberLoggedIn.getPhoneNum() != null ? memberLoggedIn.getPhoneNum() : "" %>"><br />
				</td>
			</tr>       
          	<tr>
          		<td>
	           		<label for="">????????? :</label>
           		</td>
				<td>
	          		<input type="text" placeholder="?????????" id="buyer_email" value="<%= memberLoggedIn.getEmail() != null ? memberLoggedIn.getEmail() : "" %>"><br />
				</td>
			</tr>  
    		<tr>
    			<td>
	            	<label for="">?????? ??????:</label>
            	</td>
				<td>
	          		<textarea name="" id="orderMemo" cols="30" rows="10" placeholder=""></textarea>
    			</td>
    		</tr>
           	<tr>
           		<td colspan="2">
          			   <input type="button" value="??????" onclick="order();">           		
           		</td>
           	</tr>
		</table>
        
    </fieldset>
    
			<br>
    
<%@ include file="/WEB-INF/views/common/footer.jsp" %>