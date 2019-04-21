<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--HTML 5対応--%>

<html>
<head>
<title>契約検索</title>
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

	<%--
首先引入Jquery插件库，当然这个不是必须的，但引入一个脚本库，可以为我们省却不少重复麻烦的工作。
 --%>
	<script>
		$(function() {
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
					url : "http://localhost:8080/JavaMiddleClassCompleteSource/契約getTestData",
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
					契约ID : $("#CD").val(),
					单价From : $("#单价開始").val(),
					单价To : $("#单价終了").val(),
			//		单价単位 : $("#単位").val(),
			//		结算币种 : $("#结算币种").val(),
			//		含交通费 : $("#含交通费").val(),
					开始日期From : $("#开始日期開始").val(),
					开始日期To : $("#开始日期終了").val(),
					契约期From : $("#契约期開始").val(),
					契约期To : $("#契约期价終了").val(),
			//		契约期単位 : $("#契约期単位").val(),
					契约实际終了日From : $("#契约实际終了日From").val(),
					契约实际終了日To : $("#契约实际終了日To").val(),
			//		契约种别 : $("#契约种别").val(),
					甲方契约者ID : $("#甲方").val(),
					乙方契约者ID : $("#乙方").val()
				};

				alert(JSON.stringify(JSONdata));

				$.ajax({
					type : 'POST',
					url : "http://localhost:8080/JavaMiddleClassCompleteSource/契約getTestData",
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
				columns :
				[ {
					title : "契约ID",
					field : "契约ID",
					sorter : "string",
					sorter : "boolean",
					cellClick : function(e, cell) {
					    var row = cell.getRow();
					    var data = row.getData();
						oneRowClick(data.契约ID)
					}
				},{
					title : "契约CD",
					field : "契约CD",
					sorter : "string",
					sorter : "boolean",
					cellClick : function(e, cell) {
					    var row = cell.getRow();
					    var data = row.getData();
						oneRowClick(data.契约ID)
					}
				}, {
					title : "单价",
					field : "单价",
					sorter : "string",
					//width : 200,
					sorter : "boolean"
				}, {
					title : "开始日期",
					field : "开始日期",
					sorter : "date",
					//width : 100,
					sorter : "boolean"
				}, {
					title : "契约期",
					field : "契约期",
					sorter : "date",
					sorter : "boolean"
				}, {
					title : "契约种别",
					field : "契约种别",
					sorter : "string",
					align : "left"
				},{
					title : "结算币种",
					field : "结算币种",
					sorter : "string",
					align : "left"
				},{
					title : "契约实际终了日",
					field : "契约实际终了日",
					sorter : "string",
					align : "left"
				},{
					title : "含交通费",
					field : "含交通费",
					sorter : "string",
					align : "left"
				},{
					title : "备考说明",
					field : "备考说明",
					sorter : "string",
					align : "left"
						,
						cellClick : function(e, cell) {
						    var row = cell.getRow()
						    var data = row.getData();
							oneRowDeleteClick(data.契约ID);
						}
				} ],
				rowClick : function(e, row) {
					/* alert("Row " + row.getIndex() + " Clicked!!!!"); */

				},
			});
			$("#example-table").tabulator("setData", data);
		}
		function oneRowClick(selected番号) {
			/* 			alert(selected番号);
			 alert("oneRowClick IS RUN HERE!!");
			 */
			var JSONdata = {
				契约ID : selected番号
			};

			$.ajax({
				type : 'POST',
				url : "http://localhost:8080/JavaMiddleClassCompleteSource/契約getTestData",
				dataType : "json", //dataType设置成 json，这个意思是说 ’服务器的数据返回的是json格式数据，需要帮我把数据转换成对象
				contentType : "application/json",

				data : JSON.stringify(JSONdata),
				success : function(data) {

					if(data[0]){
						$("#契约ID").val(data[0].契约ID);
						$("#契约CD").val(data[0].契约CD);
						$("#单价").val(data[0].单价);
						$("#单价単位").val(data[0].单价単位);
						$("#结算币种").val(data[0].结算币种);
						$("#契约实际终了日").val(data[0].契约实际终了日);
						$("#含交通费").val(data[0].含交通费);
						$("#契约种别").val(data[0].契约种别);
						$("#契约期").val(data[0].契约期);
						$("#契约期单位").val(data[0].契约期单位);
						$("#开始日期").val(data[0].开始日期);
						$("#备考说明").val(data[0].备考说明);//备考说明
						$("#theForm").attr("action","http://localhost:8080/JavaMiddleClassCompleteSource/契約edit");
						$("#theForm").submit();

				}else if(!obj.success){//查询失败，弹出提示信息
					 alert("検索失敗 by Yan");
				}
				},
				error : function(e) {
					alert("AJAXの編集処理はERRORがあり by Yan");
				}
			});
		}

		function oneRowDeleteClick(selected番号) {

			var JSONdata = {
					番号 : selected番号
			};

			alert(JSON.stringify(JSONdata));

			$.ajax({
				type : 'POST',
				url : "http://localhost:8080/JavaMiddleClassCompleteSource/delete",
				dataType : "json", //dataType设置成 json，这个意思是说 ’服务器的数据返回的是json格式数据，需要帮我把数据转换成对象
				contentType : "application/json",

				data : JSON.stringify(JSONdata),
				success : function(data) {

					$("#theForm").attr("action",
							"http://localhost:8080/JavaMiddleClassCompleteSource/契約getTestDataa");
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
	<form name="theForm" id="theForm" method="get"
		action="http://localhost:8080/JavaMiddleClassCompleteSource/add契約">
		<h1>契约情报检索</h1>
	<br>

		<div>
			<label>契约CD</label>
			<input id="契约CD" name="契约CD" type="text" Value="" placeholder="例，XZ000001"/>
			<input id="契约ID" name="契约ID" type="hidden" Value="" />
		</div>
	<br>

		<div>
			<label>单价</label>
				<input id="单价開始" type="text" Value=""
				placeholder="开始单价" type="text"/> ～ <input id="单价終了"
				type="text" Value="" placeholder="终了单价" type="text"/>

				<select id="单价単位" name="单价単位" style="width: 60px">
				<option value="円">円</option>
				<option value="万円">万円</option>
				</select>
			<input id="单价" name="单价" type="hidden" Value="" />
		</div>
	<br>

		<div>
				<label>结算币种</label>
				<select id="结算币种" name="结算币种" style="width: 60px">
					<option value="日元">日元</option>
					<option value="美元">美元</option>
					<option value="人民币">人民币</option>
				</select>

		</div>
	<br>

		<div>
			<label>含交通费</label> <select id="含交通费" name="含交通费" style="width: 60px">
				<option value="" selected="selected"></option>
				<option value="是">是</option>
				<option value="否">否</option>
			</select>

		</div>
	<br>

		<div>
			<label>开始日期</label> <input id="开始日期開始" type="text" Value=""
				placeholder="YYYY/MM/DD" type="text"/> ～ <input id="开始日期終了"
				type="text" Value="" placeholder="YYYY/MM/DD" type="text"/>
			<div id="caleandar"></div>
			<input id="开始日期" name="开始日期" type="hidden" Value="" />
		</div>
	<br>

		<div>
			<label>契约期</label> <input id="契约期開始" type="text" Value=""
				placeholder="例，1月" type="text"/> ～ <input id="契约期价終了"
				type="text" Value="" placeholder="例，3年" type="text"/>
				<label></label>
				<select id="契约期单位" name="契约期单位" style="width: 60px">
				<option value="年">年</option>
				<option value="月">月</option>
				<option value="长期有效">长期有效</option>
			</select>
			<input id="契约期" name="契约期" type="hidden" Value="" />
		</div>
	<br>

		<div>
			<label>契约实际终了日</label>
			<input id="契约实际開始" type="text" Value=""
					placeholder="YYYY/MM/DD" type="text"/> ～
			<input id="契约实际終了"type="text" Value=""
					placeholder="YYYY/MM/DD" type="text"/>
			<input id="契约实际终了日" name="契约实际终了日" type="hidden" Value="" />
		</div>

		<br>

		<div>
			<label>契约种别</label>
			<select id="契约种别" name="契约种别"
				style="width: 150px">
				<option value="一般雇佣">一般雇佣</option>
				<option value="一括">一括</option>
				<option value="請負">請負</option>
				<option value="正社员">正社员</option>
				<option value="契约社员">契约社员</option>
				<option value="派遣社员">派遣社员</option>
				<option value="其他">其他</option>
			</select>
		</div>
		<br>

		<div>

			<label>甲方</label> <input id="甲方" name="甲方" type="text" Value=""
			placeholder="例，宏扬株式会社" type="text" disabled/>

			<input type="button" id="search_btn1" Value="参照"/>
		<!-- 	<input id="甲方契约者ID" name="甲方契约者ID" type="hidden" Value="" /> -->
		</div>
		<br>

		<div>

			<label>乙方</label> <input id="乙方" name="乙方" type="text" Value=""
			placeholder="例，颜老师" type="text" disabled>
			<input type="button" id="search_btn2" Value="参照">
		<!-- 	<input id="乙方契约者ID" name="乙方契约者ID" type="hidden" Value="" > -->
		</div>
		<br>

		<div>
			<input type="button" id="search_btn" Value="検索"> <input
				type="submit" id="add_btn" Value="追加">
		</div>
		<br>
		<div>
			<div id="example-table"></div>
		</div>
	</form>
</body>

</html>
