package com.bean;

import java.util.List;

/**
 * 用来组装分类之间的父子关系
 * Created by Administrator on 2017/11/25.
 */
public class TypeView {
    private Type type;//当前分类
    private List<TypeView> children ; //孩子分类
    private Integer level;

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public List<TypeView> getChildren() {
        return children;
    }

    public void setChildren(List<TypeView> children) {
        this.children = children;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }
}
