package com.mycompany.myapp.service.impl;

import java.io.IOException;
import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.util.ObjectUtils;

import com.mycompany.myapp.bean.案件Bean;
import com.mycompany.myapp.bean.案件検索Bean;
import com.mycompany.myapp.service.文件db;
import com.mycompany.myapp.service.親Service;

public class 案件Service extends 親Service{
	// "名称" 必须放在0号位，否则全件检索时会出问题
	String[] fileName = { "名称", "場所", "時期", "人数", "概要" };

	文件db file_db = new 文件db("案件");

	public List<案件Bean> 検索案件_by検索Bean(案件検索Bean bean) {

		file_db.情報読み込み(fileName);

		Map<String,List<String>> 中間結果IDList = get中間結果_by案件検索Bean(bean);

		List<String> 最終結果IDList = get最終結果_by中間結果(中間結果IDList);

		return 取得検索結果_by最終結果(最終結果IDList);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private List<案件Bean> 取得検索結果_by最終結果(List<String> 最終結果idList) {

		List<案件Bean> 案件BeanList = new ArrayList();

		for (String 案件id : 最終結果idList) {

			案件BeanList.add(取得案件情報_by案件id(案件id));
		}

		return 案件BeanList;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private 案件Bean 取得案件情報_by案件id(String 案件id) {

		Map<String, Map> 大Map = file_db.getMap_data();

		案件Bean 案件bean = new 案件Bean();

		案件bean.setS_ID(案件id);

		for (Map.Entry<String, Map> entry : 大Map.entrySet()) {

			if (entry == null) {

				continue;

			}

			Map<String, String> 小Map;

			String 小Map名 = entry.getKey();

			switch (小Map名) {

			case "名称":
				小Map = entry.getValue();
				案件bean.set名称(小Map.get(案件id));
				break;
			case "概要":
				小Map = entry.getValue();
				案件bean.set概要(小Map.get(案件id));
				break;
			case "時期":
				小Map = entry.getValue();
				案件bean.set時期(小Map.get(案件id));
				break;
			case "場所":
				小Map = entry.getValue();
				案件bean.set場所(小Map.get(案件id));
				break;
			case "人数":
				小Map = entry.getValue();
				案件bean.set人数(小Map.get(案件id));
				break;
			}
		}
		return 案件bean;
	}



	@SuppressWarnings({ "unchecked", "rawtypes" })
	private Map<String,List<String>> get中間結果_by案件検索Bean(案件検索Bean bean) {

		Map<String,List<String>> 中間結果list = new LinkedHashMap();
		if (StringUtils.isNotEmpty(bean.getS_ID())) {

			/*IDList_name = getIDList_byNameandValue("姓名", "Aさん");*/
			中間結果list.put("ID",Arrays.asList(bean.getS_ID()));
		}

		if (StringUtils.isNotEmpty(bean.get名称())) {

			//IDList_name = getIDList_byNameandValue("概要", "Aさん");
			中間結果list.put("名称",getIDList_by小Map名andValue("名称", bean.get名称(), "=="));

		}
		Object getIDList_byNameandValue;
		if (StringUtils.isNotEmpty(bean.get概要())) {

			//IDList_name = getIDList_byNameandValue("概要", "Aさん");
			中間結果list.put("概要",getIDList_by小Map名andValue("概要", bean.get概要(), "like"));

		}

		if (StringUtils.isNotEmpty(bean.get時期終了())) {

			中間結果list.put("時期",getIDList_by小Map名andValue("時期", bean.get時期開始(), ">="));

		}

		if (StringUtils.isNotEmpty(bean.get時期終了())) {

			中間結果list.put("時期",getIDList_by小Map名andValue("時期", bean.get時期終了(), "<="));

		}

		if (StringUtils.isNotEmpty(bean.get場所())) {

			中間結果list.put("場所",getIDList_by小Map名andValue("場所", bean.get場所(), ""));
		}


		if (StringUtils.isNotEmpty(bean.get最少人数())) {

			中間結果list.put("開始入社月日",getIDList_by小Map名andValue("人数", bean.get最少人数(), ">="));
		}

		if (StringUtils.isNotEmpty(bean.get最大人数())) {

			中間結果list.put("終了入社月日",getIDList_by小Map名andValue("人数", bean.get最大人数(), "<="));
		}
		/*
		if (StringUtils.isNotEmpty(bean.get契約種類())) {

			中間結果list.put("契約種類",getIDList_by小Map名andValue("契約種類", bean.get契約種類(), "=="));
		}
		if (StringUtils.isNotEmpty(bean.get電話名称())) {

			中間結果list.put("電話名称",getIDList_by小Map名andValue("電話名称", bean.get電話名称(), "=="));
		}
*/

		// 无条件检索时
		if(allfieldIsNUll(bean)) {

			//中間結果list.put("名称",file_db.取得全ID_by項目名("名称"));
			中間結果list.put("ID",file_db.取得全部ID(fileName[0]));
		}

		// 削除時の対応
		中間結果list.put("削除年月日",getIDList_by小Map名andValue("削除年月日", "", "!="));

		return 中間結果list;

	}

	private List<String> getIDList_by小Map名andValue(String 小Map名, String value, String s計算方法) {

		List<String> IDList = new ArrayList();

		Map<String, Map> 大Map = file_db.getMap_data();

		Map<String, String> 小map = 大Map.get(小Map名);

		if (小map != null && !小map.isEmpty()) {
		} else {
			return null;
		}

		for (Map.Entry<String, String> entry : 小map.entrySet()) {

			String str1= entry.getValue().replace("\\", "");
			String str2= value.replace("\\", "");

			switch(s計算方法) {

			case ">=":
				if (str1.equals(str2)) {

					String id = entry.getKey();

					IDList.add(id);
				}

			case ">":

				if (NumberUtils.toInt(str1) > NumberUtils.toInt(str2)) {

					String id = entry.getKey();

					IDList.add(id);
				}

				break;

			case "<=":
				if (str1.equals(str2)) {

					String id = entry.getKey();

					IDList.add(id);
				}

			case "<":

				if (NumberUtils.toInt(str1) < NumberUtils.toInt(str2)) {

					String id = entry.getKey();

					IDList.add(id);
				}
				break;

			case "==":

				if (str1.equals(str2)) {

					String id = entry.getKey();

					IDList.add(id);
				}

				break;

			case "!=":

				if ( !str1.equals(str2)) {

					String id = entry.getKey();

					IDList.add(id);
				}

				break;

			case "like":

				if (value_like(entry.getValue(), value)) {

					String id = entry.getKey();

					IDList.add(id);
				}
			}


		}

		return IDList;
	}

	private boolean value_like(String str1, String str2) {
		// java 两个字符串取交集
        HashSet<String> result = new HashSet<String>();
        int length1 = str1.length();
        int length2 = str2.length();
        for (int i = 0; i < length1; i++) {
            for (int j = 0; j < length2; j++) {
                String char1 = str1.charAt(i) + "";
                String char2 = str2.charAt(j) + "";
                if (char1.equals(char2))
                {
                    result.add(char1);
                }
            }
        }

        return result.isEmpty()? false:true;
    }

	public String 追加案件_by案件Bean(案件Bean bean) {

		文件db file_db = new 文件db("案件");

		// ①チェック入力
		file_db.情報読み込み(fileName);

		// ②追加処理
		追加案件_byFile_db_案件Bean(file_db, bean);


		return "";
	}

	private void 追加案件_byFile_db_案件Bean(文件db file_db2, 案件Bean bean) {

		String path;
		String ID = null;
		try {
			// ①採番
			ID = file_db.採番(file_db.getSPath() + "名称" + ".txt")+1 +"";

		} catch (IOException e) {

			e.printStackTrace();
		}

		for(String s文件名 : fileName) {

			path = file_db.getSPath() +  s文件名 + ".txt";

			switch(s文件名) {

			case "名称":

				if(!StringUtils.isEmpty(bean.get名称())) {
					file_db.文件書込(path, ID + "," + bean.get名称());
				}
				break;

			case "概要":

				if(!StringUtils.isEmpty(bean.get概要())) {
					file_db.文件書込(path, ID + "," + bean.get概要());
				}
				break;

			case "人数":

				if(!StringUtils.isEmpty(bean.get人数())) {
					file_db.文件書込(path, ID + "," + bean.get人数());
				}
				break;

			case "時期":

				if(!StringUtils.isEmpty(bean.get時期())) {
					file_db.文件書込(path, ID + "," + bean.get時期());
				}
				break;

			case "場所":

				if(!StringUtils.isEmpty(bean.get場所())) {
					file_db.文件書込(path, ID + "," + bean.get場所());
				}
				break;


			}


		}
	}

	public void 更新案件_by案件Bean(案件Bean bean) {
		// 更新时
		// 将最新信息追加到指定文件
		文件db file_db = new 文件db("案件");
		//String ID = bean.getOld_名称();
		file_db.情報読み込み(fileName);
		String ID = bean.getS_ID();

		if(!StringUtils.equals(bean.getOld_人数(), bean.get人数())) {
			String path = file_db.getSPath() +  "人数.txt";
			file_db.文件書込(path, ID + "," + bean.get人数());
		}

		if(!StringUtils.equals(bean.getOld_名称(), bean.get名称())) {
			String path = file_db.getSPath() +  "契約種類.txt";
			file_db.文件書込(path, ID + "," + bean.get名称());

		}
		if(!StringUtils.equals(bean.getOld_概要(), bean.get概要())) {
			String path = file_db.getSPath() +  "概要.txt";
			file_db.文件書込(path, ID + "," + bean.get概要());

		}

		if(!StringUtils.equals(bean.getOld_時期(), bean.get時期())) {
			String path = file_db.getSPath() +  "時期.txt";
			file_db.文件書込(path, ID + "," + bean.get時期());

		}
		if(!StringUtils.equals(bean.getOld_場所(), bean.get場所())) {
			String path = file_db.getSPath() +  "場所.txt";
			file_db.文件書込(path, ID + "," + bean.get場所());
		}

	}

	public void 削除案件_by案件Bean(案件Bean bean) {
		String path = file_db.getSPath() +  "削除年月日.txt";
		//String ID = bean.getOld_名称();

		file_db.情報読み込み(fileName);
		String ID = bean.getS_ID();

		SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd");//设置日期格式
		String sDate = df.format(new Date()).toString();// new Date()为获取当前系统时间
		file_db.文件書込(path, ID + "," + sDate);

		// 1、削除时（采取逻辑删除。就是并不是真的删除了。而是做上删除的标记）
		//    追加一个叫削除时间的文件
		//    -----------内容如下-------------
		//    【采番】，【削除时间】
		//    【采番】，【削除时间】
		//    --------------------------------

		// 2、検索時 ，自动附加【无删除记录】的条件）
		//    凡是上面有记录的。
		//    都不会取得信息
	}

	public static boolean allfieldIsNUll(Object o){
	    try{
	        for(Field field:o.getClass().getDeclaredFields()){
	            field.setAccessible(true);//把私有属性公有化
	            Object object = field.get(o);
	            if(object == null){
	            	continue;
	            }
	            if(object instanceof CharSequence){
	                if(!StringUtils.isEmpty((String)object)){
	                    return false;
	                }
	            }else{
	                if(!ObjectUtils.isEmpty((Object[]) object)){
	                    return false;
	                }
	            }

	        }
	    }catch (Exception e){
	        e.printStackTrace();
	    }
	    return true;
	}
}

