package com.test.calcularimc;

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

    private EditText alt;
    private EditText peso;

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

        alt = (EditText) findViewById(R.id.altEdit);
        peso = (EditText) findViewById(R.id.pesoEdit);
    }

    public void calcIMC(View e){

        double alturaIMC = Double.parseDouble(alt.getText().toString()) / 100;
        double pesoIMC = Double.parseDouble(peso.getText().toString());

        double imc = pesoIMC / (alturaIMC * alturaIMC);

        Toast.makeText(this, "O Seu IMC É :" + imc, Toast.LENGTH_SHORT).show();
    }
}