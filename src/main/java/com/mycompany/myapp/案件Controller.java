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

import com.mycompany.myapp.bean.案件Bean;
import com.mycompany.myapp.bean.案件検索Bean;
import com.mycompany.myapp.service.impl.案件Service;

/**
 * Handles requests for the application home page.
 */
@Controller
public class 案件Controller {

	private static final Logger logger = LoggerFactory.getLogger(案件Controller.class);

	@RequestMapping(value = "/案件", method = RequestMethod.GET)
	public String 案件(Locale locale, Model model) {
		logger.info("call 案件");

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
		model.addAttribute("モード", "0");

		return "案件検索";
	}

	@RequestMapping(value = "案件getTestData", method = RequestMethod.POST)
	@ResponseBody //将返回结果转成Json
	public List<案件Bean> 案件getTestData(@RequestBody 案件検索Bean 検索bean) {//@RequestBody 将Json转成Java对象

		logger.info("call 案件getTestData");

		案件Service 案件service = new 案件Service();

		return 案件service.検索案件_by検索Bean(検索bean);
	}

	@RequestMapping(value = "案件edit", method = RequestMethod.GET)
	public String 案件edit(案件Bean bean, Model model) {
		logger.info("call 案件edit");

		model.addAttribute("titleName", "案件編集");
		model.addAttribute("モード", "編集");
		model.addAttribute("s_ID", bean.getS_ID());
		model.addAttribute("名称", bean.get名称());
		model.addAttribute("概要", bean.get概要());
		model.addAttribute("場所", bean.get場所());
		model.addAttribute("時期", bean.get時期());
		model.addAttribute("人数", bean.get人数());

		return "案件明細";

	}

	@RequestMapping(value = "add案件", method = RequestMethod.GET)
	public ModelAndView add案件() {
		logger.info("call add案件");

		ModelAndView modelAndView1 = new ModelAndView("案件明細");
		modelAndView1.getModel().put("titleName", "案件追加");

		return modelAndView1;
	}

	@RequestMapping(value = "案件save", method = RequestMethod.POST)
	public String 案件save(@ModelAttribute("fbean") 案件Bean bean, Model model) {

		案件Service 案件service = new 案件Service();

		String sMsg = 案件service.追加案件_by案件Bean(bean);
		if (StringUtils.isEmpty(sMsg)) {
			return "案件検索";

		} else {
			model.addAttribute("titleName", "案件追加");
			model.addAttribute("s_ID", bean.getS_ID());
			model.addAttribute("名称", bean.get名称());
			model.addAttribute("概要", bean.get概要());
			model.addAttribute("時期", bean.get時期());
			model.addAttribute("場所", bean.get場所());
			model.addAttribute("人数", bean.get人数());
			return "案件明細";
		}
	}

	@RequestMapping(value = "案件update", method = RequestMethod.POST)
	public String 案件update(@ModelAttribute("fbean") 案件Bean bean, HttpSession session, Model model) {

		案件Service 案件service = new 案件Service();

		案件service.更新案件_by案件Bean(bean);
		model.addAttribute("モード", "1");

		return "案件検索";
	}

	@RequestMapping(value = "back案件検索", method = RequestMethod.POST)
	public String back案件検索() {

		return "案件検索";
	}
}
