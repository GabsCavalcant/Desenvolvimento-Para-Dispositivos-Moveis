package com.test.desafio_orientadoobjeto;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;





public class MainActivity extends AppCompatActivity {


    private EditText id;
    private EditText nome;
    private EditText idade;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;


        }
        );



         id = (EditText) findViewById(R.id.idEdit);
         nome = (EditText) findViewById(R.id.nomeEdit);
         idade = (EditText) findViewById(R.id.idadeEdit);

        Button cadastrar = (Button) findViewById(R.id.cadastrar);
        cadastrar.setOnClickListener(new View.OnClickListener() {


            @Override
            public void onClick(View arg0) {

                Pessoa p = cadastrar(arg0);

                Intent intent = new Intent(MainActivity.this, SegundaTela.class);
                intent.putExtra("Pessoa", p);

                startActivity(intent);

            }
        });

    }



    public Pessoa cadastrar(View e){
        Pessoa p = new Pessoa();

        p.setId(Integer.parseInt( id.getText().toString()));
        p.setName(nome.getText().toString());
        p.setAge(Integer.parseInt(idade.getText().toString()));

        return p;

    }

}