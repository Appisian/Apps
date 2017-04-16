package com.example.appisian.myapplication;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.RadioButton;
import android.widget.SeekBar;
import android.widget.Spinner;
import android.widget.TextView;

import com.example.appisian.myapplication.questions.QuestionsActivity;

public class MainActivity extends AppCompatActivity {

    TextView myTextView;
    SeekBar actionSeekBar;
    Button nextViewBtn;
    String nbSeekbar = "10";

    RadioButton checkboxEasy;
    RadioButton checkboxMedium;
    RadioButton checkboxHard;
    RadioButton checkboxDefault;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        this.setContentView(R.layout.activity_main);

        checkboxEasy = (RadioButton) findViewById(R.id.checkbox_easy);
        checkboxMedium = (RadioButton) findViewById(R.id.checkbox_medium);
        checkboxHard = (RadioButton) findViewById(R.id.checkbox_hard);
        checkboxDefault = (RadioButton) findViewById(R.id.Default);

        checkboxDefault.setChecked(true);

        myTextView = (TextView) this.findViewById(R.id.numberView); // Final -> N'est pas changer
        actionSeekBar = (SeekBar) this.findViewById(R.id.seekBar);
        actionSeekBar.setMax(10);
        actionSeekBar.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener(){
            @Override
            public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
                nbSeekbar = String.valueOf(progress);
                myTextView.setText(String.valueOf(progress));
            }

            @Override
            public void onStartTrackingTouch(SeekBar seekBar) {

            }

            @Override
            public void onStopTrackingTouch(SeekBar seekBar) {

            }
        });

        nextViewBtn = (Button) this.findViewById(R.id.buttonView);

        nextViewBtn.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {

                Intent intentApp = new Intent(getApplicationContext(),
                        QuestionsActivity.class);

                String difficulty_parameters = "";

                if(checkboxEasy.isChecked()){
                    difficulty_parameters = "&difficulty=easy";
                }
                if(checkboxMedium.isChecked()){
                    difficulty_parameters = "&difficulty=medium";
                }
                if(checkboxHard.isChecked()){
                    difficulty_parameters = "&difficulty=hard";
                }

                intentApp.putExtra("nb", nbSeekbar);
                intentApp.putExtra("diff", difficulty_parameters);

                startActivity(intentApp);


            }
        });



    }




}
