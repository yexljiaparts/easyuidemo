package com.controller;

import com.bean.Type;
import com.bean.TypeView;
import com.bean.User;
import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;
import com.service.TypeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

/**
 * ${DESCRIPTION}
 * Created by Administrator on 2017/11/20.
 */
@Controller
@RequestMapping(value = "/Freemarker")
public class TestFreemarker {


    @Resource
    private TypeService typeService;
    @RequestMapping(value = "/testFreemarker")
    @ResponseBody
    public ModelAndView testFreemarker(@RequestParam(value = "a", required = false) String a) throws Exception {
        ModelAndView mv = new ModelAndView();

        User user = new User("may", 21);

        List<String> list = new ArrayList<String>();
        list.add("Jack1");
        list.add("Jack2");
        list.add("Jack3");

        mv.addObject("list", list);
        mv.addObject("user", user);
        mv.addObject("param", new String(a.getBytes("iso8859-1"), "utf-8"));
        mv.setViewName("may");
        return mv;
    }


    @RequestMapping("/list")
    public ModelAndView listTypes (HttpServletRequest request){
        List<Type> types = typeService.list();//代码省略，功能：从db中获取需要的分类
        Multimap<Integer,Type> typeMultimap = ArrayListMultimap.create(); //使用google guava 包 对以获取的分类按照父类Id进行组装
        for(int i=0 ;i<types.size();i++){
            typeMultimap.put(types.get(i).getParentTypeId(), types.get(i));
        }
        List<TypeView> list = new ArrayList<TypeView>();

        list = subType(0,typeMultimap,0);//递归调用 生成当前节点的子节点
        print(list,0);

        ModelAndView model = new ModelAndView("/testTree2");
        model.addObject("types", list);
        return model;
    }


    @RequestMapping("/main")
    public String main (HttpServletRequest request){
        return "/main";
    }


    @RequestMapping("/testClick")
    public String testClick (HttpServletRequest request){
        return "/treeClick";
    }

    /**
     * 递归处理多级分类问题
     * @param parentId 父类Id
     * @param maps  所有分类的按照父类ID组装后容器
     * @param level 分类的级别 0：根
     * @return 返回 parentId 节点的子分类节点【可能是多个】
     */
    public  List<TypeView> subType(Integer parentId, Multimap<Integer,Type> maps,int level){
        List<TypeView> list = new ArrayList<TypeView>();
        Collection<Type> trList = maps.get(parentId);
        for(Iterator<Type> iterator = trList.iterator(); iterator.hasNext();){
            Type typeTemp = iterator.next();
            TypeView typeView = new TypeView();
            typeView.setType(typeTemp);
            typeView.setLevel(level);
            list.add(typeView);
            typeView.setChildren(subType(typeTemp.getId(),maps,level+1));
        }

        if(list.isEmpty()){
            return null;
        }else{
            return list;
        }
    }
    //打印当前归类好的分类
    private void print(List<TypeView> list,int level) {
        if(list==null ||list.isEmpty()){
            return ;
        }
        for (Iterator<TypeView> iterator = list.iterator(); iterator.hasNext();) {
            TypeView typeView = iterator.next();
            Type type = typeView.getType();
            System.out.println("目录等级:"+typeView.getLevel()+"----"+type.getTypeName());
            print(typeView.getChildren(),level+1);

        }
    }
}
