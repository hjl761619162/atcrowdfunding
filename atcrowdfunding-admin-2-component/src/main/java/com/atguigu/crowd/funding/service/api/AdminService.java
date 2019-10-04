package com.atguigu.crowd.funding.service.api;

import com.atguigu.crowd.funding.entity.Admin;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface AdminService {

    List<Admin> getAll();

    void updateAdmin();

    Admin login(String loginAcct, String userPswd);

    PageInfo<Admin> queryForKeywordSearch(Integer pageNum,Integer pageSize,String keyword);

    void batchRemove(List<Integer> adminIdList);
}
