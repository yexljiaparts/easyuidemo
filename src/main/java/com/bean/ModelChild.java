package com.bean;

import java.util.List;

/**
 * ${DESCRIPTION}
 * Created by Administrator on 2017/11/25.
 */
public class ModelChild<T> {
    private T t;//当前分类
    private List<ModelChild> children ; //孩子分类
    private Integer level;

    public T getT() {
        return t;
    }

    public void setT(T t) {
        this.t = t;
    }

    public List<ModelChild> getChildren() {
        return children;
    }

    public void setChildren(List<ModelChild> children) {
        this.children = children;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }
}
