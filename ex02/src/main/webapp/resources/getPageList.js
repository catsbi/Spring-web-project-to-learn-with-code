function getPageList(page) {
	$.getJSON("/replies/" + bno + "/" + page, function(data) {
		console.log(data.list.length);

		var str = "";

		$(data.list).each(
				function() {
					str += "<li data-rno='" + this.rno + "' class='replyLi'>"
							+ this.rno + ":" + this.replytext
							+ "<button>MOD</button></li>";
				});
		$("#replies").html(str);

		printPaging(data.pageMaker);
	});
}