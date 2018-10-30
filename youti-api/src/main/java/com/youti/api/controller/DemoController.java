package com.youti.api.controller;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.youti.api.bean.DemoBean;
import com.youti.api.service.DemoService;

@RestController
@RequestMapping("/demo")
@CrossOrigin
public class DemoController {
	@Resource
    private DemoService demoService;
	
	/**
	 * 1.form表单
	 * @RequestParam("name") String name
	 * 会把传递过来的Form表单中的name对应到formData方法的name参数上
	 * 该注解不能接收json传参
	 * */
   /*@RequestMapping(value = "/test1", method = RequestMethod.POST)
    public String formData(@RequestParam("name") String name , @RequestParam("age") int age){
        String result = "receive name = "+name+" age = "+age;
        System.out.println(result);
        return result;
    }*/

	/**
	 * @GetMapping是一个组合注解，是@RequestMapping(method = RequestMethod.GET)的缩写。
	 * @PostMapping是一个组合注解，是@RequestMapping(method = RequestMethod.POST)的缩写。
	 * */
	
	@RequestMapping("/save")
	public String save() {
		DemoBean demoBean = new DemoBean();
		demoBean.setId(10);
		demoBean.setContent("rua");
		demoService.save(demoBean);
		return "save.ok";
	}
	
	/*
	 * URL
	 * **/
	//在方法上加上@ResponseBody注解，返回json格式的数据
	@RequestMapping("/getAll")
	@ResponseBody
	public Iterable<DemoBean> getAll(){
		return demoService.getAll();
	}
	
	/*
	 * 动态接收URL中的数据
	 * */
	@RequestMapping(value = "/delete/{id}")
	public String deleteById(@PathVariable int id) {
		demoService.deleteById(id);
		return "delete ok";
	}
	
	/**
	 * 4.json
	 * @RequestBody 接收Json格式的数据需要加这个注解。该注解不能接收URL、Form表单传参
	 * */
	@RequestMapping("/update")
	public String update(@RequestBody Map<String, String> data) {
		demoService.update(Integer.parseInt(data.get("id")));
		return "update ok";
	}
}