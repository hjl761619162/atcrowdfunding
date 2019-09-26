package com.atguigu.crowd.funding.service.impl;

import com.atguigu.crowd.funding.entity.Admin;
import com.atguigu.crowd.funding.entity.AdminExample;
import com.atguigu.crowd.funding.mapper.AdminMapper;
import com.atguigu.crowd.funding.service.api.AdminService;
import com.atguigu.crowd.funding.util.CrowdFundingUtils;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public List<Admin> getAll() {
        return adminMapper.selectByExample(new AdminExample());
    }

    @Override
    public void updateAdmin() {
        adminMapper.updateByPrimaryKeySelective(new Admin(1,"herry2","123","哈利2","herry2@qq.com",null));
        adminMapper.updateByPrimaryKeySelective(new Admin(2,"poter2","123","波特2","poter2@qq.com",null));

    }

    @Override
    public Admin login(String loginAcct, String userPswd) {

        //根据loginAcct查询数据库
        AdminExample adminExample = new AdminExample();
        adminExample.createCriteria().andLoginAcctEqualTo(loginAcct);

        //执行查询
        List<Admin> list = adminMapper.selectByExample(adminExample);

        if (!CrowdFundingUtils.collectionEffective(list)){
            //如果查询集合无效，则直接返回Null
            return null;
        }

        //获取唯一集合元素，账号是唯一
        Admin admin = list.get(0);

        //确认admin不为null
        if (admin == null){
            return null;
        }

        //如果admin账号不为Null, 就查询数据库来比较密码,数据库数据为密文
        String userPswdDataBase = admin.getUserPswd();

        //将前台传入的密码明文转换成md5密文
        String userPswdBroswer = CrowdFundingUtils.md5(userPswd);

        //比较前台密码和数据库密码是否相同
        if (Objects.equals(userPswdBroswer,userPswdDataBase)){
            //如果两个密码相同 返回admin对象，登录成功
            return admin;
        }

        return null;
    }

    @Override
    public PageInfo<Admin> queryForKeywordSearch(Integer pageNum, Integer pageSize, String keyword) {

        //1.调用PagerHelper的工具方法，开启分页功能
        PageHelper.startPage(pageNum,pageSize);

        //2.执行分页查询
        List<Admin> list = adminMapper.selectAdminListByKeyword(keyword);

        //3.将list封装到PageInfo对象中
        return new PageInfo<>(list);
    }

}
