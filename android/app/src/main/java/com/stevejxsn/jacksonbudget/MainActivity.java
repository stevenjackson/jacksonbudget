package com.stevejxsn.jacksonbudget;

import android.content.Context;
import android.os.Bundle;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Pair;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = (FloatingActionButton) findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });

    }

    @Override
    public void onStart() {
        super.onStart();

        List<BudgetCategory> data = new ArrayList();
        data.add(new BudgetCategory("foo", "123"));
        data.add(new BudgetCategory("bar", "456"));
        populateListView(data);
    }

    private void populateListView(List<BudgetCategory> data) {
        BudgetCategoryAdapter adapter = new BudgetCategoryAdapter(this, R.layout.budget_row, data);
        ListView listView = (ListView)findViewById(R.id.budgetItems);
        listView.setAdapter(adapter);
    }
}
