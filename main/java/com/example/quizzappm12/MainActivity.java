package com.example.quizzappm12;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;


public class MainActivity extends AppCompatActivity {
  static   int x=0;
    FirebaseAuth mAuth;
    EditText email;
    EditText pwd;
    TextView tv;
    Button btn;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        tv=findViewById(R.id.tvRegister);
        btn=findViewById(R.id.blogin);
        email=findViewById(R.id.etLogin);
        pwd=findViewById(R.id.etPassword);

        mAuth=FirebaseAuth.getInstance();


        tv.setOnClickListener(v -> {
            Intent i=new Intent(this,SignUpActivity.class);
            startActivity(i);
        });
        btn.setOnClickListener(view -> {
            loginUser();
        });
    }


    private void loginUser(){
        String mail= email.getText().toString();
        String password=pwd.getText().toString();


        if(TextUtils.isEmpty(mail)){
            email.setError("Email cannot be empty");
            email.requestFocus();
        }else if(TextUtils.isEmpty(password)){
            pwd.setError("password cannot be empty");
            pwd.requestFocus();
        }else{
            mAuth.signInWithEmailAndPassword(mail,password).addOnCompleteListener(
                    new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if(task.isSuccessful()){
                                Toast.makeText(MainActivity.this,"Login successfully",Toast.LENGTH_SHORT).show();
                                startActivity(new Intent(MainActivity.this, QuizzActivity.class));
                            }
                            else{
                                Toast.makeText(MainActivity.this,"Login Failed",Toast.LENGTH_SHORT).show();
                            }
                        }
                    }
            );
        }

    }
}