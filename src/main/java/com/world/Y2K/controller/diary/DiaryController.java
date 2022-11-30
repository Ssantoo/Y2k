package com.world.Y2K.controller.diary;


import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;
import com.world.Y2K.exception.DiaryException;
import com.world.Y2K.model.dto.Member;
import com.world.Y2K.model.vo.Diary;
import com.world.Y2K.model.vo.Reply;
import com.world.Y2K.service.diary.DiaryService;
import com.world.Y2K.service.login.auth.UserDetailsImpl;

@SessionAttributes("loginUser")
@Controller
public class DiaryController {
	
	@Autowired
	private DiaryService dService;
	
	@GetMapping("/diary.di")
	public String diary(HttpServletRequest request, Authentication authentication, Model model, @RequestParam("userNo")Long userNo) {
//		UserDetailsImpl userDetails = (UserDetailsImpl)authentication.getPrincipal();
//		Member member = userDetails.getMember();
//		HttpSession session = request.getSession();
//		session.setAttribute("loginUser", member);
		
		ArrayList<Diary> list = dService.selectDiaryList();
		model.addAttribute("userNo", userNo);
		if(list != null) {
			model.addAttribute("list", list);
			
			return "diary/diary";
		}else {
			throw new DiaryException("占쎈뼄占쎌뵠占쎈선�뵳�덌옙 鈺곌퀬�돳 占쎈뼄占쎈솭");
		}
	}
	
	@RequestMapping("/map.di")
	public String map() {
		return "diary/map";
	}
	
	@RequestMapping("/selectDiary.di")
	public ModelAndView selectDiary(@RequestParam("bId") Long bId, HttpSession session, ModelAndView mv) {
		Member member = (Member)session.getAttribute("loginUser");
		
		Long login = null;
		if(member != null) {
			login = member.getUserNo();
		}
		
		Diary d = dService.selectDiary(bId);
		ArrayList<Reply> list = dService.selectReply(bId);
		
		if(d != null) {
			mv.addObject("d", d);
			mv.addObject("list", list);
			mv.setViewName("diary/diaryDetail");
			return mv;
		}else {
			throw new DiaryException("占쎈뼄占쎌뵠占쎈선�뵳�덌옙 占쎄맒占쎄쉭癰귣떯由� 占쎈뼄占쎈솭");
		}
	}
	
	@RequestMapping("/writeDairy.di")
	public String diaryWrite(@RequestParam("datepicker") String datepicker, @RequestParam("mapValue") String mapValue, Model model,@RequestParam("userNo")Long userNo) {
		model.addAttribute("userNo", userNo);
		model.addAttribute("datepicker", datepicker);
		model.addAttribute("mapValue", mapValue);
		return "diary/writeDiary";
	}
	
	@RequestMapping("/insertDiary.di")
	public String insertDiary(@ModelAttribute Diary d, HttpServletRequest request, Model model, HttpSession session,  @RequestParam("userNo")Long userNo) {
		System.out.println(userNo);
		model.addAttribute("userNo", userNo);
		Member member = (Member)session.getAttribute("loginUser");
		System.out.println(member);
		Long diaryWriter = member.getUserNo();
		d.setDiaryWriter(diaryWriter);
		int result = dService.insertDiary(d);
		System.out.println("실행됨?");
		if(result > 0) {
			return "redirect:/diary.di";
		}else {
			throw new DiaryException("占쎈뼄占쎌뵠占쎈선�뵳�덌옙 占쎌삂占쎄쉐 占쎈뼄占쎈솭");
		}
	}
	
	@RequestMapping("/updateForm.di")
	public String updateForm(@RequestParam("boardNo") Long boardNo, Model model) {
		Diary d = dService.selectDiary(boardNo);
		model.addAttribute("d", d);
		return "diary/editDiary";
	}
	
	@RequestMapping("updateDiary.di")
	public String updateDiary(@ModelAttribute Diary d, Model model, HttpSession session) {
		int result = dService.updateDiary(d);
		
		if(result > 0) {
			model.addAttribute("bId", d.getBoardNo());
			model.addAttribute("diaryWriter", ((Member)session.getAttribute("loginUser")).getUserNo());
			return "redirect:selectDiary.di";
		}else {
			throw new DiaryException("占쎈뼄占쎌뵠占쎈선�뵳�덌옙 占쎈땾占쎌젟 占쎈뼄占쎈솭");
		}
	}
	
	@RequestMapping("/deleteDiary.di")
	public String deleteDiary(@RequestParam("boardNo") Long boardNo) {
		int result = dService.deleteDiary(boardNo);
		
		if(result > 0) {
			return "redirect:diary.di";
		}else {
			throw new DiaryException("占쎈뼄占쎌뵠占쎈선�뵳�덌옙 占쎄텣占쎌젫 占쎈뼄占쎈솭");
		}
	}
	
	@ResponseBody
	@RequestMapping("insertReply.di")
	public void insertReply(@ModelAttribute Reply r, HttpServletResponse response) {
		System.out.println(r);
		int result = dService.insertReply(r);
		ArrayList<Reply> list = dService.selectReply(r.getRboardNo());
		
		response.setContentType("application/json; charset=UTF-8");
		GsonBuilder gb = new GsonBuilder();
		GsonBuilder gb2 = gb.setDateFormat("yyyy-MM-dd");
		Gson gson = gb2.create();
		System.out.println("gson : " + gson);
		System.out.println("list : " + list);
		try {
			gson.toJson(list, response.getWriter());
		} catch (JsonIOException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping("deleteReply.di")
	public String deleteReply(@RequestParam("replyNo") Long replyNo, @RequestParam("boardNo") Long boardNo) {
		int result = dService.deleteReply(replyNo);
		
		if(result > 0) {
			return "redirect:selectDiary.di?bId=" + boardNo;
		}else {
			throw new DiaryException("占쎈솊疫뀐옙 占쎄텣占쎌젫 占쎈뼄占쎈솭");
		}
	}
	
	
}
