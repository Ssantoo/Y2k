package com.world.Y2K.controller.photo;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.world.Y2K.exception.PhotoException;
import com.world.Y2K.model.dto.Member;
import com.world.Y2K.model.vo.Photo;
import com.world.Y2K.model.vo.Reply;
import com.world.Y2K.service.login.auth.UserDetailsImpl;
import com.world.Y2K.service.photo.PhotoImageStore;
import com.world.Y2K.service.photo.PhotoService;

import lombok.RequiredArgsConstructor;



@RequiredArgsConstructor
@Controller
public class PhotoController {
	
	@Autowired
	private PhotoImageStore photoImageStore; 
	
	@Autowired
	private PhotoService pService;
	
	@RequestMapping("/photo.ph")
	public String photo(Model model, Authentication authentication, HttpSession session) {
		
		UserDetailsImpl userDetails = (UserDetailsImpl)authentication.getPrincipal();
		System.out.println("user : " + userDetails.getMember());
		/* Member member = userDetails.getMember(); */
		//Long userNo = (Long) session.getAttribute("loginUser");
		
		List<Photo> images = pService.photoList();
		
		model.addAttribute("images", images);
		model.addAttribute("dto", userDetails);
	
		return "photo/photo";
	}
	
	@RequestMapping("/show.ph")
	public ModelAndView selectImg(
			HttpSession session, ModelAndView mv,
			//@RequestParam("username") String username
			@RequestParam("boardNo") Long boardNo,
			Authentication authentication
			) {
		
		UserDetailsImpl userDetails = (UserDetailsImpl)authentication.getPrincipal();
		Member member = userDetails.getMember();
		
		
		
		Photo p = pService.selectImg(boardNo);
		
		ArrayList<Reply> list =pService.selectReply(boardNo);
		
		p.setUserNo(userDetails.getMember().getUserNo());
		mv.addObject("photo", p);
		mv.addObject("member", member);
		mv.addObject("list", list);
		mv.setViewName("photo/show");
		
		return mv;
	}
	
	@RequestMapping("/upload.ph")
	public String upload() {

		return "photo/upload";
	}
	
	@RequestMapping("/image")
	public String imageUpload(@ModelAttribute Photo p,
			@RequestParam(value="file", required=false) MultipartFile file,
			HttpServletRequest request, Model model,Authentication authentication) {
		
		UserDetailsImpl userDetails = (UserDetailsImpl)authentication.getPrincipal();
		
		
		
		if(file.isEmpty()) {
			throw new PhotoException("실패");
		}
		
		
		photoImageStore.insertImage(p, file, userDetails);
		
		return "redirect:/photo.ph";
	}
	
	
	@RequestMapping("/delete.ph")
	public String deleteImage(
			@RequestParam("boardNo") Long boardNo
			) {
		
		System.out.println("result");
		
		pService.deletetImg(boardNo);
	
			return "redirect:/photo.ph";
			
		}
	
	
	
	
	@RequestMapping("/edit.ph")
	public String editFrom(
			@RequestParam("boardNo") Long boardNo,
			Model model
			) {

		Photo photo = pService.selectImg(boardNo);
		
		model.addAttribute("photo", photo);
		
		return "/photo/edit";
	}
	
	@RequestMapping("/update")
	public String updateImage(@ModelAttribute Photo p,
			@RequestParam("photoComent") String photoComent,
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request,
			Model model,
			@RequestParam("renameName") String renameName,
			@RequestParam("photoName") String photoName,
			@RequestParam("boardNo") Long boardNo
			
			) {
			
			if(file.getOriginalFilename().equals("") && p.getRenameName()==renameName ) {
				
				p.setPhotoComent(photoComent);
				p.setBoardNo(boardNo);
				pService.updateComent(p);
				
			}else {
			
				photoImageStore.updateAll(p, file, request);
			
			}

		
			return "redirect:/photo.ph";
	}

}