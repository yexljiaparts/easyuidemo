package com.bean;

import java.util.Collections;
import java.util.List;

/**
 * ${DESCRIPTION}
 * Created by Administrator on 2017/10/22.
 */
public class Pager <T>{
    protected List<T> rows = Collections.emptyList();

    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }
}
