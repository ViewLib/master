package com.xt.lxl.stock.page.list;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.xt.lxl.stock.R;
import com.xt.lxl.stock.listener.StockItemEditCallBacks;
import com.xt.lxl.stock.model.model.StockViewModel;
import com.xt.lxl.stock.util.HotelViewHolder;
import com.xt.lxl.stock.util.StockShowUtil;
import com.xt.lxl.stock.widget.view.StockTextView;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by xiangleiliu on 2017/8/5.
 */
public class StoctHistoryAdapter extends BaseAdapter {
    private LayoutInflater mInflater;
    private List<StockViewModel> mStockList = new ArrayList<>();
    private List<String> mSaveList = new ArrayList<>();
    private StockItemEditCallBacks mCallBacks;

    public StoctHistoryAdapter(Context context, StockItemEditCallBacks callBacks) {
        mInflater = (LayoutInflater) context
                .getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.mCallBacks = callBacks;
    }

    public void setData(List<StockViewModel> stockList) {
        mStockList = stockList;
    }

    public void setSaveList(List<String> saveList) {
        mSaveList = saveList;
    }

    @Override
    public int getCount() {
        return mStockList.size();
    }

    @Override
    public StockViewModel getItem(int position) {
        return mStockList.get(position);
    }

    @Override
    public long getItemId(int position) {
        return mStockList.get(position).hashCode();
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        if (convertView == null) {
            convertView = mInflater.inflate(R.layout.stock_item_history_item, parent, false);
        }
        bindData(convertView, getItem(position));
        return convertView;
    }

    private void bindData(View convertView, StockViewModel stockViewModel) {
        final TextView stockName = HotelViewHolder.requestView(convertView, R.id.stock_item_list_history_item_name);
        final TextView stockCode = HotelViewHolder.requestView(convertView, R.id.stock_item_list_history_item_code);
        final StockTextView stockAction = HotelViewHolder.requestView(convertView, R.id.stock_item_list_history_item_action);
        String defaultStr = "数据缺失";

        if (mSaveList.contains(stockViewModel.mStockCode)) {
            stockAction.setText("已添加");
        } else {
            int pixelFromDip = StockShowUtil.getPixelFromDip(convertView.getContext(), 15);
            stockAction.setText("");
            stockAction.setCompoundDrawable(convertView.getResources().getDrawable(R.drawable.stock_history_item_add),0,pixelFromDip,pixelFromDip);
            stockAction.setOnClickListener(mCallBacks.mActionCallBack);
        }
        stockAction.setTag(stockViewModel);
        HotelViewHolder.showTextOrDefault(stockName, stockViewModel.mStockName, defaultStr);
        HotelViewHolder.showTextOrDefault(stockCode, stockViewModel.mStockCode, defaultStr);
    }
}
