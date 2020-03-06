var bno = 2;
var replyPage = 1;
getPageList(1);

$(".pagination").on("click", "li a", function(event) {
	event.preventDefault();
	replyPage = $(this).attr("href");
	getPageList(replyPage);
});

$("#replyAddBtn").on("click", function() {
	var replyer = $("#newReplyWriter").val();
	var replytext = $("#newReplyText").val();

	$.ajax({
		type : 'post',
		url : '/replies',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : 'text',
		data : JSON.stringify({
			bno : bno,
			replyer : replyer,
			replytext : replytext
		}),
		success : function(result) {
			if (result == 'SUCCESS') {
				alert("등록 되었습니다.");
				getAllList();
			}
		}
	});
});

$("#replies").on("click", ".replyLi button", function() {
	var reply = $(this).parent();
	var rno = reply.attr("data-rno");
	var replytext = reply.text();

	$(".modal-title").html(rno);
	$("#replytext").val(replytext);
	$("#modDiv").show("slow");
});

$("#replyDelBtn").on("click", function() {
	var rno = $(".modal-title").html();
	var replytext = $("replytext").val();

	$.ajax({
		type : 'delete',
		url : '/replies/' + rno,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "DELETE"
		},
		dataType : 'text',
		success : function(result) {
			console.log("result: " + result);
			if (result == 'SUCCESS') {
				alert("삭제 되었습니다.");
				$("#modDiv").hide("slow");
				getAllList();
			}
		}
	});
});

$("#replyModBtn").on("click", function() {
	var rno = $(".modal-title").html();
	var replytext = $("#replytext").val();

	$.ajax({
		type : 'put',
		url : '/replies/' + rno,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		data : JSON.stringify({
			replytext : replytext
		}),
		dataType : 'text',
		success : function(result) {
			console.log("result: " + result);
			if (result == 'SUCCESS') {
				alert("수정 되었습니다.");
				$("#modDiv").hide("slow");
				getPageList(replyPage);
			}
		}
	});
});