package com.example.appisian.myapplication.questions;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.example.appisian.myapplication.Question;
import com.example.appisian.myapplication.R;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class QuestionsActivity extends AppCompatActivity {

    private RecyclerView recyclerView;
    final ArrayList<Question> questions = new ArrayList<>();
    String nb_questions = "10";
    String difficulty_parameters;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_questions);

        final ArrayList<Question> questions = new ArrayList<>();

        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        recyclerView = (RecyclerView) findViewById(R.id.question_list);
        recyclerView.setLayoutManager(layoutManager);

        Bundle extras = getIntent().getExtras();
        if (extras != null) {
            nb_questions = extras.getString("nb");
            difficulty_parameters = extras.getString("diff");

            this.fetchQuestions(nb_questions, difficulty_parameters);
        }
    }


    void fetchQuestions(final String numberOfQuestions, final String difficulty_parameters){
        RequestQueue queue = Volley.newRequestQueue(this);
        String url = "https://opentdb.com/api.php?amount="+ numberOfQuestions + difficulty_parameters;
        JsonObjectRequest jsonRequest = new JsonObjectRequest(Request.Method.GET, url, null, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                try {
                    JSONArray results = response.getJSONArray("results");
                    for(int i = 0; i < Integer.parseInt(numberOfQuestions); i++){
                        JSONObject item = results.getJSONObject(i);
                        questions.add(new Question(convertCharacter(item.getString("question")), item.getString("difficulty"), item.getString("category"), item.getString("correct_answer")));
                    }
                    CreateUi(questions);


                } catch(JSONException e) {
                    e.printStackTrace();
                }

            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {

            }
        });

        queue.add(jsonRequest);
    }

    protected void CreateUi(ArrayList<Question> questions) {
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        RecyclerView recyclerView = (RecyclerView) findViewById(R.id.question_list);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.setAdapter(new QuestionsAdapter(questions));
    }

    protected String convertCharacter(String string) {
        String result;
        result = string.replace("&quot;", "\"");
        result.replace("&eacute;", "é");
        return result.replace("&#039;", "'");
    }

}