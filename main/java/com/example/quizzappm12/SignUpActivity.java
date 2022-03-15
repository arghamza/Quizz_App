package com.example.quizzappm12;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.firebase.auth.AuthResult;
import com.google.firebase.auth.FirebaseAuth;

public class SignUpActivity extends AppCompatActivity {
    Button btn;
    EditText name;
    EditText email;
    EditText pwd;
    EditText confirm_pwd;

    FirebaseAuth mAuth;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sign_up);
        btn=findViewById(R.id.bregister);
        name=findViewById(R.id.etName);
        email=findViewById(R.id.etMail);
        pwd=findViewById(R.id.etpwd);
        confirm_pwd=findViewById(R.id.etConfirmPassword);

        mAuth =FirebaseAuth.getInstance();
        btn.setOnClickListener(v -> {
            createUser();
        });
    }

    private void createUser(){
        String mail= email.getText().toString();
        String password=pwd.getText().toString();
        String Name=name.getText().toString();
        String c_pwd=confirm_pwd.getText().toString();

        if(TextUtils.isEmpty(mail)){
            email.setError("Email cannot be empty");
            email.requestFocus();
        }else if(TextUtils.isEmpty(password)){
            pwd.setError("password cannot be empty");
            pwd.requestFocus();
        }else if(TextUtils.isEmpty(Name)){
            name.setError("Name cannot be empty");
            name.requestFocus();
        }/*else
            if(password!=c_pwd){
                confirm_pwd.setError("Name cannot be empty");
                confirm_pwd.requestFocus();
            }*/
            else{
            mAuth.createUserWithEmailAndPassword(mail,password).addOnCompleteListener(
                    new OnCompleteListener<AuthResult>() {
                        @Override
                        public void onComplete(@NonNull Task<AuthResult> task) {
                            if(task.isSuccessful()){
                                Toast.makeText(SignUpActivity.this,"User Registered",Toast.LENGTH_SHORT).show();
                                startActivity(new Intent(SignUpActivity.this,MainActivity.class));
                            }else{
                                Toast.makeText(SignUpActivity.this,"Registeration Failed"+task.getException().getMessage(),Toast.LENGTH_SHORT).show();
                            }
                        }
                    }
            );
        }
    }
}