<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--HTML 5対応--%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>案件明細</title>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/jquery.json.js"></script>

<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>


</head>
<body>
	<script>
	$(function() {
		$("#back_btn").click(function() {
		    $("#fbean").attr("action","http://localhost:8080/JavaMiddleClassCompleteSource/back案件検索");
		    $("#fbean").submit();
		});

		$("#save_btn").click(function() {
			if("${モード}" == "編集"){
			    $("#fbean").attr("action","http://localhost:8080/JavaMiddleClassCompleteSource/案件update");
			    $("#fbean").submit();

			}else{
			    $("#fbean").attr("action","http://localhost:8080/JavaMiddleClassCompleteSource/案件save");
			    $("#fbean").submit();
			}
		});

	});

	</script>

	<form id ="fbean" name="fbean" method="post">

	<h1>${titleName}</h1>

	<input type="hidden" value="${s_ID}" name="s_ID"/>(隐藏项目=s_ID，调试用)

	<div>
		<label>名称</label>
		<input type="text" value="${名称}" name="名称"/>
		<input type="hidden" value="${名称}" name="old_名称" />
	</div>
	<br>
	<div>
		<label>概要</label>
		<input type="text" value="${概要}" name="概要" />
		<input type="hidden" value="${概要}" name="old_概要" />
	</div>
	<br>
	<div>
		<label>場所</label>
		<input type="text" value="${場所}" name="場所" />
		<input type="hidden" value="${場所}" name="old_場所" />
	</div>
	<br>
	<div>
		<label>時期</label>
		<input type="text" value="${時期}"
			placeholder="YYYY/MM/DD"
			type="text" name="時期"/>
		<input type="hidden" value="${時期}" name="old_時期" />
	</div>
	<br>
	<div>
		<label>人数</label>
		<input type="text" Value="${人数}" name="人数"
			placeholder="例。2"
			type="text"/>
		<input type="hidden" value="${人数}" name="old_人数" />
	</div>
	<br>
	<div>
		<input type="button" id="back_btn" Value="戻る">
	</div>
	<br>

	<div>
		<input type="button" id="save_btn" Value="登録">
	</div>

	<h1>${errorMsg}</h1>
</form>
</body>
</html>
