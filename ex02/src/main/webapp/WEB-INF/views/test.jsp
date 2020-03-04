<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h2>Ajax Test Page</h2>

	<ul id="replies">
	</ul>

	<div>
		<div>
			REPLYER <input type='text' name='replyer' id='newReplyWriter'>
		</div>
		<div>
			REPLY TEXT <input type='text' name='replytext' id='newReplyText'>
		</div>
		<button id="replyAddBtn">ADD REPLY</button>
	</div>

	<script>
		var bno = 2;

		$.getJSON("/replies/all/" + bno, function(data) {
			var str = "";
			console.log(data.length);

			$(data).each(
					function() {
						str += "<li data-rno='" + this.rno + "' class='replyLi'>" + this.rno + ":" + this.replytext + "</li>";
					});
			$("#replies").html(str);
		});

		$("#replyAddBtn").on("click", function(){
			
			var replyer = ${"#newReplyWriter"}.val();
			var replytext = ${"#newReplyText"}.val();

			$ajax({
				type : 'post',
				url : '/replies',
				headers : {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"},
				dataType : 'text',
				data : JSON.stringify({
					bno : bno,
					replyer : replyer,
					replytext : replytext
				}),
				success : function(result){
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
					}
				}
			});
		});


		

		function getAllList(){
			$.getJSON("/replies/all/" + bno, function(data) {
				var str = "";
				console.log(data.length);
	
				$(data).each(
						function() {
							str += "<li data-rno='" + this.rno + "' class='replyLi'>" + this.rno + ":" + this.replytext + "</li>";
						});
				$("#replies").html(str);
			});
		}
	</script>
</body>
</html>