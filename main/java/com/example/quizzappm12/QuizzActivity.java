package com.example.quizzappm12;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.RadioButton;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.FirebaseFirestore;

public class QuizzActivity extends AppCompatActivity {
    Button btn;
    TextView tv,tv2;
    RadioButton rb1,rb2;
    String good=null;
    static int x=1;
    FirebaseFirestore db= FirebaseFirestore.getInstance();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_quizz);
        tv2=findViewById(R.id.tvnbQuest);
        btn=findViewById(R.id.bquizz1);
        tv=findViewById(R.id.tvQuest);
        rb1=findViewById(R.id.rb1);
        rb2=findViewById(R.id.rb2);
        tv2.setText("Question "+x);
        fetchdata(x);
        btn.setOnClickListener(view -> {
            x++;
            if(x<=2){
                checkAnswer(R.id.rb1,R.id.rb2);
                finish();
                startActivity(getIntent());
                }
            else{
                Intent i=new Intent(this,ResultActivity.class);
                checkAnswer(R.id.rb1,R.id.rb2);
                x=1;
                startActivity(i);}

        });
    }

    @Override
    protected void onStart() {
        super.onStart();
        fetchdata(x);
    }

    public void checkAnswer(int rb1, int rb2){
        RadioButton rb_1 = findViewById(rb1); // initiate a radio button
        Boolean rb1State = rb_1.isChecked();
        RadioButton rb_2 = findViewById(rb2); // initiate a radio button
        Boolean rb2State = rb_2.isChecked();
        if(rb_1.getText().equals(good) && rb1State)
            Global.ivar1++;
        if(rb_2.getText().equals(good) && rb2State)
            Global.ivar1++;
    }



    private void fetchdata(int i){
        String x= String.valueOf(i);
        DocumentReference document=db.collection("Questions").document(x);

        document.get().addOnSuccessListener(new OnSuccessListener<DocumentSnapshot>() {
            @Override
            public void onSuccess(DocumentSnapshot documentSnapshot) {
                if(documentSnapshot.exists()){
                    tv.setText(documentSnapshot.getString("Question"));
                    rb1.setText(documentSnapshot.getString("first_answer"));
                    rb2.setText(documentSnapshot.getString("second_answer"));
                    good=documentSnapshot.getString("good_answer");

                }
                else
                    Toast.makeText(QuizzActivity.this,"Row not found",Toast.LENGTH_SHORT).show();
            }
        }).addOnFailureListener(new OnFailureListener() {
            @Override
            public void onFailure(@NonNull Exception e) {
                Toast.makeText(QuizzActivity.this,"Failed to fetch data",Toast.LENGTH_SHORT).show();
            }
        });

    }
}
