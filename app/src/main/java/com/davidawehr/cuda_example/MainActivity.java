package com.davidawehr.cuda_example;

import android.app.ActionBar;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import java.util.Random;


public class MainActivity extends ActionBarActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    public void doAdd(View v) {
        Random gen = new Random(System.currentTimeMillis());
        final int NUM_ELEMS = 50000;
        final int MAX_DISP = 50;
        float[] a = new float[NUM_ELEMS];
        float[] b = new float[NUM_ELEMS];
        for (int i = 0; i != NUM_ELEMS; ++i) {
            a[i] = gen.nextFloat();
            b[i] = gen.nextFloat();
        }
        float[] sum = JNINative.addArrays(a, b);


        LinearLayout.LayoutParams lparams = new LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.WRAP_CONTENT, LinearLayout.LayoutParams.WRAP_CONTENT
        );
        int numToDisp = Math.min(NUM_ELEMS, MAX_DISP);
        LinearLayout col1 = (LinearLayout) findViewById(R.id.col1);
        LinearLayout col2 = (LinearLayout) findViewById(R.id.col2);
        LinearLayout col3 = (LinearLayout) findViewById(R.id.col3);
        col1.removeAllViews();
        col2.removeAllViews();
        col3.removeAllViews();
        for (int i = 0; i != numToDisp; ++i) {
            TextView t1 = new TextView(this);
            t1.setLayoutParams(lparams);
            t1.setText(Float.toString(a[i]));
            col1.addView(t1);

            TextView t2 = new TextView(this);
            t2.setLayoutParams(lparams);
            t2.setText(Float.toString(b[i]));
            col2.addView(t2);

            TextView t3 = new TextView(this);
            t3.setLayoutParams(lparams);
            t3.setText(Float.toString(sum[i]));
            col3.addView(t3);
        }
    }
}