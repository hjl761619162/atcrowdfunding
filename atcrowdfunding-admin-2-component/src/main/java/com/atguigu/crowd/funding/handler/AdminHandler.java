package com.atguigu.crowd.funding.handler;

import com.atguigu.crowd.funding.entity.Admin;
import com.atguigu.crowd.funding.entity.ResultEntity;
import com.atguigu.crowd.funding.service.api.AdminService;
import com.atguigu.crowd.funding.util.CrowdFundingConstant;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class AdminHandler {

    @Autowired
    private AdminService adminService;

    @ResponseBody   //将当前handler方法的返回值作为响应体返回，不经过试图解析器
    @RequestMapping("/admin/batch/remove")  //请求映射
    private ResultEntity batchRemove(){

        return null;
    }

    @RequestMapping("/admin/query/for/search")
    public String queryForSearch(
            @RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum,
            @RequestParam(value = "pageSize",defaultValue = "5")Integer pageSize,
            @RequestParam(value = "keyword",defaultValue = "")String keyword,
            Model model){

        PageInfo<Admin> pageInfo = adminService.queryForKeywordSearch(pageNum, pageSize, keyword);
        model.addAttribute(CrowdFundingConstant.ATTR_NAME_PAGE_INFO,pageInfo);

        return "admin-page";
    }

    @RequestMapping("/admin/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/index.html";
    }

    @RequestMapping("/admin/do/login")
    public String doLogin(
            @RequestParam("loginAcct") String loginAcct,
            @RequestParam("userPswd") String  userPswd,
            Model model,
            HttpSession session){

        Admin admin = adminService.login(loginAcct,userPswd);
        //判断admin是否为null
        if(admin == null){
            model.addAttribute(CrowdFundingConstant.ATTR_NAME_MESSAGE, CrowdFundingConstant.MESSAGE_LOGIN_FAILED);
            return "admin-login";
        }
        session.setAttribute(CrowdFundingConstant.ATTR_NAME_LOGIN_ADMIN,admin);
        //  无法直接重定向，需要交给服务器转发  /admin/to/main/page.html是在view-controller配置
        return "redirect:/admin/to/main/page.html";
    }

    /*
     * 点击管理员登录 -> 跳转到管理员登录页面
     * 单纯的跳转页面 可以用spring-web-mvc.xml配置来实现
     *  <mvc:view-controller path="admin/to/login/page.html" view-name="admin-login"/>
     * */
    /*@
        RequestMapping("admin/to/login/page")
        public String toLoginPage(){
            return "admin-login";
    }*/

    @RequestMapping("/admin/get/all")
    public String getAll(Model model){

        List<Admin> list = adminService.getAll();

        model.addAttribute("list",list);

        return "admin-target";
    }

}
