<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form role="form" action="modifyPage" method="POST">
        <input type="hidden" name="bno" value="${boardVO.bno}">
        <input type="hidden" name="page" value="${cri.page}">
        <input type="hidden" name="perPageNum" value="${cri.perPageNum}">
        <input type="hidden" name="searchType" value="${cri.searchType}">
        <input type="hidden" name="keyword" value="${cri.keyword}">
    </form>
    <div class="box-body">
        <div class="form-group">
            <label for="exampleInputEmail1">Title</label>
            <input type="text" name="title" class="form-control" value="${boardVO.title}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="exampleInputPassword1">Writer</label>
            <textarea class="form-control" name="content" rows="3" readonly="readonly">${boardVO.content}</textarea>
        </div>
        <div class="form-group">
            <label for="exampleInputEmail1">Writer</label>
            <input type="text" name="writer" class="form-control" value="${boardVO.writer}" readonly="readonly">
        </div>
    </div>

    <!-- /box-body -->

    <div class="box-footer">
		<button type="submit" class="btn btn-warning">Modify</button>
		<button type="submit" class="btn btn-danger">REMOVE</button>
		<button type="submit" class="btn btn-primary">LIST ALL</button>
    </div>
    
    <div class="row">
		<div class="col-md-12">
			<div class="box box-success">
				<div class="box-handler">
					<h3 class="box-title">ADD NEW REPLY</h3>
				</div>
				<div class="box-body">
					<label for="newReplyWriter">Writer</label>
					<input class="form-control" type="text" placeholder="USER ID" id="newReplyWriter">
					<label for="new ReplyText">ReplyText</label>
					<input class="form-control" type="text" placeholder="REPLY TEXT" id="newReplyText">
				</div>
				<!-- box-body -->
				<div class="box-footer">
					<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD REPLY</button>
				</div>
			</div>
			
			<!-- The time line -->
			<ul class="timeline">
				<!-- timeline time label -->
				<li class="time-label" id="repliesDiv"><span class="bg-green">Replies List</span></li>
			</ul>
			
			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin"></ul>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div id="modifyModal" class="modal modal-primary fade" role="dialog">
		<div class="modal-dialog">
			<!-- Modal content -->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body" data-rno>
					<p><input type="text" id="replytext" class="form-control"></p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
					<button type="button" class="btn btn-danger" id=replyDelBtn">DELETE</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
    </div>
    
    <!-- 수정, 삭제, 목록으로 돌아가기 버튼 동작 -->
    <script>
		$(document).ready(function() {
			var formObj = $("form[role='form']");
	
			console.log(formObj);
	
			$(".btn-warning").on("click", function() {
				formObj.attr("action", "/sboard/modifyPage");
				formObj.attr("method", "get");
				formObj.submit();
			});
	
			$(".btn-danger").on("click", function() {
				formObj.attr("method", "post");
				formObj.attr("action", "/sboard/removePage");
				formObj.submit();
			});
	
			$(".btn-primary").on("click", function() {
				formObj.attr("method", "get");
				formObj.attr("action", "/sboard/list");
				formObj.submit();
			});
		});
    </script>

    <!-- Handlebars template -->
    <script id="template" type="text/x-handlebars-template">
		{{#each .}}
		<li class="replyLi" data-rno={{rno}}>
			<i class="fa fa-comments bg-blue"></i>
			<div class="timeline-item">
				<span class="time">
					<i class="fa fa-clock-o"></i>{{prettifyDate regdate}}
				</span>
				<h3 class="timeline-header"><strong>{{rno}}</strong>--{{replyer}}</h3>
				<div class="timeline-body">{{replytext}}</div>
				<div class="timeline-footer">
					<a class="btn btn-primary btn-xs" data-toggle="modal" data-target="#modifyModal">Modify</a>
				</div>
			</div>
		</li>
		{{/each}}
    </script>

    <!-- Handlebars -->
    <script>
	Handlebars.registerHelper("prettifyDate", function(timeValue){
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});
	var printData = function(replyArr, target, templateObject){
		var template = Handlebars.compile(templateObject.html());
		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);
	}
    </script>

    <!-- 페이징 댓글 함수 -->
    <script>
	var bno = ${boardVO.bno};
	var replyPage = 1;
	
	function getPage(pageInfo){
		$.getJSON(pageInfo, function(data){
			printData(data.list, $("#repliesDiv"), $("#template"));
			printPaging(data.pageMaker, $(".pagination"));
		});
	}
	
	var printPaging = function(pageMaker, target){
		var str = "";
		
		if(pageMaker.prev){
			str += "<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
		}
		
		for(var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){
			var strClass = pageMaker.cri.page == i ? 'class=active':'';
			str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
		}
		
		if(pageMaker.next){
			str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
		}
		
		target.html(str);
	}
    </script>

    <!-- 댓글 클릭하여 목록 불러오기 -->
    <script>
        $("#repliesDiv").on("click", function(){
            if($(".timeline li").size() > 1) {
                return;
            }
            getPage("/replies/" + bno + "/1");
        });
    </script>

    <!-- 댓글 페이징 처리 -->
    <script>
        $(".pagination").on("click", "li a", function(event){
            event.preventDefault();
            replyPage = $(this).attr("href");
            getPage("/replies/" + bno + "/" + replyPage);
        });
    </script>

	<!-- 댓글 등록 이벤트 -->
	<script>
		$("#replyAddBtn").on("click", function(){
			var replyObj = $("#newReplyWriter");
			var replytextObj = $("#newReplyText");
			var replyer = replyObj.val();
			var replytext = replytextObj.val();

			$.ajax({
				type: 'post',
				url: '/replies',
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST"
				},
				dataType: 'text',
				data: JSON.stringfy({bno:bno, replyer:replyer, replytext:replytext}),
				success: function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						replyPage = 1;
						getPage("/replies/" + bno + "/" + replyPage);
						replyObj.val("");
						replytextObj.val();
					}
				}
			});
		});
	</script>

	<!-- 댓글 버튼 이벤트 처리 -->
	<script>
		$(".timeline").on("click", ".replyLi", function(event){
			var reply = $(this);

			$("#replytext").val(reply.find('.timeline-body').text());
			$(".modal-title").html(reply.attr("data-rno"));
		});
    </script>
    
    	<!-- 댓글 수정 및 삭제 -->
	<script>
		$("#replyModBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();

			$.ajax({
				type: 'put',
				url: '/replies/' + rno,
				header: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "PUT"
				},
				data: JSON.stringify({replytext:replytext}),
				dataType: 'text',
				success: function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("수정 되었습니다.");
						getPage("/replies/" + bno + "/" + replyPage);
					}
				}
			});
		});

		$("#replyDelBtn").on("click", function(){
			var rno = $(".modal-title").html();
			var replytext = $("#replytext").val();

			$.ajax({
				type: 'delete',
				url: '/replies/' + rno,
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "DELETE"
				},
				dataType: 'text',
				success: function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("삭제 되었습니다.");
						getPage("replies/" + bno + "/" + replyPage);
					}
				}
			});
		});
	</script>
</body>
</html>