package com.stock.model.request;


import com.stock.model.ServiceRequest;
import com.stock.model.model.StockRankFilterItemModel;
import com.stock.model.model.StockRankResultModel;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/9/19 0019.
 * 排行详情的response
 */

public class StockRankDetailResquest  extends ServiceRequest{
    public int serviceCode = 2003;//服务号

    public String title = "";//界面标题，比如 本日融资融券的前十家公司
    public int search_relation;

    public  List<StockRankFilterItemModel> searchlist=new ArrayList<>();

}
