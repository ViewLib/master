package com.stock.dao;

import com.stock.model.model.*;

import java.util.List;

public interface StockDao {
    /**
     * 查询排行列表
     * @return
     */
    public List<StockSearchModel> selectSerchModelRankList(int showType, int limit);

    List<StockSyncModel> selectSyncModelList(int version);

    public List<StockRankResultModel> selectRankDetailModelList(int version);

    public List<StockRankFilterModel> selectStockFilterList(int first_type);

    public List<StockFirstTypeModel> selectStockFirstTypList(int version);

    public List<StockDetailDataModel> selectStocDetailkDataList(String stoclCode, String sqlCode);
}
