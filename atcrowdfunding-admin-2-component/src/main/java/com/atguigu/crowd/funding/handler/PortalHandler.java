package com.atguigu.crowd.funding.handler;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PortalHandler {

    @RequestMapping("/index")
    public String showIndex(){

        //从数据库加载页面要显示的数据

        return "index-page";
    }
}
