<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--HTML 5対応--%>

<html>
<head>
<title>案件検索</title>
<link rel="stylesheet" href="css/tabulator.css">
<link href="css/tabulator_midnight.min.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/jquery.json.js"></script>

<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>

<script type="text/javascript" src="js/tabulator.min.js"></script>
<script type="text/javascript" src="js/tabulator.js"></script>
</head>

<body>


	<script>
		$(function() {
			var $m = $('body');
			var alpha = $m.data('モード');
			if(alpha == '1'){
				$("#search_btn").click();
			}

			$("#response").html("Response Values");
			// Ajax通信テスト ボタンクリック
			$("#ajax_btn").click(function() {
				// outputDataを空に初期化
				//$("#output_data").text("");

				var url = $("url_post").val();
				var JSONdata = {
					name_input : $("#name_input").val(),
					maleFemale_input : $("#maleFemale_input").val(),
					birthDate_input : $("#birthDate_input").val(),
					joinDate_input : $("#joinDate_input").val()
				};

				//alert(JSON.stringify(JSONdata));

				$.ajax({
					type : "GET",
					url : "http://localhost:8080/JavaMiddleClassCompleteSource/案件getTestData",
					dataType : "json", //dataType设置成 json，这个意思是说 ’服务器的数据返回的是json格式数据，需要帮我把数据转换成对象
					data : JSON.stringify(JSONdata),
					scriptCharset : 'utf-8',
					success : function(data) {
						success(data);
					},

					error : function() {

						alert("AJAXの返す処理はERRORがあり by Yan");
					}
				});
			});

			$("#add_btn").click(function() {
				window.status = "処理中です。しばらくお待ちください。";
			});

			$("#search_btn").click(function() {
				//alert("検索 by Yan");
				//var url = $("url_post").val();
				var JSONdata = {
					名称 : $("#名称").val(),
					概要 : $("#概要").val(),
					場所 : $("#場所").val(),
					時期開始 : $("#時期開始").val(),
					時期終了 : $("#時期終了").val(),
					最少人数 : $("#最少人数").val(),
					最大人数 : $("#最大人数").val(),
				};

				//alert(JSON.stringify(JSONdata));

				$.ajax({
					type : 'POST',
					url : "http://localhost:8080/JavaMiddleClassCompleteSource/案件getTestData",
					dataType : "json", //dataType设置成 json，这个意思是说 ’服务器的数据返回的是json格式数据，需要帮我把数据转换成对象
					contentType : "application/json",

					data : JSON.stringify(JSONdata),
					success : function(data) {
						success(data);
					},
					error : function(e) {
						console.log(e);
						alert("AJAXの検索処理はERRORがあり by Yan");
					}
				});
			});

		});

		// Ajax通信成功時処理
		function success(data) {
			/* 			$("#emlist").empty();
			 buildHtmlTable(data,$("#emlist")); */
			$("#example-table").tabulator({
				height : "311px",
				layout : "fitColumns",
				placeholder : "No Data Set",

				columns : [ {
					title : "s_ID",
					field : "s_ID",
					sorter : "string",
					sorter : "boolean",
					cellClick : function(e, cell) {
						oneRowClick(cell.getValue())
					}
				},{
					title : "名称",
					field : "名称",
					sorter : "string",
					sorter : "boolean",
					cellClick : function(e, cell) {
					    var row = cell.getRow();
					    var data = row.getData();
					    oneRowClick(data.s_ID);
					}
				}, {
					title : "概要",
					field : "概要",
					sorter : "string",
					width : 200,
					sorter : "boolean"
				}, {
					title : "場所",
					field : "場所",
					sorter : "string",
					width : 200,
					sorter : "boolean"
				}, {
					title : "時期",
					field : "時期",
					sorter : "date",
					sorter : "boolean"
				}, {
					title : "人数",
					field : "人数",
					sorter : "date",
					align : "left"
					}
				],
				rowClick : function(e, row) {
					/* alert("Row " + row.getIndex() + " Clicked!!!!"); */

				},
			});
			$("#example-table").tabulator("setData", data);
		}
		function oneRowClick(selectedID) {
			/* 			alert(selected名称);
			 alert("oneRowClick IS RUN HERE!!");
			 */
			var JSONdata = {
				s_ID : selectedID
			};

			$.ajax({
				type : 'POST',
				url : "http://localhost:8080/JavaMiddleClassCompleteSource/案件getTestData",
				dataType : "json", //dataType设置成 json，这个意思是说 ’服务器的数据返回的是json格式数据，需要帮我把数据转换成对象
				contentType : "application/json",

				data : JSON.stringify(JSONdata),

				success : function(data) {
					/* 					var obj = eval("("+data+")");
					 if(obj.success==undefined){//查询成功，跳转到详情页面 */
					if(data[0]){
						$("#s_ID").val(data[0].s_ID);
						$("#名称").val(data[0].名称);
						$("#概要").val(data[0].概要);
						$("#場所").val(data[0].場所);
						$("#時期").val(data[0].時期);
						$("#人数").val(data[0].人数);

						//---------------------------------
						$("#theForm").attr("action",
								"http://localhost:8080/JavaMiddleClassCompleteSource/案件edit");
						$("#theForm").submit();
						//---------------------------------
					}else{
						alert("没有找到检索对象。");
					}

				},
				error : function(e) {
					alert("AJAXの編集処理はERRORがあり by Yan");
				}
			});
		}

		function oneRowDeleteClick(selectedID) {

			var JSONdata = {
					s_ID : selectedID
			};

			alert(JSON.stringify(JSONdata));

			$.ajax({
				type : 'POST',
				url : "http://localhost:8080/JavaMiddleClassCompleteSource/案件delete",
				dataType : "json", //dataType设置成 json，这个意思是说 ’服务器的数据返回的是json格式数据，需要帮我把数据转换成对象
				contentType : "application/json",

				data : JSON.stringify(JSONdata),
				success : function(data) {

					$("#theForm").attr("action",
							"http://localhost:8080/JavaMiddleClassCompleteSource/案件getTestData");
					$("#theForm").submit();
				},
				error : function(e) {
					alert("AJAXの削除処理はERRORがあり by Yan");
				}
			});
		}

		// Ajax通信失敗時処理
		function error(XMLHttpRequest, textStatus, errorThrown) {
			alert("error:" + XMLHttpRequest);
			alert("status:" + textStatus);
			alert("errorThrown:" + errorThrown);
		}
	</script>
	<form name="theForm" id="theForm" method="get" action="http://localhost:8080/JavaMiddleClassCompleteSource/add案件">
		<h1>案件情報</h1>
		<br>
		<div>
			<input id="s_ID" name="s_ID" type="text" Value="">(隐藏项目=s_ID，调试用)
		</div>
		<br>
		<div>
			<label>名称</label> <input id="名称" name="名称" type="text" value="">
		</div>
		<br>
		<div>
			<label>概要</label> <input id="概要" name="概要" type="text" value="">
		</div>
		<br>
		<div>
			<label>場所</label> <input id="場所" name="場所" type="text" value="">
		</div>
		<br>
		<div>
			<label>時期</label> <input id="時期" type="text" value="" placeholder="YYYY/MM/DD"> ～ <input id="時期" type="text" value="" placeholder="YYYY/MM/DD">
			<div id="caleandar"></div>
			<input id="時期" name="時期" type="hidden" value="">
		</div>
		<br>
		<div>
			<label>人数</label> <input id="人数" type="text" value="" placeholder="YYYY/MM/DD"> ～ <input id="人数" type="text" value="" placeholder="YYYY/MM/DD"> <input id="人数" name="人数" type="hidden" value="">
		</div>

			</select>
		</div>
		<br>
		<div>
			<input type="button" id="search_btn" value="検索"> <input type="submit" id="add_btn" value="追加">
		</div>
		<br>
		<div>
			<table id="emlist" style="width: 70%">
				<thead>
					<tr>
						<th></th>
					</tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
		<br>
		<div>
		    <div id="example-table"></div>
		</div>
	</form>



</body></html>