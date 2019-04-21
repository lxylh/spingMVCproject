package com.mycompany.myapp;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mycompany.myapp.bean.契約Bean;
import com.mycompany.myapp.bean.契約検索Bean;
import com.mycompany.myapp.service.impl.契約Service;

@Controller
public class 契约Controller {

	private static final Logger logger = LoggerFactory.getLogger(契约Controller.class);

	/**
	 * 输入一下网址，会到这里
	 * 【http://localhost:8080/JavaMiddleClassCompleteSource/契约】
	 * 第五课时会讲到这里！
	 *
	 * @param locale
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/契約", method = RequestMethod.GET)
	public String 契約(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("モード", "0");

		return "契約検索";  // 注意SPRINGMVC会自动去找 契约検索.jsp 这个文件！！！ 2019-2-10
	}


	/**
	 * 当检索按钮按下时回到这里！
	 * @param 検索契约Bean  就是将检索页面所有的信息都放到这个class里
	 * @return 契约Bean    就是将检索结果都放到这个Class里，
	 *                    注意，是List<契约Bean>结构，为什么，
	 *                    因为每个契约Bean就是一条记录
	 *                    会有多条结果，就会是List。
	 */
	@RequestMapping(value = "契約getTestData", method = RequestMethod.POST)
	@ResponseBody //将返回结果转成Json
	public List<契約Bean> 契約getTestData(@RequestBody 契約検索Bean 検索bean) {//@RequestBody 将Json转成Java对象

	    logger.info("call 契约getTestData");

	    契約Service 契約service = new 契約Service();

	    return 契約service.検索契約_by検索Bean(検索bean); // 这里可以采用先上车后买票的方法
	                                                   // 先把bean定义完之后，再实装这里。
	}

	@RequestMapping(value = "add契約", method = RequestMethod.GET)
	public ModelAndView add契約() {
		logger.info("call add契約");

		ModelAndView modelAndView1 = new ModelAndView("契約明細");
		modelAndView1.getModel().put("titleName", "契約追加");

		return modelAndView1;
	}


	@RequestMapping(value = "契約save", method = RequestMethod.POST)
	public String 契約save(@ModelAttribute("fbean") 契約Bean bean, Model model) {

		契約Service 契約service = new 契約Service();

		String sMsg = 契約service.追加契約_by契約Bean(bean);
		if (StringUtils.isEmpty(sMsg)) {
			return "契約検索";

		} else {
			model.addAttribute("titleName", "契約追加");
			model.addAttribute("契约ID", bean.get契约ID());
			model.addAttribute("单价", bean.get单价());
			model.addAttribute("开始日期", bean.get开始日期());
			model.addAttribute("契约期", bean.get契约期());
			model.addAttribute("契约期单位", bean.get契约期单位());
			model.addAttribute("契约种别", bean.get契约种别());
			model.addAttribute("结算币种", bean.get结算币种());
			model.addAttribute("契约实际终了日", bean.get契约实际终了日());
			model.addAttribute("契约CD", bean.get契约CD());
			model.addAttribute("含交通费", bean.get含交通费());
			model.addAttribute("备考说明", bean.get备考说明());
			model.addAttribute("甲方契约者ID", bean.get甲方契约者ID());
			model.addAttribute("乙方契约者ID", bean.get乙方契约者ID());
			return "契約明細";
		}
	}

	@RequestMapping(value = "/契約edit", method = RequestMethod.GET)
	public String 契約edit(契約Bean bean, Model model) {
		logger.info("call 契約edit");

		model.addAttribute("titleName", "契約編集");
		model.addAttribute("モード", "編集");
		model.addAttribute("契约ID", bean.get契约ID());
		model.addAttribute("契约CD", bean.get契约CD());
		model.addAttribute("单价", bean.get单价());
		model.addAttribute("单价単位", bean.get单价単位());
		model.addAttribute("结算币种", bean.get结算币种());
		model.addAttribute("契约实际终了日", bean.get契约实际终了日());
		model.addAttribute("含交通费", bean.get含交通费());

		model.addAttribute("契约种别", bean.get契约种别());
		model.addAttribute("契约期", bean.get契约期());
		model.addAttribute("契约期单位", bean.get契约期单位());
		model.addAttribute("开始日期", bean.get开始日期());
		model.addAttribute("备考说明", bean.get备考说明());

		return "契約明細";
	}

	@RequestMapping(value = "契約update", method = RequestMethod.POST)
	public String 契約update(@ModelAttribute("fbean") 契約Bean bean, HttpSession session, Model model) {

		契約Service 契約service = new 契約Service();

		契約service.更新契約_by契約Bean(bean);
		model.addAttribute("モード", "1");

		return "契約検索";
	}

}
