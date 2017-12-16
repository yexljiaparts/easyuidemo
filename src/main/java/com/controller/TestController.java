package com.controller;

import com.bean.Pager;
import com.bean.Person;
import com.bean.Student;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * ${DESCRIPTION}
 * Created by Administrator on 2017/10/22.
 */
@Controller
public class TestController {
    @RequestMapping("/getData")
    @ResponseBody
    public String getPersons(){
        Pager<Person> result = new Pager<Person>();
        List<Person> num = new ArrayList<Person>();
        Person person ;
        for(int i=0;i<10;i++){
            person = new Person();
            person.setAge("1"+i);
            person.setName("骚一"+i+"号");
            person.setSex("male"+i);
            num.add(person);
        }
        result.setRows(num);
        return result.toString();
    }

    @RequestMapping("/testList")
    public String toList(){
        return "student";
    }



}
