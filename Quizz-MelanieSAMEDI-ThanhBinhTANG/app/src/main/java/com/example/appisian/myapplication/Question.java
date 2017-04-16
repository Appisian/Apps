package com.example.appisian.myapplication;

import android.graphics.Color;

/**
 * Created by Appisian on 07/03/2017.
 */

public class Question {
    public String question;
    public int difficulty;
    public String difficulty_name;
    public String category;
    public String correct_answer;
    public int backgroundColor;

    public Question(String question, String difficulty_name, String category, String correct_answer) {
        this.question = question;
        this.difficulty_name = difficulty_name;
        switch (difficulty_name){
            case "easy":
                this.difficulty = 1;
                this.backgroundColor = Color.rgb(212, 153, 185);
                break;
            case "medium":
                this.difficulty = 2;
                this.backgroundColor = Color.rgb(144, 85, 162);
                break;
            case "hard":
                this.difficulty = 3;
                this.backgroundColor = Color.rgb(46, 41, 78);
                break;
            default:
                this.difficulty = 0;
                break;
        }
        this.category = category;
        this.correct_answer = correct_answer;
    }
}
