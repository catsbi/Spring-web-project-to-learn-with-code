function printPaging(pageMaker) {
	var str = "";
	if (pageMaker.prev) {
		str = +"<li><a href='" + (pageMaker.startPage - 1) + "'> << </a></li>";
	}
	for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
		var strClass = pageMaker.cri.page == i ? 'class=active' : '';
		str += "<li " + strClass + "><a href='" + i + "'>" + i + "</a></li>";
	}

	if (pageMaker.next) {
		str += "<li><a href='" + (pageMaker.endPage + 1) + "'> >> </a></li>";
	}
	$('.pagination').html(str);
}