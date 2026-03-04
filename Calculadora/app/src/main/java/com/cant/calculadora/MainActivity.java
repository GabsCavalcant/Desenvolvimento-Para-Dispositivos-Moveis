package com.cant.calculadora;

import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class MainActivity extends AppCompatActivity {

private EditText n1;
private EditText n2;

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

        n1 = findViewById(R.id.n1Edit);
        n2 = findViewById(R.id.n2Edit);
    }

    public void somar(View e ){
        int resp = Integer.parseInt(n1.getText().toString()) + Integer.parseInt(n2.getText().toString());

        Toast.makeText(this, "A soma é :" + resp, Toast.LENGTH_SHORT).show();
    }
    public void div(View e ){



        int resp = Integer.parseInt(n1.getText().toString()) / Integer.parseInt(n2.getText().toString());

        Toast.makeText(this, "A div é :" + resp, Toast.LENGTH_SHORT).show();


    }
    public void mult(View e ){
        int resp = Integer.parseInt(n1.getText().toString()) * Integer.parseInt(n2.getText().toString());

        Toast.makeText(this, "A mult é :" + resp, Toast.LENGTH_SHORT).show();
    }
    public void sub(View e ){
        int resp = Integer.parseInt(n1.getText().toString()) - Integer.parseInt(n2.getText().toString());

        Toast.makeText(this, "A subb é :" + resp, Toast.LENGTH_SHORT).show();
    }
}