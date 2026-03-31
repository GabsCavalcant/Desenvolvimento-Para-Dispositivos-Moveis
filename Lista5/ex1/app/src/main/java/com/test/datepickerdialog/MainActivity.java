package com.test.datepickerdialog;

import android.app.DatePickerDialog;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import java.util.Calendar;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_main);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.date), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });



    }


    public void exibirDatePickerDialog(View v){

                TextView text = findViewById(R.id.idTEXT);

             Calendar calendario = Calendar.getInstance();

                    DatePickerDialog p = new DatePickerDialog(
                            this,
                            (view,year,month,day_of_month) -> {
                                String data = day_of_month + "/"+month + "/" + year;
                                Toast.makeText(this, data, Toast.LENGTH_SHORT).show();
                                text.setText(data);
                            },
                            calendario.get(Calendar.YEAR),
                            calendario.get(Calendar.MONTH),
                            calendario.get(Calendar.DAY_OF_MONTH)


                    );

                        p.show();
                };


}