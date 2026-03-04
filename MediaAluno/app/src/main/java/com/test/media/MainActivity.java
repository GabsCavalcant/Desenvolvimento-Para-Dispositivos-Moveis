package com.test.media;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

    private EditText n1;
    private EditText n2;
    private EditText n3;
    private EditText n4;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });

        n1 = (EditText) findViewById(R.id.n1Text);
        n2 = (EditText) findViewById(R.id.n2Text);
        n3 = (EditText) findViewById(R.id.n3Text);
        n4 = (EditText) findViewById(R.id.n4Text);

    }
    public void calcMedia(View e){
        double n1Calc = Double.parseDouble(n1.getText().toString());
        double n2Calc = Double.parseDouble(n2.getText().toString());
        double n3Calc = Double.parseDouble(n3.getText().toString());
        double n4Calc = Double.parseDouble(n4.getText().toString());

        double calc = (n1Calc + n2Calc + n3Calc + n4Calc ) / 4;

        Toast.makeText (this, "A média do Aluno é : " + calc, Toast.LENGTH_SHORT).show();


    }

}