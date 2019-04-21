package com.mycompany.myapp;

import java.text.DateFormat;
import java.util.ArrayList;
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

import com.mycompany.myapp.bean.社員Bean;
import com.mycompany.myapp.bean.社員検索Bean;
import com.mycompany.myapp.service.impl.社員Service;

@Controller
public class 社員Controller {

	private static final Logger logger = LoggerFactory.getLogger(社員Controller.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("モード", "0");

		return "社員検索";
	}

	@RequestMapping(value = "/社員", method = RequestMethod.GET)
	public String 社員(Locale locale, Model model) {
		logger.info("call 社員 {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate );
		model.addAttribute("モード", "0");

		return "社員検索";
	}

	/**c
	 * テストデータの配列を返却する。
	 */
	@RequestMapping(value = "getTestData", method = RequestMethod.POST)
	@ResponseBody //将返回结果转成Json
	public List<社員Bean> getTestData(@RequestBody 社員検索Bean 検索社員bean) {//@RequestBody 将Json转成Java对象

	    logger.info("call getTestData");
	    List<社員Bean> result = new ArrayList<社員Bean>();

	    社員Service 社員service = new 社員Service();

	    return 社員service.検索社員_by検索Bean(検索社員bean);

	}

	@RequestMapping(value ="社員edit", method=RequestMethod.GET)
	public String 社員edit(社員Bean bean, Model model){

		logger.info("call 社員edit");

		model.addAttribute("titleName", "社員編集");
		model.addAttribute("モード", "編集");
		model.addAttribute("s_ID", bean.getS_ID());
		model.addAttribute("番号", bean.get番号());
		model.addAttribute("姓名", bean.get姓名());
		model.addAttribute("電話番号", bean.get電話番号());
		model.addAttribute("性別", bean.get性別());
		model.addAttribute("生年月日", bean.get生年月日());
		model.addAttribute("入社年月日", bean.get入社年月日());
		model.addAttribute("契約種類", bean.get契約種類());

	    return "社員明細";

	}

    @RequestMapping(value ="社員add", method=RequestMethod.GET)
    public ModelAndView add(){

        ModelAndView modelAndView = new ModelAndView("社員明細");
        modelAndView.getModel().put("titleName", "社員追加");

        return modelAndView;
	}
    @RequestMapping(value ="社員save", method=RequestMethod.POST)
    public String save(@ModelAttribute("fbean") 社員Bean bean, Model model){

    	社員Service 社員service = new 社員Service();

    	String sMsg = 社員service.追加社員_by社員Bean(bean);
    	if (StringUtils.isEmpty(sMsg)) {
    		return "社員検索";
    	}else {
    		model.addAttribute("titleName", "社員追加");
    		model.addAttribute("s_ID", bean.getS_ID());
    		model.addAttribute("番号", bean.get番号());
    		model.addAttribute("姓名", bean.get姓名());
    		model.addAttribute("電話番号", bean.get電話番号());
    		model.addAttribute("性別", bean.get性別());
    		model.addAttribute("生年月日", bean.get生年月日());
    		model.addAttribute("入社年月日", bean.get入社年月日());
    		model.addAttribute("契約種類", bean.get契約種類());
    		model.addAttribute("errorMsg", sMsg);
    		return "社員明細";
    	}
    }

    @RequestMapping(value ="社員update", method=RequestMethod.POST)
    public String update(@ModelAttribute("fbean") 社員Bean bean, HttpSession session, Model model){

    	社員Service 社員service = new 社員Service();

    	社員service.更新社員_by社員Bean(bean);
    	model.addAttribute("モード", "1");

	    return "社員検索";
	}

    @RequestMapping(value ="社員delete", method=RequestMethod.POST)
    public String delete(@RequestBody 社員Bean bean, HttpSession session){

    	社員Service 社員service = new 社員Service();

    	社員service.削除社員_by社員Bean(bean);

	    return "社員検索";
	}


    @RequestMapping(value ="社員back", method=RequestMethod.POST)
    public String back(){

	    return "社員検索";
	}
}
