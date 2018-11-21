package com.youti.api.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.youti.api.bean.QuestionBean;
import com.youti.api.bean.QuestionTypeBean;
import com.youti.api.bean.TestPaperContainBean;
import com.youti.api.repository.TestPaperContainRepository;

@Service
public class TestPaperContainService {
	@Resource
	private TestPaperContainRepository testPaperContainRepository;
	
	/**
	 * 新增/更新 单个试卷包含
	 * @param TestPaperContainBean
	 * */
	@Transactional
	public void save(TestPaperContainBean testPaperContainBean) {
		//TODO
		testPaperContainRepository.save(testPaperContainBean);
	}
	
	/**
	 * 新增/更新 多个试卷包含
	 * @param List<TestPaperContainBean>
	 * */
	@Transactional
	public void saveAll(List<TestPaperContainBean> list) {
		//TODO
		testPaperContainRepository.saveAll(list);
	}
	
	/**
	 * 根据id删除单个试卷包含
	 * @param id
	 * */
	@Transactional
	public void deleteById(int id) {
		//TODO
		testPaperContainRepository.deleteById(id);
	}
	
	/**
	 * 删除多个试卷包含
	 * List<TestPaperContainBean>
	 * */
	@Transactional
	public void deleteAllList(List<TestPaperContainBean> list) {
		//TODO
		testPaperContainRepository.deleteInBatch(list);
	}
	
	/**
	 * 根据试题id删除试卷包含
	 * @param question_id
	 * */
	@Transactional
	public void deleteByQuestionId(int question_id) {
		//TODO
		List<TestPaperContainBean> list = new ArrayList<TestPaperContainBean>();
		Iterator<TestPaperContainBean> iterator = testPaperContainRepository.findAll().iterator();
		TestPaperContainBean temp = null;
		
		while(iterator.hasNext()) {
			temp = iterator.next();
			if(temp.getQuestion_id() == question_id) {
				list.add(temp);
			}
		}
		testPaperContainRepository.deleteInBatch(list);
	}
	
	/**
	 * 根据试卷id删除试卷包含
	 * @param test_paper_id
	 * */
	@Transactional
	public void deleteByTestPaperId(int test_paper_id) {
		//TODO
		List<TestPaperContainBean> list = new ArrayList<TestPaperContainBean>();
		Iterator<TestPaperContainBean> iterator = testPaperContainRepository.findAll().iterator();
		TestPaperContainBean temp = null;
		
		while(iterator.hasNext()) {
			temp = iterator.next();
			if(temp.getTest_paper_id() == test_paper_id) {
				list.add(temp);
			}
		}
		testPaperContainRepository.deleteInBatch(list);
	}
	
	/**
	 * 根据id修改试题id
	 * @param id,question_id
	 * */
	@Transactional
	public void updateQuestionById(int id,int question_id) {
		//TODO
		Optional<TestPaperContainBean> sessionTestPaperContain= testPaperContainRepository.findById(id);
		sessionTestPaperContain.get().setQuestion_id(question_id);
		testPaperContainRepository.save(sessionTestPaperContain.get());
	}
	
	/**
	 * 根据id修改试卷id
	 * @param id,test_paper_id
	 * */
	@Transactional
	public void updateTestPaperById(int id,int test_paper_id) {
		//TODO
		Optional<TestPaperContainBean> sessionTestPaperContain= testPaperContainRepository.findById(id);
		sessionTestPaperContain.get().setTest_paper_id(test_paper_id);
		testPaperContainRepository.save(sessionTestPaperContain.get());
	}
	
	/**
	 * 根据id修改 新设定的分值
	 * @param id,set_score
	 * */
	@Transactional
	public void updateSetScoreById(int id,int set_score) {
		//TODO
		Optional<TestPaperContainBean> sessionTestPaperContain= testPaperContainRepository.findById(id);
		sessionTestPaperContain.get().setSet_score(set_score);
		testPaperContainRepository.save(sessionTestPaperContain.get());
	}
	
	/**
	 * 根据id查找试卷包含
	 * @param id
	 * */
	@Transactional
	public TestPaperContainBean findById(int id) {
		//TODO
		return testPaperContainRepository.findById(id).get();
	}
	

	/**
	 * 查找所有试卷包含
	 * */
	@Transactional
	public List<TestPaperContainBean> findAll() {
		//TODO
		return testPaperContainRepository.findAll();
	}
	
	/**
	 * 根据试卷id查找试卷包含
	 * @param test_paper_id
	 * */
	@Transactional
	public List<TestPaperContainBean> findByTestPaperId(int test_paper_id) {
		//TODO
		List<TestPaperContainBean> list = new ArrayList<TestPaperContainBean>();
		Iterator<TestPaperContainBean> iterator = testPaperContainRepository.findAll().iterator();
		TestPaperContainBean temp = null;
		
		while(iterator.hasNext()) {
			temp = iterator.next();
			if(temp.getTest_paper_id() == test_paper_id) {
				list.add(temp);
			}
		}
		return list;
	}
	
	/**
	 * 根据试题id查找试卷包含
	 * @param question_id
	 * */
	@Transactional
	public List<TestPaperContainBean> findByQuestionId(int question_id) {
		//TODO
		List<TestPaperContainBean> list = new ArrayList<TestPaperContainBean>();
		Iterator<TestPaperContainBean> iterator = testPaperContainRepository.findAll().iterator();
		TestPaperContainBean temp = null;
		
		while(iterator.hasNext()) {
			temp = iterator.next();
			if(temp.getQuestion_id() == question_id) {
				list.add(temp);
			}
		}
		return list;
	}

}