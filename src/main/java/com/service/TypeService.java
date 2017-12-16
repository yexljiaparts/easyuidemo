package com.service;

import com.bean.Type;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * ${DESCRIPTION}
 * Created by Administrator on 2017/11/25.
 */
@Service
public class TypeService {

    public List<Type> list(){
        List<Type> list=new ArrayList<Type>();
        Type type=new Type();
        type.setId(1);
        type.setParentTypeId(0);
        type.setTypeName("first");
        list.add(type);

        Type type2=new Type();
        type2.setId(2);
        type2.setParentTypeId(1);
        type2.setTypeName("second");
        list.add(type2);


        Type type4=new Type();
        type4.setId(4);
        type4.setParentTypeId(2);
        type4.setTypeName("four");
        list.add(type4);

        Type type3=new Type();
        type3.setId(3);
        type3.setParentTypeId(0);
        type3.setTypeName("thrid");
        list.add(type3);
        return list;
    }
}
