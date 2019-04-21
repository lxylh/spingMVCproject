<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%--HTML 5対応--%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>契約明細</title>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="js/jquery.json.js"></script>

<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/jquery-ui.min.js"></script>


</head>
<body>
	<script>
	$(function() {
		$("#back_btn").click(function() {
		    $("#fbean").attr("action","http://localhost:8080/JavaMiddleClassCompleteSource/back契約検索");
		    $("#fbean").submit();
		});

		$("#save_btn").click(function() {
			if("${モード}" == "編集"){
			    $("#fbean").attr("action","http://localhost:8080/JavaMiddleClassCompleteSource/契約update");
			    $("#fbean").submit();

			}else{
			    $("#fbean").attr("action","http://localhost:8080/JavaMiddleClassCompleteSource/契約save");
			    $("#fbean").submit();
			}
		});

	});



	</script>

	<form id ="fbean" name="fbean" method="post">

	<h1>${titleName}</h1>

	<input type="hidden" value="${契约ID}" name="契约ID"/><!--(隐藏项目=契約_ID，调试用) -->

	<div>
		<label>契约CD</label>
		<input type="text" value="${契约CD}" name="契约CD"/>
		<input type="hidden" value="${契约CD}" name="old_契约CD" />
	</div>
	<br>
	<div>

		<label>单价</label>
		<input type="text" value="${单价}" name="单价"/>
		<input type="hidden" value="${单价}" name="old_单价" />
		<select id="单价単位" name="单价単位" style="width: 60px">
			<option value="" ${单价単位 == '' ? 'selected' : ''}></option>
			<option value="円" ${单价単位 == '円' ? 'selected' : ''}>円</option>
			<option value="万円" ${单价単位 == '万円' ? 'selected' : ''}>万円</option>
		</select>
		<input type="hidden" value="${单价単位}" name="old_单价単位" />
	</div>
	<br>
	<div>
		<label>结算币种</label>
		<select id="结算币种" name="结算币种" style="width: 60px">
			<option value="" ${结算币种 == '' ? 'selected' : ''}></option>
			<option value="日元" ${结算币种 == '日元' ? 'selected' : ''}>日元</option>
			<option value="美元" ${结算币种 == '美元' ? 'selected' : ''}>美元</option>
			<option value="人民币" ${结算币种 == '人民币' ? 'selected' : ''}>人民币</option>
		</select>
		<input type="hidden" value="${结算币种}" name="old_结算币种" />
	</div>
	<br>
	<div>
		<label>含交通费</label>
		<select id="含交通费" name="含交通费" style="width: 60px">
			<option value="" ${含交通费 == '' ? 'selected' : ''}></option>
			<option value="是" ${含交通费 == '是' ? 'selected' : ''}>是</option>
			<option value="否" ${含交通费 == '否' ? 'selected' : ''}>否</option>
		</select>
		<input type="hidden" value="${含交通费}" name="old_含交通费" />
	</div>
	<br>
	<div>
			<label>契约期</label>
			<input type="text" value="${契约期}" name="契约期"/>
			<input type="hidden" value="${契约期}" name="old_契约期" />
			<select id="契约期单位" name="契约期单位" style="width: 60px">
			<option value="" ${契约期单位 == '' ? 'selected' : ''}></option>
			<option value="年" ${契约期单位 == '年' ? 'selected' : ''}>年</option>
			<option value="月" ${契约期单位 == '月' ? 'selected' : ''}>月</option>
			<option value="长期有效" ${契约期单位 == '长期有效' ? 'selected' : ''}>长期有效</option>
			</select>
			<input type="hidden" value="${契约期单位}" name="old_契约期单位" />
	</div>
	<br>
	<div>
			<label>契约实际终了日</label>
			<input id="契约实际终了日" type="text" value="${契约实际终了日}" name="契约实际终了日"
					placeholder="YYYY/MM/DD" />
			<input type="hidden" value="${契约实际终了日}" name="old_契约实际终了日" />
	</div>
	<br>
		<div>
			<label>契约种别</label>
			<select id="契约种别" name="契约种别" style="width: 150px">
			<option value="" ${契约种别 == '' ? 'selected' : ''}></option>
			<option value="一般雇佣" ${契约种别 == '一般雇佣' ? 'selected' : ''}>一般雇佣</option>
			<option value="一括" ${契约种别 == '一括' ? 'selected' : ''}>一括</option>
			<option value="請負" ${契约种别 == '請負' ? 'selected' : ''}>請負</option>
			<option value="其他" ${契约种别 == '其他' ? 'selected' : ''}>其他</option>
			</select>
			<input type="hidden" value="${契约种别}" name="old_契约种别" id="old_契约种别"/>
		</div>
	<br>
		<div>
			<label>甲方</label>
			<input id="甲方契约者名" name="甲方契约者名" type="text" Value="" placeholder="例，宏扬株式会社" type="text" disabled/>
			<input type="button" id="search_btn1" Value="参照"/>
		<!--	<input id="甲方契约者ID" name="甲方契约者ID" type="hidden" Value="" /> -->
		</div>
		<br>

		<div>
			<label>乙方</label>
			<input id="乙方契约者名" name="乙方契约者名" type="text" Value="" placeholder="例，颜老师" type="text" disabled/>
			<input type="button" id="search_btn2" Value="参照"/>
		<!-- <input id="乙方契约者ID" name="乙方契约者ID" type="hidden" Value="" />  -->
		</div>
	<div>
		<input type="button" id="back_btn" Value="戻る"/>
	</div>
	<br>

	<div>
		<input type="button" id="save_btn" Value="登録"/>
	</div>

	<h1>${errorMsg}</h1>
</form>
</body>
</html>
