package com.stevejxsn.jacksonbudget;

import android.app.Activity;
import android.content.Context;
import android.support.annotation.NonNull;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.TextView;

import java.util.List;

public class BudgetCategoryAdapter extends ArrayAdapter<BudgetCategory> {

    private final int layoutResourceId;

    public BudgetCategoryAdapter(Context context, int layoutResourceId, List<BudgetCategory> data) {
        super(context, layoutResourceId, data);
        this.layoutResourceId = layoutResourceId;
    }

    @NonNull
    @Override
    public View getView(int position, View convertView, ViewGroup parent) {

        if (convertView == null) {
            convertView = inflateView(layoutResourceId, parent);
        }

        populateViewWithItemData(position, convertView);

        return convertView;
    }

    private View inflateView(int viewId, ViewGroup parent) {
        LayoutInflater inflater = ((Activity)getContext()).getLayoutInflater();
        return inflater.inflate(viewId, parent, false);
    }

    private void populateViewWithItemData(int position, View convertView) {
        BudgetCategory item = getItem(position);
        assert item != null;
        setText(convertView, R.id.txtLabel, item.label);
        setText(convertView, R.id.txtValue, item.value);
    }

    private void setText(View parent, int view_id, String text) {
        TextView textView = (TextView) parent.findViewById(view_id);
        textView.setText(text);
    }
}