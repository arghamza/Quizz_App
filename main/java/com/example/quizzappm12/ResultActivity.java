package com.example.quizzappm12;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.widget.Button;
import android.widget.ProgressBar;
import android.widget.TextView;

public class ResultActivity extends AppCompatActivity {
    ProgressBar progressBar;
    TextView progressText;
    Button btn,btn2;
    int i=0;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_result);
        btn=findViewById(R.id.retry);
        btn2=findViewById(R.id.quit);
        progressBar = findViewById(R.id.progress_bar);
        progressText = findViewById(R.id.progress_text);
        progressText.setText(Global.ivar1*50+"%");
        final Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if (i*50 <= Global.ivar1*50) {

                    progressBar.setProgress(i*50);
                    i++;
                    handler.postDelayed(this, Global.ivar1*50);
                } else {
                    handler.removeCallbacks(this);
                }
            }
        }, Global.ivar1*50);
        btn.setOnClickListener(view -> {
            Intent i=new Intent(this, QuizzActivity.class);
            Global.ivar1=0;
            startActivity(i);
        });
        btn2.setOnClickListener(view -> {
            Global.ivar1=0;
            this.finishAffinity();
        });
    }
}