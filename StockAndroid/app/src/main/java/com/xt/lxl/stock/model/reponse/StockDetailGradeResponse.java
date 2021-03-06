package com.xt.lxl.stock.model.reponse;


import com.xt.lxl.stock.model.ServiceResponse;
import com.xt.lxl.stock.model.model.StockDetailGradleModel;

import java.util.ArrayList;
import java.util.List;

public class StockDetailGradeResponse extends ServiceResponse {
    public int serviceCode = 2008;//服务号
    public String stockCode = "";//股票代码
    public String moduleName = "券商评级";//模块名称
    public List<StockDetailGradleModel> gradleModelList = new ArrayList<>();
}
