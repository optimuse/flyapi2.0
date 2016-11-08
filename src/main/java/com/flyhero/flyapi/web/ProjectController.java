package com.flyhero.flyapi.web;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONObject;
import com.flyhero.flyapi.entity.Project;
import com.flyhero.flyapi.entity.User;
import com.flyhero.flyapi.entity.UserProject;
import com.flyhero.flyapi.pojo.JSONResult;
import com.flyhero.flyapi.pojo.ProjectDetailpojo;
import com.flyhero.flyapi.pojo.TeamMemberPojo;
import com.flyhero.flyapi.service.ProjectService;
import com.flyhero.flyapi.service.UserProjectService;
import com.flyhero.flyapi.service.UserService;
import com.flyhero.flyapi.utils.Constant;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("project")
public class ProjectController extends BaseController{

	@Autowired
	private ProjectService projectService;
	@Autowired
	private UserProjectService userProjectService;
	@Autowired
	private UserService userService;
	
	@RequestMapping("findUserCreate.do")
	@ResponseBody
	public JSONObject findUserCreate(UserProject up){
		PageInfo<UserProject> list=userProjectService.findUserCreate(up);
		if(list != null){
			json.put("total",list.getTotal());
			json.put("rows", list.getList());
			return json;
		}
		return null;
	}
	@RequestMapping("findUserJoin.do")
	@ResponseBody
	public JSONResult findUserJoin(UserProject up){
		PageInfo<UserProject> list=userProjectService.findUserJoin(up);
		if(list != null){
			return new JSONResult(Constant.MSG_OK, Constant.CODE_200, list);
		}
		return null;
	}
	@RequestMapping("findUserProject.do")
	@ResponseBody
	public JSONResult findUserProject(Integer userId){
		List<UserProject> list=userProjectService.findUserProject(userId);
		if(list != null && !list.isEmpty()){
			return new JSONResult(Constant.MSG_OK, Constant.CODE_200, list);
		}
		return null;
	}

	@RequestMapping("addProject.do")
	@ResponseBody
	public JSONResult addProject(Project project){
		int flag=projectService.insertSelective(project);
		if(flag>0){
			UserProject record=new UserProject();
			User u=(User)session.getAttribute("user");
			if(u != null && u.getUserId() !=null){
				record.setProjectId(project.getProjectId());
				record.setUserId(u.getUserId());
				userProjectService.insertSelective(record);
				return new JSONResult(Constant.MSG_OK, Constant.CODE_200);
			}

		}
		return new JSONResult(Constant.MSG_ERROR, Constant.CODE_200);
	}
	@RequestMapping("updateProject.do")
	@ResponseBody
	public JSONObject updateProject(Project project){

		int flag=projectService.updateByPrimaryKeySelective(project);
		if(flag>0){
			json.put("msg", "success");
		}else{
			json.put("msg", "error");
		}
		return json;
	}
	@RequestMapping("addActor.do")
	@ResponseBody
	public JSONObject addActor(String userName,Integer projectId,int isEdit){
		User u1=new User();
		u1.setUserName(userName);
		User u=userService.findByUserName(u1);
		UserProject up=new UserProject();
		up.setUserId(u.getUserId());
		up.setProjectId(projectId);
		up.setIsEdit(isEdit);
		up.setCreateTime(new Timestamp(System.currentTimeMillis()));
		int flag=userProjectService.insertSelective(up);
		if(flag>0){
			json.put("msg", "success");
		}else{
			json.put("msg", "error");
		}
		return json;
	}
	
	@RequestMapping("findProjectDetail.do")
	@ResponseBody
	public JSONResult findProjectDetail(Integer upId){
		ProjectDetailpojo projectDetailpojo= projectService.findProjectDetail(upId);
		return new JSONResult(Constant.MSG_OK, Constant.CODE_200,projectDetailpojo);
	}
	
	@RequestMapping("findTeamMembers.do")
	@ResponseBody
	public JSONResult findTeamMembers(UserProject up){
		List<TeamMemberPojo>  list=userProjectService.findTeamMembers(up);
		return new JSONResult(Constant.MSG_OK, Constant.CODE_200, list);
	}
	
}